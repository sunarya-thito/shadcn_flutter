import 'package:example/pages/docs_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final OnThisPage featuresKey = OnThisPage();
  final OnThisPage faqKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'introduction',
      onThisPage: {
        'Features': featuresKey,
        'Frequency Asked Questions': faqKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Introduction').h1(),
          const Text(
                  'Beautifully designed components from Shadcn/UI is now available for Flutter.')
              .lead(),
          gap(32),
          const Text('Features').h2().anchored(featuresKey),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                      'Supports both Material and Cupertino Widgets with theme being able to adapt to the current shadcn_flutter theme.')
                  .li(),
              const Text('Pre-made themes from Shadcn/UI.').li(),
              const Text('Supports mobile, web, and desktop platforms.').li(),
              const Text('Supports middle drag scrolling.').li(),
              const Text('Various widget extensions for typography purposes.')
                  .li(),
            ],
          ).p(),
          const Text('Frequency Asked Questions').h2().anchored(faqKey),
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
              const AccordionItem(
                trigger: AccordionTrigger(
                  child: Text(
                      'Can I configure which style i would like to use? (Default/New York)'),
                ),
                content: Text(
                    'Unfortunately you can\'t. This package only supports New York style.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
