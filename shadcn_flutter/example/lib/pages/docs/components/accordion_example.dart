import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/accordion/accordion_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AccordionExample extends StatelessWidget {
  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'accordion',
      description: 'An accordion is a vertically stacked list of items. '
          'Each item can be "expanded" or "collapsed" to reveal the content associated with that item.',
      children: [
        WidgetUsageExample(
          title: 'Accordion Example',
          child: AccordionExample1(),
          path: 'lib/pages/docs/components/accordion/accordion_example_1.dart',
        )
      ],
      displayName: 'Accordion',
    );
  }
}
