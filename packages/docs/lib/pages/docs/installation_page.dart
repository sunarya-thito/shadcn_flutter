import 'package:docs/code_highlighter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../docs_page.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({super.key});

  @override
  InstallationPageState createState() => InstallationPageState();
}

class InstallationPageState extends State<InstallationPage> {
  final OnThisPage _manualKey = OnThisPage();
  final OnThisPage _companionKey = OnThisPage();
  final OnThisPage _experimentalKey = OnThisPage();
  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'installation',
      onThisPage: {
        'Stable Version': _manualKey,
        'Material and Cupertino': _companionKey,
        'Experimental Version': _experimentalKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Installation').h1(),
          const Text('Install and configure shadcn_flutter in your project.')
              .lead(),
          const Text('Stable Version').h2().anchored(_manualKey),
          const Gap(32),
          Steps(
            children: [
              StepItem(
                title: const Text('Creating a new Flutter project'),
                content: [
                  const Text(
                          'Create a new Flutter project using the following command:')
                      .p(),
                  const CodeBlock(
                    code: 'flutter create my_app\ncd my_app',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Adding the dependency'),
                content: [
                  const Text(
                          'Next, add the shadcn_flutter dependency to your project.')
                      .p(),
                  const CodeBlock(
                    code: 'flutter pub add shadcn_flutter',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Importing the package'),
                content: [
                  const Text(
                          'Now, you can import the package in your Dart code.')
                      .p(),
                  const CodeBlock(
                    code:
                        'import \'package:shadcn_flutter/shadcn_flutter.dart\';',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Adding the ShadcnApp widget'),
                content: [
                  const Text('Add the ShadcnApp widget to your main function.')
                      .p(),
                  const CodeBlock(
                    code: '''
void main() {
  runApp(
    ShadcnApp(
      title: 'My App',
      home: MyHomePage(),
    ),
  );
}
                    ''',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Run the app'),
                content: [
                  const Text('Run the app using the following command:').p(),
                  const CodeBlock(
                    code: 'flutter run',
                    mode: 'shell',
                  ).p(),
                ],
              ),
            ],
          ),
          const Text('Material and Cupertino').h2().anchored(_companionKey),
          const Text(
            'shadcn_flutter is built on package:flutter/widgets.dart alone. It pulls '
            'in neither Material nor Cupertino, so nothing above is enough on its own '
            'if your app also uses widgets from those libraries.',
          ).p(),
          const Text(
            'Add the matching companion package, which brings in material_ui or '
            'cupertino_ui and wires their theme, localizations and ancestors into '
            'ShadcnApp for you:',
          ).p(),
          const CodeBlock(
            code: 'flutter pub add shadcn_flutter_material\n'
                '# or\n'
                'flutter pub add shadcn_flutter_cupertino',
            mode: 'shell',
          ).p(),
          const Text(
            'Then swap ShadcnApp for MaterialShadcnApp (or CupertinoShadcnApp), which '
            'accepts exactly the same parameters:',
          ).p(),
          const CodeBlock(
            code: '''
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
      title: 'My App',
      home: MyHomePage(),
    ),
  );
}''',
            mode: 'dart',
          ).p(),
          const Text('See ')
              .thenButton(
                  onPressed: () {
                    context.goNamed('external');
                  },
                  child: const Text('the Material/Cupertino page'))
              .thenText(' for the full migration table.')
              .p(),
          const Gap(16),
          const Text('Experimental Version').h2().anchored(_experimentalKey),
          const Text('Experimental versions are available on GitHub.').p(),
          const Text(
                  'To use an experimental version, use git instead of version number in your '
                  'pubspec.yaml file:')
              .p(),
          const CodeBlock(
            code: 'dependencies:\n'
                '  shadcn_flutter:\n'
                '    git:\n'
                '      url: "https://github.com/sunarya-thito/shadcn_flutter.git"\n'
                '      path: packages/shadcn_flutter',
            mode: 'yaml',
          ).p(),
          const Text('See ')
              .thenButton(
                  onPressed: () {
                    launchUrlString(
                        'https://dart.dev/tools/pub/dependencies#git-packages');
                  },
                  child: const Text('this page'))
              .thenText(' for more information.')
              .p(),
          const Gap(16),
          const Alert(
            destructive: true,
            leading: Icon(LucideIcons.triangleAlert),
            title: Text('Warning'),
            content: Text(
              'Experimental versions may contain breaking changes and are not recommended for production use. '
              'This version is intended for testing and development purposes only.',
            ),
          ),
        ],
      ),
    );
  }
}
