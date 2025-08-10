import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/stepper/stepper_example_2.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperTile extends StatelessWidget implements IComponentPage {
  const StepperTile({super.key});

  @override
  String get title => 'Stepper';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'stepper',
      title: 'Stepper',
      scale: 1,
      example: const StepperExample2().sized(width: 400, height: 500),
    );
  }
}
