import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'button/button_example_1.dart';
import 'button/button_example_2.dart';
import 'button/button_example_3.dart';
import 'button/button_example_4.dart';
import 'button/button_example_5.dart';
import 'button/button_example_6.dart';
import 'button/button_example_7.dart';
import 'button/button_example_8.dart';
import 'button/button_example_9.dart';
import 'button/button_example_10.dart';
class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'button',
      description: 'Buttons allow users to take actions, and make choices, with a single tap.',
      displayName: 'Button',
      children: [
        WidgetUsageExample(
          child: ButtonExample1(),
          path: 'lib/pages/docs/components/button/button_example_1.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample2(),
          path: 'lib/pages/docs/components/button/button_example_2.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample3(),
          path: 'lib/pages/docs/components/button/button_example_3.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample4(),
          path: 'lib/pages/docs/components/button/button_example_4.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample5(),
          path: 'lib/pages/docs/components/button/button_example_5.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample6(),
          path: 'lib/pages/docs/components/button/button_example_6.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample7(),
          path: 'lib/pages/docs/components/button/button_example_7.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample8(),
          path: 'lib/pages/docs/components/button/button_example_8.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample9(),
          path: 'lib/pages/docs/components/button/button_example_9.dart',
        ),
        WidgetUsageExample(
          child: ButtonExample10(),
          path: 'lib/pages/docs/components/button/button_example_10.dart',
        ),
      ],
    );
  }
}
  