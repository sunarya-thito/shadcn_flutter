import 'package:docs/pages/docs_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final OnThisPage featuresKey = OnThisPage();
  final OnThisPage faqKey = OnThisPage();
  final OnThisPage notesKey = OnThisPage();
  final OnThisPage linksKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'introduction',
      onThisPage: {
        'Features': featuresKey,
        'Notes': notesKey,
        'Frequently Asked Questions': faqKey,
        'Links': linksKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Introduction').h1(),
          const Text(
                  'Beautifully designed components from Shadcn/UI is now available for Flutter.')
              .lead(),
          const Text(
            'Welcome to shadcn_flutter, a versatile and comprehensive set '
            'of UI components designed specifically for Flutter desktop and '
            'web applications. With the growing popularity of Flutter for '
            'building cross-platform apps, we recognized the need for a '
            'toolkit that emphasizes the unique design requirements of '
            'desktop and web interfaces.',
            textAlign: TextAlign.justify,
          ).p(),
          const Text(
            '\tThis package provides a wide range of customizable '
            'and responsive components that align with modern desktop and web '
            'design principles. Whether you'
            're building a sophisticated business '
            'application, a sleek dashboard, or a productivity tool, our '
            'components are designed to help you create professional and '
            'polished UIs quickly and efficiently.',
            textAlign: TextAlign.justify,
          ).p(),
          const Text('Features').h2().anchored(featuresKey),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('84 components and growing!').li(),
              const Text(
                      'Supports both Material and Cupertino Widgets with theme being able to adapt to the current shadcn_flutter theme.')
                  .li(),
              const Text('Pre-made themes from Shadcn/UI.').li(),
              const Text('Supports mobile, web, and desktop platforms.').li(),
              const Text('Supports middle drag scrolling.').li(),
              const Text('Various widget extensions for typography purposes.')
                  .li(),
              const Text('Supports WebAssembly for better performance.').li(),
            ],
          ).p(),
          const Text('Notes').h2().anchored(notesKey),
          const Text(
                  'This package is still in development and may have breaking changes in the future. '
                  'Please be cautious when using this package in production.')
              .p(),
          const Text(
            'This package is not affiliated with Shadcn/UI. This package is a community-driven project.',
          ).p(),
          const Text('Frequently Asked Questions').h2().anchored(faqKey),
          Accordion(
            items: [
              const AccordionItem(
                trigger: AccordionTrigger(
                    child: Text('Does this support GoRouter?')),
                content: Text(
                    'Yes, it does. You can use GoRouter with shadcn_flutter. '),
              ),
              const AccordionItem(
                trigger: AccordionTrigger(
                  child: Text('Can I use this in my project?'),
                ),
                content: Text(
                    'Yes! Free to use for personal and commercial projects. No attribution required.'),
              ),
              AccordionItem(
                trigger: const AccordionTrigger(
                  child:
                      Text('Can I use this with Material/Cupertino Widgets?'),
                ),
                content: const Text('Sure you can! ').thenButton(
                    onPressed: () {
                      context.goNamed('external');
                    },
                    child: const Text('See this page!')),
              ),
              AccordionItem(
                trigger: const AccordionTrigger(
                  child: Text(
                      'Can I configure which style i would like to use? (Default/New York)'),
                ),
                content: const Text(
                        'Unfortunately you can\'t. This package only supports New York style. '
                        'But if you wish to have default style of Shadcn/UI, i would recommend ')
                    .thenButton(
                        onPressed: () {
                          launchUrlString(
                              'https://github.com/nank1ro/flutter-shadcn-ui');
                        },
                        child: const Text('this package'))
                    .thenText(' by ')
                    .thenButton(
                        onPressed: () {
                          launchUrlString('https://x.com/nank1ro');
                        },
                        child: const Text('@nank1ro'))
                    .thenText('.'),
              ),
            ],
          ),
          const Text('Links').h2().anchored(linksKey),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Github: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString(
                            'https://github.com/sunarya-thito/shadcn_flutter');
                      },
                      child: const Text(
                          'https://github.com/sunarya-thito/shadcn_flutter'))
                  .li(),
              const Text('pub.dev: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString(
                            'https://pub.dev/packages/shadcn_flutter');
                      },
                      child:
                          const Text('https://pub.dev/packages/shadcn_flutter'))
                  .li(),
              const Text('Discord: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString('https://discord.gg/ZzfBPQG4sV');
                      },
                      child: const Text('https://discord.gg/ZzfBPQG4sV'))
                  .li(),
            ],
          ).p(),
        ],
      ),
    );
  }
}
