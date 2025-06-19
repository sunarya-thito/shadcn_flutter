import 'package:docs/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_1.dart';
import 'package:docs/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_2.dart';
import 'package:docs/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class RepeatedAnimationBuilderExample extends StatelessWidget {
  const RepeatedAnimationBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'repeated_animation_builder',
      description:
          'RepeatedAnimationBuilder is a component that allows you to animate a value repeatedly.',
      displayName: 'RepeatedAnimationBuilder',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_1.dart',
          child: RepeatedAnimationBuilderExample1(),
        ),
        WidgetUsageExample(
          title: 'Reverse Example',
          path:
              'lib/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_2.dart',
          child: RepeatedAnimationBuilderExample2(),
        ),
        WidgetUsageExample(
          title: 'Ping-pong Example',
          path:
              'lib/pages/docs/components/repeated_animation_builder/repeated_animation_builder_example_3.dart',
          child: RepeatedAnimationBuilderExample3(),
        ),
      ],
    );
  }
}
