import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Text('Frequency Asked Questions').h2(),
        Accordion(
          items: [
            AccordionItem(
              trigger: AccordionTrigger(
                  child: const Text('Does this support GoRouter?')),
              content: Text(
                      'Yes, it does. You can use GoRouter with shadcn_flutter. ')
                  .thenButton(
                child: Text('Click here to see the example'),
                onPressed: () {},
              ),
            ),
            AccordionItem(
              trigger: AccordionTrigger(
                child: Text('Can I use this in my project?'),
              ),
              content: Text(
                  'Yes! Free to use for personal and commercial projects. No attribution required.'),
            ),
          ],
        ),
      ],
    );
  }
}
