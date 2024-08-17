import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'animated_value_builder/animated_value_builder_example_1.dart';
import 'animated_value_builder/animated_value_builder_example_2.dart';

class AnimatedValueBuilderExample extends StatelessWidget {
  const AnimatedValueBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'animated_value_builder',
      description:
          'AnimatedValueBuilder is a component that allows you to animate a value.',
      displayName: 'AnimatedValueBuilder',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/animated_value_builder/animated_value_builder_example_1.dart',
          child: AnimatedValueBuilderExample1(),
        ),
        WidgetUsageExample(
          title: 'Example with Initial Value',
          path:
              'lib/pages/docs/components/animated_value_builder/animated_value_builder_example_1.dart',
          child: AnimatedValueBuilderExample2(),
        ),
      ],
    );
  }
}
