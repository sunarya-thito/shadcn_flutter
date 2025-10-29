import 'package:docs/code_highlighter.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            Steps(
              children: [
                StepItem(
                  title: const Text('Creating a web directory'),
                  content: [
                    const Text(
                            'If you don\'t have a web directory, create one.')
                        .p(),
                    const CodeBlock(
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
                  title: const Text('Adding a script'),
                  content: [
                    const Text(
                            'Next, select and copy one of these pre-made preloaders:')
                        .p(),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Standard Preloader'),
                          Gap(8),
                          CodeBlock(
                            code:
                                '<script src="https://cdn.jsdelivr.net/gh/sunarya-thito/shadcn_flutter@latest/web_loaders/standard.js"></script>',
                            mode: 'javascript',
                          ),
                        ]).li().p(),
                  ],
                ),
                StepItem(
                  title: const Text('Paste the script'),
                  content: [
                    const Text('Open your ')
                        .thenInlineCode('index.html')
                        .thenText(' file and paste the script inside the ')
                        .thenInlineCode('<head>')
                        .thenText(' tag.')
                        .p(),
                    const Text('For example:').p(),
                    const CodeBlock(
                      code: '''
<!DOCTYPE html>
<html>
  <head>
    ...
    <script src="https://cdn.jsdelivr.net/gh/sunarya-thito/shadcn_flutter@latest/web_loaders/standard.js"></script>
    ...
  </head>
  ...
</html>
                      ''',
                      mode: 'javascript',
                    ).p(),
                  ],
                ),
                StepItem(
                  title: const Text('Run the app'),
                  content: [
                    const Text('Run the app using the following command:').p(),
                    const CodeBlock(
                      code: 'flutter run -d chrome',
                      mode: 'shell',
                    ).p(),
                  ],
                ),
              ],
            ),
            const Gap(32),
            Alert(
              title: const Text('Contributing'),
              leading: const Icon(Icons.info_outlined),
              content: const Text(
                      'If you have a preloader that you want to share, please create a pull request under the ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString(
                            'https://github.com/sunarya-thito/shadcn_flutter/tree/master/web_loaders');
                      },
                      child: const Text('web_loaders'))
                  .thenText(' directory.')
                  .p(),
            ),
          ],
        ));
  }
}
