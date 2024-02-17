import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({Key? key}) : super(key: key);

  @override
  _InstallationPageState createState() => _InstallationPageState();
}

class _InstallationPageState extends State<InstallationPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Installation').h1(),
        Text('Install and configure shadcn_flutter in your project.').lead(),
        gap(32),
        Steps(
          children: [
            StepItem(
              title: Text('Creating a new Flutter project'),
              content: [
                Text('Create a new Flutter project using the following command:')
                    .p(),
                CodeSnippet(
                  code: 'flutter create my_app',
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
                Text('Now, you can import the package in your Dart code.').p(),
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
    );
  }
}
