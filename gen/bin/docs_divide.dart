import 'dart:io';

const maxLinePerTask = 1000;

void main() async {
  print('Starting analysis...');
  // run "flutter analyze --no-preamble --no-congratulate --no-pub --no-suggestions --write gen/log/analyze.txt"
  await Process.run('flutter', [
    'analyze',
    '--no-preamble',
    '--no-congratulate',
    '--no-pub',
    '--no-suggestions',
    '--write',
    'gen/log/analyze.txt',
  ], runInShell: true);
  // print result stdout and stderr
  print('Analysis complete');
  // replace "[info] Missing documentation for a public member (" and ")" with empty string
  final analyzeLog = File('gen/log/analyze.txt');
  String content = await analyzeLog.readAsString();
  content = content.replaceAll(
    RegExp(r'\[info\] Missing documentation for a public member \('),
    '',
  );
  content = content.replaceAll(RegExp(r'\)'), '');
  // replace absolute path with relative path from project root
  final projectDir = Directory.current.path;
  print('Project directory: $projectDir');
  content = content.replaceAll('$projectDir\\', '');
  content = content.replaceAll('$projectDir/', '');
  await analyzeLog.writeAsString(content);
  // "C:\Users\LQQ\shadcn_flutter\shadcn_flutter\lib\src\animation.dart:385:10"
  // group by file path, and then split parts into files (/gen/log/analyze_parts/)
  // but if a part has less than maxLinePerTask lines, then keep adding until it reaches maxLinePerTask
  // tolerate last part to have less than maxLinePerTask lines
  final lines = content
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .toList();

  // Parse analyzer lines -> map of file -> set of unique target lines (as code text)
  final Map<String, List<String>> fileMap = {};
  final Map<String, List<String>> fileCache = {}; // os-path -> file lines
  final Set<String> seen = {}; // dedupe by file:lineNumber

  final regex = RegExp(r'^(.+\.dart):(\d+):(\d+)');
  for (final raw in lines) {
    final match = regex.firstMatch(raw);
    if (match == null) continue;

    String filePath = match.group(
      1,
    )!; // as written by analyzer (likely relative)
    final lineNoStr = match.group(2)!;
    final lineNo = int.tryParse(lineNoStr);
    if (lineNo == null || lineNo <= 0) continue;

    // Normalize for output (forward slashes) and for file IO (OS separator)
    final normalizedPath = filePath.replaceAll('\\', '/');
    final osPath = filePath
        .replaceAll('\\', Platform.pathSeparator)
        .replaceAll('/', Platform.pathSeparator);

    // Deduplicate the same file:line number
    final key = '$normalizedPath:$lineNo';
    if (seen.contains(key)) continue;

    // Read file lines (cached)
    List<String> fileLines = fileCache[osPath] ?? [];
    if (fileLines.isEmpty) {
      final f = File(osPath);
      if (!f.existsSync()) {
        // try alternative normalized path style
        final altPath = normalizedPath
            .replaceAll('/', Platform.pathSeparator)
            .replaceAll('\\', Platform.pathSeparator);
        final f2 = File(altPath);
        if (f2.existsSync()) {
          fileLines = await f2.readAsLines();
        } else {
          // Fallback: cannot read file, skip
          continue;
        }
      } else {
        fileLines = await f.readAsLines();
      }
      fileCache[osPath] = fileLines;
    }

    String codeLine;
    if (lineNo - 1 >= 0 && lineNo - 1 < fileLines.length) {
      codeLine = fileLines[lineNo - 1].trimRight();
    } else {
      // Out of range; fallback to the raw message without analyzer metadata
      // Remove the leading path:line:col portion
      codeLine = raw.replaceFirst(regex, '').trim();
    }

    final output = '$normalizedPath:$lineNo:$codeLine';
    fileMap.putIfAbsent(normalizedPath, () => []);
    fileMap[normalizedPath]!.add(output);
    seen.add(key);
  }
  final partsDir = Directory('gen/log/analyze_parts');
  if (!partsDir.existsSync()) {
    partsDir.createSync(recursive: true);
  } else {
    partsDir.deleteSync(recursive: true);
    partsDir.createSync(recursive: true);
  }
  int partIndex = 0;
  List<List<String>> parts = [];
  for (final entry in fileMap.entries) {
    bool exceeded = false;
    List<String> currentFileLines;
    if (partIndex < parts.length) {
      currentFileLines = parts[partIndex];
    } else {
      currentFileLines = ['TODO:'];
      parts.add(currentFileLines);
    }
    for (final output in entry.value) {
      if (currentFileLines.length >= maxLinePerTask) {
        exceeded = true;
      }
      currentFileLines.add('- [ ] ${output.trim()}');
    }
    if (exceeded) {
      partIndex++;
    }
  }
  for (int i = 0; i < parts.length; i++) {
    final partFile = File('gen/log/analyze_parts/part_$i.md');
    await partFile.writeAsString(parts[i].join('\n'));
  }
  print('Analysis parts created in gen/log/analyze_parts/');
}
