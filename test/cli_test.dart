import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

main() {
  late Directory tempDir;
  late String latestVersion;
  setUp(() async {
    // create a temp directory
    tempDir = Directory.systemTemp.createTempSync();
    // create a temp flutter project
    var createProjectResult = Process.runSync(
      'flutter',
      ['create', 'temp'],
      workingDirectory: tempDir.path,
      runInShell: true,
    );
    if (createProjectResult.exitCode != 0) {
      throw Exception('Failed to create a temp flutter project.');
    }
    var cliDartToolDir =
        Directory('${Directory.current.path}/shadcn_flutter_cli/.dart_tool');
    // delete cache directory
    cliDartToolDir.deleteSync(recursive: true);

    // activate the executable
    var activateResult = Process.runSync(
      'dart',
      [
        'pub',
        'global',
        'activate',
        '--source',
        'path',
        './shadcn_flutter_cli',
        '--overwrite',
      ],
      runInShell: true,
    );
    if (activateResult.exitCode != 0) {
      throw Exception('Failed to activate the executable.');
    }

    latestVersion = (await getLatestPackageVersion())!;
  });
  test('install shadcn_flutter', () {
    var process = Process.runSync(
      'shadcn_flutter',
      [
        '--install-all',
      ],
      workingDirectory: '${tempDir.path}/temp',
      runInShell: true,
    );
    expect(process.exitCode, 0);

    var pubspecFile = File('${tempDir.path}/temp/pubspec.yaml');
    var pubspecContent = pubspecFile.readAsStringSync();

    // check if the pubspec.yaml file contains the shadcn_flutter package
    expect(pubspecContent, contains('shadcn_flutter: ^$latestVersion'));
  });
  tearDown(() async {
    await Future.delayed(const Duration(seconds: 1));
    // delete the temp directory
    tempDir.deleteSync(recursive: true);
  });
}

Future<String?> getLatestPackageVersion() async {
  const apiUrl = 'https://pub.dev/api/packages/shadcn_flutter';
  var response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['latest']['version'];
  }
  return null;
}
