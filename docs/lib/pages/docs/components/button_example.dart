import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'button/button_example_1.dart';
import 'button/button_example_10.dart';
import 'button/button_example_11.dart';
import 'button/button_example_12.dart';
import 'button/button_example_13.dart';
import 'button/button_example_14.dart';
import 'button/button_example_15.dart';
import 'button/button_example_2.dart';
import 'button/button_example_3.dart';
import 'button/button_example_4.dart';
import 'button/button_example_5.dart';
import 'button/button_example_6.dart';
import 'button/button_example_7.dart';
import 'button/button_example_8.dart';
import 'button/button_example_9.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'button',
      description:
          'Buttons allow users to take actions, and make choices, with a single tap.',
      displayName: 'Button',
      children: [
        WidgetUsageExample(
          title: 'Primary Button Example',
          path: 'lib/pages/docs/components/button/button_example_1.dart',
          child: ButtonExample1(),
        ),
        WidgetUsageExample(
          title: 'Secondary Button Example',
          path: 'lib/pages/docs/components/button/button_example_2.dart',
          child: ButtonExample2(),
        ),
        WidgetUsageExample(
          title: 'Outline Button Example',
          path: 'lib/pages/docs/components/button/button_example_3.dart',
          child: ButtonExample3(),
        ),
        WidgetUsageExample(
          title: 'Ghost Button Example',
          path: 'lib/pages/docs/components/button/button_example_4.dart',
          child: ButtonExample4(),
        ),
        WidgetUsageExample(
          title: 'Destructive Button Example',
          path: 'lib/pages/docs/components/button/button_example_5.dart',
          child: ButtonExample5(),
        ),
        WidgetUsageExample(
          title: 'Link Button Example',
          path: 'lib/pages/docs/components/button/button_example_6.dart',
          child: ButtonExample6(),
        ),
        WidgetUsageExample(
          title: 'Text Button Example',
          path: 'lib/pages/docs/components/button/button_example_12.dart',
          child: ButtonExample12(),
        ),
        WidgetUsageExample(
          title: 'Disabled Button Example',
          path: 'lib/pages/docs/components/button/button_example_7.dart',
          child: ButtonExample7(),
        ),
        WidgetUsageExample(
          title: 'Icon Button Example',
          path: 'lib/pages/docs/components/button/button_example_8.dart',
          child: ButtonExample8(),
        ),
        WidgetUsageExample(
          title: 'Icon Button with Label Example',
          path: 'lib/pages/docs/components/button/button_example_9.dart',
          child: ButtonExample9(),
        ),
        WidgetUsageExample(
          title: 'Button Size Example',
          path: 'lib/pages/docs/components/button/button_example_10.dart',
          child: ButtonExample10(),
        ),
        WidgetUsageExample(
          title: 'Button Density Example',
          path: 'lib/pages/docs/components/button/button_example_11.dart',
          child: ButtonExample11(),
        ),
        WidgetUsageExample(
          title: 'Button Shape Example',
          path: 'lib/pages/docs/components/button/button_example_13.dart',
          child: ButtonExample13(),
        ),
        WidgetUsageExample(
          title: 'Button Group Example',
          path: 'lib/pages/docs/components/button/button_example_14.dart',
          child: ButtonExample14(),
        ),
        WidgetUsageExample(
          title: 'Button Stated Example',
          path: 'lib/pages/docs/components/button/button_example_15.dart',
          child: ButtonExample15(),
        ),
      ],
    );
  }
}
