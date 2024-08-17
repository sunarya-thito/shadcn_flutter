import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/accordion/accordion_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AccordionExample extends StatelessWidget {
  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'accordion',
      description: 'An accordion is a vertically stacked list of items. '
          'Each item can be "expanded" or "collapsed" to reveal the content associated with that item.',
      displayName: 'Accordion',
      children: [
        WidgetUsageExample(
          title: 'Accordion Example',
          path: 'lib/pages/docs/components/accordion/accordion_example_1.dart',
          child: AccordionExample1(),
        )
      ],
    );
  }
}
