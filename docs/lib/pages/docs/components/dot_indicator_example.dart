import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'dot_indicator/dot_indicator_example_1.dart';

class DotIndicatorExample extends StatelessWidget {
  const DotIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dot_indicator',
      description:
          'A widget that displays a series of dots to indicate the current index in a list of items.',
      displayName: 'Dot Indicator',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/dot_indicator/dot_indicator_example_1.dart',
          child: DotIndicatorExample1(),
        ),
      ],
    );
  }
}
