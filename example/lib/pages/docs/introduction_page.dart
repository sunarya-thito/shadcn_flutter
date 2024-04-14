import 'package:example/main.dart';
import 'package:example/pages/docs_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final GlobalKey faqKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'introduction',
      onThisPage: {
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
          const Text('This is unofficial port of Shadcn for Flutter.'),
          const Text(
              'If you found any issues, please report it to our GitHub instead of Shadcn/ui.'),
          const Text('Frequency Asked Questions').h2().keyed(faqKey),
          Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(
                    child: const Text('Does this support GoRouter?')),
                content: Text(
                    'Yes, it does. You can use GoRouter with shadcn_flutter. '),
              ),
              AccordionItem(
                trigger: AccordionTrigger(
                  child: Text('Can I use this in my project?'),
                ),
                content: Text(
                    'Yes! Free to use for personal and commercial projects. No attribution required.'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(
                  child:
                      Text('Can I use this with Material App/Cupertino App?'),
                ),
                content: Text(
                    'No, you can\'t. This is a standalone package and not a theme.'),
              ),
              AccordionItem(
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
