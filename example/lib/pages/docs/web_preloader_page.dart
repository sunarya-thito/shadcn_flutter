import 'package:example/pages/docs_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WebPreloaderPage extends StatelessWidget {
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
            gap(32),
            Steps(
              children: [
                StepItem(
                  title: Text('Creating a web directory'),
                  content: [
                    Text('If you don\'t have a web directory, create one.').p(),
                    CodeSnippet(
                      code: 'flutter create . --platforms=web',
                      mode: 'shell',
                    ).p(),
                    Text('* If you\'re using legacy flutter web, you need to upgrade it using the command above.')
                        .italic()
                        .muted()
                        .withPadding(top: 8),
                  ],
                ),
                StepItem(
                  title: Text('Creating a \"flutter_bootstrap.js\" file'),
                  content: [
                    Text('Next, create a \"flutter_bootstrap.js\" file in your web directory. Fill it with the following code:')
                        .p(),
                    CodeSnippetFutureBuilder(
                            path: 'web/flutter_bootstrap.js',
                            mode: 'javascript')
                        .p(),
                  ],
                ),
                StepItem(
                  title: Text('Customizing the preloader'),
                  content: [
                    Text('You can customize the preloader by modifying the \"flutter_bootstrap.js\" file.')
                        .p(),
                    Text('For example, you can change the background color of the preloader by modifying the following line:')
                        .p(),
                    CodeSnippet(
                      code: 'const shadcnLoaderConfig = {\n'
                          '...\n'
                          '\tbackgroundColor: \'#f00\',\n'
                          '...\n'
                          '};',
                      mode: 'javascript',
                    ).p(),
                  ],
                ),
                StepItem(
                  title: Text('Run the app'),
                  content: [
                    Text('Run the app using the following command:').p(),
                    CodeSnippet(
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
