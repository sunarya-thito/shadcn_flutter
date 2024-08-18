import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:yaml_edit/yaml_edit.dart';

import 'font.dart';

final _parser = ArgParser()
  ..addFlag(
    'install-geist-sans',
    defaultsTo: false,
    help: 'Install Geist Sans font.',
  )
  ..addFlag(
    'install-geist-mono',
    defaultsTo: false,
    help: 'Install Geist Mono font.',
  )
  ..addFlag(
    'install-radix-icons',
    defaultsTo: false,
    help: 'Install Radix Icons.',
  )
  ..addFlag(
    'install-bootstrap-icons',
    defaultsTo: false,
    help: 'Install Bootstrap Icons.',
  )
  ..addFlag(
    'install-preloader',
    defaultsTo: false,
    help: 'Install Web Preloader.',
  )
  ..addFlag(
    'install-all',
    defaultsTo: false,
    help: 'Install all features.',
  );

void _printHelp([String? message]) {
  if (message != null) {
    print(message);
  }
  print('Usage: shadcn_flutter [options]');
  print(_parser.usage);
}

main(List<String> args) {
  final ArgResults results;
  try {
    results = _parser.parse(args);
  } on FormatException catch (e) {
    _printHelp(e.message);
    return;
  }
  if (results['install-all']) {
    setupProject(
      installGeistSans: true,
      installGeistMono: true,
      installRadixIcons: true,
      installBootstrapIcons: true,
      installPreloader: true,
    );
    return;
  }
  bool argInstallGeistSans = results['install-geist-sans'];
  bool argInstallGeistMono = results['install-geist-mono'];
  bool argInstallRadixIcons = results['install-radix-icons'];
  bool argInstallBootstrapIcons = results['install-bootstrap-icons'];
  bool argInstallPreloader = results['install-preloader'];
  if (argInstallGeistSans ||
      argInstallGeistMono ||
      argInstallRadixIcons ||
      argInstallBootstrapIcons ||
      argInstallPreloader) {
    setupProject(
      installGeistSans: argInstallGeistSans,
      installGeistMono: argInstallGeistMono,
      installRadixIcons: argInstallRadixIcons,
      installBootstrapIcons: argInstallBootstrapIcons,
      installPreloader: argInstallPreloader,
    );
    return;
  }
  print('======================================');
  print('Setup Shadcn Flutter Project');
  print('======================================');
  print('Would you like to add Shadcn Flutter to your project?');
  print('This will add "shadcn_flutter" to your pubspec.yaml file.');
  print('[Y]es or [N]o');
  int addShadcn = askForChoices(['y', 'n']);
  if (addShadcn == 1) {
    print('Shadcn Flutter will not be added to your project. Bye!');
    return;
  }
  print('======================================');
  print('Would you like to install Geist Sans font? (Recommended)');
  print(
      'Geist/Geist Mono font is a beautiful font that is used in Shadcn Flutter project.');
  print(
      'Without this font, you would need to set the default font in your project.');
  print('[Y]es or [N]o');
  int installFont = askForChoices(['y', 'n']);
  print('======================================');
  print('Would you like to install Geist Mono font?');
  print('This is a monospaced font that is used in Shadcn Flutter project.');
  print(
      'If you are using CodeSnippet widget, then it is highly recommended to install this font.');
  print('[Y]es or [N]o');
  int installMonoFont = askForChoices(['y', 'n']);
  print('======================================');
  print('Would you like to install Radix Icons? (Recommended)');
  print(
      'This is an additional icons you can use besides Material/Cupertino Icons.');
  print('[Y]es or [N]o');
  int installIcons = askForChoices(['y', 'n']);
  print('======================================');
  print('Would you like to install Bootstrap Icons?');
  print(
      'Bootstrap Icons provides a set of icons that can be used in your project.');
  print('You can see the list of icons at https://icons.getbootstrap.com/');
  print('[Y]es or [N]o');
  int installBootstrapIcons = askForChoices(['y', 'n']);
  print('======================================');
  print('Would you like to install Web Preloader?');
  print(
      'This will replace old boring default flutter web preloader with a new cool preloader.');
  print('[Y]es or [N]o');
  int installPreloader = askForChoices(['y', 'n']);
  print('======================================');
  setupProject(
    installGeistSans: installFont == 0,
    installGeistMono: installMonoFont == 0,
    installRadixIcons: installIcons == 0,
    installBootstrapIcons: installBootstrapIcons == 0,
    installPreloader: installPreloader == 0,
  );
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

int askForChoices(List<String> options, [bool lowercase = true]) {
  while (true) {
    var input = stdin.readLineSync();
    if (input == null) {
      print('Invalid input, please try again.');
      continue;
    }
    input = input.trim();
    if (lowercase) {
      input = input.toLowerCase();
    }
    for (var i = 0; i < options.length; i++) {
      if (input == options[i]) {
        return i;
      }
    }
    print('Invalid input, please try again.');
  }
}

void setupProject({
  required bool installGeistSans,
  required bool installGeistMono,
  required bool installRadixIcons,
  required bool installBootstrapIcons,
  required bool installPreloader,
}) async {
  File pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    print(
        'pubspec.yaml file not found. Please run this script in your project directory.');
    exit(1);
  }
  print('Setting up project...');
  YamlEditor editor = YamlEditor(pubspec.readAsStringSync());
  bool hasChanges = false;
  try {
    var latestVersion = await getLatestPackageVersion();
    if (latestVersion != null) {
      print('Installing shadcn_flutter:^$latestVersion...');
    } else {
      print('Installing shadcn_flutter...');
      print(
          'WARNING: Failed to get the latest version of shadcn_flutter. You might want to check the version to make sure you are using the latest version.');
    }
    if (latestVersion != null) {
      editor.update(['dependencies', 'shadcn_flutter'], '^$latestVersion');
      hasChanges = true;
    } else {
      var process = await Process.start(
          'flutter',
          [
            'pub',
            'add',
            'shadcn_flutter',
          ],
          runInShell: true);
      process.stdout.transform(utf8.decoder).listen((data) {
        print(data);
      });
      process.stderr.transform(utf8.decoder).listen((data) {
        print(data);
      });
      int exitCode = await process.exitCode;
      if (exitCode != 0) {
        print('Failed to add shadcn_flutter to pubspec.yaml.');
        exit(1);
      }
    }
  } catch (e, stackTrace) {
    print('Failed to add shadcn_flutter to pubspec.yaml.');
    print(e);
    print(stackTrace);
    exit(1);
  }
  if (installGeistSans) {
    print('Installing Geist Sans font...');
    hasChanges |= installFont(editor, kGeistSansFont);
  }
  if (installGeistMono) {
    print('Installing Geist Mono font...');
    hasChanges |= installFont(editor, kGeistMonoFont);
  }
  if (installRadixIcons) {
    print('Installing Radix Icons...');
    hasChanges |= installFont(editor, kRadixIcons);
  }
  if (installBootstrapIcons) {
    print('Installing Bootstrap Icons...');
    hasChanges |= installFont(editor, kBootstrapIcons);
  }
  if (installPreloader) {
    print('Installing Web Preloader...');
    Directory webDir = Directory('web');
    if (!webDir.existsSync()) {
      print('Creating web directory...');
      // exec: flutter create . --platforms=web
      try {
        var runSync = Process.runSync(
            'flutter', ['create', '.', '--platforms=web'],
            runInShell: true);
        if (runSync.exitCode != 0) {
          print('Failed to create web directory.');
          exit(1);
        }
      } catch (e, stackTrace) {
        print('Failed to create web directory.');
        print(e);
        print(stackTrace);
        exit(1);
      }
    }
    File file = File('web/flutter_bootstrap.js');
    String downloadUrl =
        'https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs/web/flutter_bootstrap.js';
    try {
      var response = await http.get(Uri.parse(downloadUrl));
      if (response.statusCode == 200) {
        if (file.existsSync()) {
          print('WARNING: Overwriting existing web preloader file.');
        }
        file.writeAsStringSync(response.body);
      } else {
        print('Failed to download web preloader file.');
      }
    } catch (e, stackTrace) {
      print('Failed to download web preloader file.');
      print(e);
      print(stackTrace);
      exit(1);
    }
  }
  if (hasChanges) {
    pubspec.writeAsStringSync(editor.toString());
    // exec: flutter pub get
    Process start =
        await Process.start('flutter', ['pub', 'get'], runInShell: true);
    start.stdout.transform(utf8.decoder).listen((data) {
      print(data);
    });
    start.stderr.transform(utf8.decoder).listen((data) {
      print(data);
    });
    int exitCode = await start.exitCode;
    if (exitCode != 0) {
      print('Failed to run "flutter pub get".');
      exit(1);
    }
  }
  print('Project setup completed.');
}

