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
  await analyzeLog.writeAsString(content);
  // "C:\Users\LQQ\shadcn_flutter\shadcn_flutter\lib\src\animation.dart:385:10"
  // group by file path, and then split parts into files (/gen/log/analyze_parts/)
  // but if a part has less than maxLinePerTask lines, then keep adding until it reaches maxLinePerTask
  // tolerate last part to have less than maxLinePerTask lines
  final lines = content
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .toList();
  final Map<String, List<String>> fileMap = {};
  for (final line in lines) {
    final filePath = line.split(':').first;
    fileMap.putIfAbsent(filePath, () => []).add(line);
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
    for (final line in entry.value) {
      if (currentFileLines.length >= maxLinePerTask) {
        exceeded = true;
      }
      currentFileLines.add('- [ ] ${line.trim()}');
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
