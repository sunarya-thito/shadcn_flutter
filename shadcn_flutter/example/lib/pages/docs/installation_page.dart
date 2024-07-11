import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({Key? key}) : super(key: key);

  @override
  _InstallationPageState createState() => _InstallationPageState();
}

class _InstallationPageState extends State<InstallationPage> {
  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'installation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Installation').h1(),
          Text('Install and configure shadcn_flutter in your project.').lead(),
          Text('Install using CLI').h2(),
          gap(32),
          // 1. Activate "shadcn_flutter_cli" package
          // 2. Run "flutter pub global run shadcn_flutter_cli:setup"
          Steps(
            children: [
              StepItem(
                title: Text('Activate the package'),
                content: [
                  Text('Activate the shadcn_flutter_cli package.').p(),
                  CodeSnippet(
                    code: 'flutter pub global activate shadcn_flutter_cli',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: Text('Run the setup command'),
                content: [
                  Text('Run the setup command to add shadcn_flutter to your project.')
                      .p(),
                  CodeSnippet(
                    code: 'flutter pub global run shadcn_flutter_cli:setup',
                    mode: 'shell',
                  ).p(),
                ],
              ),
            ],
          ),
          Text('Install Manually').h2(),
          gap(32),
          Steps(
            children: [
              StepItem(
                title: Text('Creating a new Flutter project'),
                content: [
                  Text('Create a new Flutter project using the following command:')
                      .p(),
                  CodeSnippet(
                    code: 'flutter create my_app\ncd my_app',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: Text('Adding the dependency'),
                content: [
                  Text('Next, add the shadcn_flutter dependency to your project.')
                      .p(),
                  CodeSnippet(
                    code: 'flutter pub add shadcn_flutter',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: Text('Importing the package'),
                content: [
                  Text('Now, you can import the package in your Dart code.')
                      .p(),
                  CodeSnippet(
                    code:
                        'import \'package:shadcn_flutter/shadcn_flutter.dart\';',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: Text('Adding the ShadcnApp widget'),
                content: [
                  const Text('Add the ShadcnApp widget to your main function.')
                      .p(),
                  const CodeSnippet(
                    code: '''
void main() {
  runApp(
    ShadcnApp(
      title: 'My App',
      home: MyHomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorSchemes.darkZync(),
        radius: 0.5,
      ),
    ),
  );
}
                    ''',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: Text('Add the fonts'),
                content: [
                  Text('Add the fonts to your pubspec.yaml file.').p(),
                  CodeSnippet(
                    code: '''
  fonts:
    - family: RadixIcons
      fonts:
        - asset: "packages/shadcn_flutter/icons/RadixIcons.otf"
    - family: "GeistSans"
      fonts:
        - asset: "packages/shadcn_flutter/fonts/Geist-Black.otf"
          weight: 800
        - asset: "packages/shadcn_flutter/fonts/Geist-Bold.otf"
          weight: 700
        - asset: "packages/shadcn_flutter/fonts/Geist-Light.otf"
          weight: 300
        - asset: "packages/shadcn_flutter/fonts/Geist-Medium.otf"
          weight: 500
        - asset: "packages/shadcn_flutter/fonts/Geist-SemiBold.otf"
          weight: 600
        - asset: "packages/shadcn_flutter/fonts/Geist-Thin.otf"
          weight: 100
        - asset: "packages/shadcn_flutter/fonts/Geist-UltraBlack.otf"
          weight: 900
        - asset: "packages/shadcn_flutter/fonts/Geist-UltraLight.otf"
          weight: 200
        - asset: "packages/shadcn_flutter/fonts/Geist-Regular.otf"
          weight: 400
    - family: "GeistMono"
      fonts:
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Black.otf"
          weight: 800
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Bold.otf"
          weight: 700
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Light.otf"
          weight: 300
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Medium.otf"
          weight: 500
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Regular.otf"
          weight: 400
        - asset: "packages/shadcn_flutter/fonts/GeistMono-SemiBold.otf"
          weight: 600
        - asset: "packages/shadcn_flutter/fonts/GeistMono-Thin.otf"
          weight: 100
        - asset: "packages/shadcn_flutter/fonts/GeistMono-UltraBlack.otf"
          weight: 900
        - asset: "packages/shadcn_flutter/fonts/GeistMono-UltraLight.otf"
          weight: 200''',
                    mode: 'yaml',
                  ).sized(height: 300).p(),
                ],
              ),
              StepItem(
                title: Text('Run the app'),
                content: [
                  Text('Run the app using the following command:').p(),
                  CodeSnippet(
                    code: 'flutter run',
                    mode: 'shell',
                  ).p(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
