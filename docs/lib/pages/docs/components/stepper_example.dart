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
  const StepperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'stepper',
      description: 'A stepper is a fundamental part of material design '
          'guidelines. Steppers convey progress through numbered steps.',
      displayName: 'Stepper',
      children: [
        WidgetUsageExample(
          title: 'Vertical Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_1.dart',
          child: StepperExample1(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_2.dart',
          child: StepperExample2(),
        ),
        WidgetUsageExample(
          title: 'Failed Step Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_3.dart',
          child: StepperExample3(),
        ),
        WidgetUsageExample(
          title: 'Clickable Step Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_4.dart',
          child: StepperExample4(),
        ),
        WidgetUsageExample(
          title: 'Custom Icon Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_5.dart',
          child: StepperExample5(),
        ),
        WidgetUsageExample(
          title: 'Variants Example',
          path: 'lib/pages/docs/components/stepper/stepper_example_6.dart',
          child: StepperExample6(),
        ),
      ],
    );
  }
}
