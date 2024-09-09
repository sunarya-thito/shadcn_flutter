import 'package:docs/pages/docs_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WebPreloaderPage extends StatelessWidget {
  const WebPreloaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsPage(
        name: 'web_preloader',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Web Preloader').h1(),
            const Text('Customize how flutter load your web application')
                .lead(),
            const Gap(32),
            Alert(
              title: const Text('Note'),
              content: const Text(
                      'You can use the CLI to create a web preloader for your flutter web application. See ')
                  .thenButton(
                      onPressed: () {
                        context.goNamed('installation');
                      },
                      child: const Text('Installation page'))
                  .thenText(' for more information.'),
              leading: const Icon(Icons.info_outline),
            ),
            const Gap(32),
            Steps(
              children: [
                StepItem(
                  title: const Text('Creating a web directory'),
                  content: [
                    const Text(
                            'If you don\'t have a web directory, create one.')
                        .p(),
                    const CodeSnippet(
                      code: 'flutter create . --platforms=web',
                      mode: 'shell',
                    ).p(),
                    const Text(
                            '* If you\'re using legacy flutter web, you need to upgrade it using the command above. ')
                        .thenButton(
                            onPressed: () {
                              openInNewTab(
                                  'https://docs.flutter.dev/platform-integration/web/initialization#upgrade-an-older-project');
                            },
                            child:
                                const Text('Click here for more information.'))
                        .italic()
                        .muted()
                        .withPadding(top: 8),
                  ],
                ),
                StepItem(
                  title: const Text('Creating a "flutter_bootstrap.js" file'),
                  content: [
                    const Text(
                            'Next, create a "flutter_bootstrap.js" file in your web directory. Fill it with the following code:')
                        .p(),
                    const CodeSnippetFutureBuilder(
                      path: 'web/flutter_bootstrap.js',
                      mode: 'javascript',
                      summarize: false,
                    ).sized(height: 300).p(),
                  ],
                ),
                StepItem(
                  title: const Text('Customizing the preloader'),
                  content: [
                    const Text(
                            'You can customize the preloader by modifying the "flutter_bootstrap.js" file.')
                        .p(),
                    const Text(
                            'For example, you can change the background color of the preloader by modifying the following line:')
                        .p(),
                    const CodeSnippet(
                      code: 'const shadcn_flutter_config = {\n'
                          '...\n'
                          '\tbackground: \'#f00\',\n'
                          '...\n'
                          '};',
                      mode: 'javascript',
                    ).p(),
                  ],
                ),
                StepItem(
                  title: const Text('Run the app'),
                  content: [
                    const Text('Run the app using the following command:').p(),
                    const CodeSnippet(
                      code: 'flutter run -d chrome',
                      mode: 'shell',
                    ).p(),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