bool installFont(YamlEditor editor, ShadcnFontFamily font) {
  // check if "fonts" exists
  // if not, add "fonts" to the yaml
  var pubspec = editor.parseAt([]);
  Map pubspecMap = pubspec.value;
  List fonts = has(pubspecMap, ['flutter', 'fonts'])
      ? List.from(getValue(pubspecMap, ['flutter', 'fonts']))
      : [];
  for (final entry in fonts) {
    String family = entry['family'];
    if (family == font.family) {
      print('Font ${font.family} already exists in pubspec.yaml');
      return false;
    }
  }
  // add font to "fonts"
  Map fontMap = {
    'family': font.family,
    'fonts': [
      for (final f in font.fonts)
        {
          'asset': f.asset,
          if (f.weight != null) 'weight': f.weight,
        }
    ],
  };
  fonts.add(fontMap);
  editor.update(['flutter', 'fonts'], fonts);
  return true;
}

dynamic getValue(map, List<String> path) {
  for (int i = 0; i < path.length - 1; i++) {
    map = map[path[i]];
  }
  return map[path.last];
}

Map getMap(Map map, List<String> path) {
  for (var key in path) {
    map = map[key];
  }
  return map;
}

bool has(dynamic map, List<String> path) {
  for (var key in path) {
    if (!map.containsKey(key)) {
      return false;
    }
    map = map[key];
  }
  return true;
}
