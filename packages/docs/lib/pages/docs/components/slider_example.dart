import 'package:docs/pages/docs/components/slider/slider_example_1.dart';
import 'package:docs/pages/docs/components/slider/slider_example_2.dart';
import 'package:docs/pages/docs/components/slider/slider_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SliderExample extends StatelessWidget {
  const SliderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'slider',
      description:
          'A slider is a control for selecting a single value from a range of values.',
      displayName: 'Slider',
      children: [
        WidgetUsageExample(
          title: 'Slider Example',
          path: 'lib/pages/docs/components/slider/slider_example_1.dart',
          child: SliderExample1(),
        ),
        WidgetUsageExample(
          title: 'Slider with Range Example',
          path: 'lib/pages/docs/components/slider/slider_example_2.dart',
          child: SliderExample2(),
        ),
        WidgetUsageExample(
          title: 'Slider with Divisions Example',
          path: 'lib/pages/docs/components/slider/slider_example_3.dart',
          child: SliderExample3(),
        ),
      ],
    );
  }
}
