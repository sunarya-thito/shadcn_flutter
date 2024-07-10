import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'button/button_example_1.dart';
import 'button/button_example_10.dart';
import 'button/button_example_11.dart';
import 'button/button_example_12.dart';
import 'button/button_example_13.dart';
import 'button/button_example_2.dart';
import 'button/button_example_3.dart';
import 'button/button_example_4.dart';
import 'button/button_example_5.dart';
import 'button/button_example_6.dart';
import 'button/button_example_7.dart';
import 'button/button_example_8.dart';
import 'button/button_example_9.dart';

class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'button',
      description:
          'Buttons allow users to take actions, and make choices, with a single tap.',
      displayName: 'Button',
      children: [
        WidgetUsageExample(
          title: 'Primary Button Example',
          child: ButtonExample1(),
          path: 'lib/pages/docs/components/button/button_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Secondary Button Example',
          child: ButtonExample2(),
          path: 'lib/pages/docs/components/button/button_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Outline Button Example',
          child: ButtonExample3(),
          path: 'lib/pages/docs/components/button/button_example_3.dart',
        ),
        WidgetUsageExample(
          title: 'Ghost Button Example',
          child: ButtonExample4(),
          path: 'lib/pages/docs/components/button/button_example_4.dart',
        ),
        WidgetUsageExample(
          title: 'Destructive Button Example',
          child: ButtonExample5(),
          path: 'lib/pages/docs/components/button/button_example_5.dart',
        ),
        WidgetUsageExample(
          title: 'Link Button Example',
          child: ButtonExample6(),
          path: 'lib/pages/docs/components/button/button_example_6.dart',
        ),
        WidgetUsageExample(
          title: 'Text Button Example',
          child: ButtonExample12(),
          path: 'lib/pages/docs/components/button/button_example_12.dart',
        ),
        WidgetUsageExample(
          title: 'Disabled Button Example',
          child: ButtonExample7(),
          path: 'lib/pages/docs/components/button/button_example_7.dart',
        ),
        WidgetUsageExample(
          title: 'Icon Button Example',
          child: ButtonExample8(),
          path: 'lib/pages/docs/components/button/button_example_8.dart',
        ),
        WidgetUsageExample(
          title: 'Icon Button with Label Example',
          child: ButtonExample9(),
          path: 'lib/pages/docs/components/button/button_example_9.dart',
        ),
        WidgetUsageExample(
          title: 'Button Size Example',
          child: ButtonExample10(),
          path: 'lib/pages/docs/components/button/button_example_10.dart',
        ),
        WidgetUsageExample(
          title: 'Button Density Example',
          child: ButtonExample11(),
          path: 'lib/pages/docs/components/button/button_example_11.dart',
        ),
        WidgetUsageExample(
          title: 'Button Shape Example',
          child: ButtonExample13(),
          path: 'lib/pages/docs/components/button/button_example_13.dart',
        ),
      ],
    );
  }
}
