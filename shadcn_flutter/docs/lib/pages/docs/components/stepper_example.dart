import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_1.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_2.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_3.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_4.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_5.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_6.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'stepper',
      description: 'A stepper is a fundamental part of material design '
          'guidelines. Steppers convey progress through numbered steps.',
      displayName: 'Stepper',
      children: [
        WidgetUsageExample(
          title: 'Vertical Example',
          child: StepperExample1(),
          path: 'lib/pages/docs/components/stepper/stepper_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Horizontal Example',
          child: StepperExample2(),
          path: 'lib/pages/docs/components/stepper/stepper_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Failed Step Example',
          child: StepperExample3(),
          path: 'lib/pages/docs/components/stepper/stepper_example_3.dart',
        ),
        WidgetUsageExample(
          title: 'Clickable Step Example',
          child: StepperExample4(),
          path: 'lib/pages/docs/components/stepper/stepper_example_4.dart',
        ),
        WidgetUsageExample(
          title: 'Custom Icon Example',
          child: StepperExample5(),
          path: 'lib/pages/docs/components/stepper/stepper_example_5.dart',
        ),
        WidgetUsageExample(
          title: 'Variants Example',
          child: StepperExample6(),
          path: 'lib/pages/docs/components/stepper/stepper_example_6.dart',
        ),
      ],
    );
  }
}
