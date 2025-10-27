---
title: "Example: components/stepper/stepper_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample3 extends StatefulWidget {
  const StepperExample3({super.key});

  @override
  State<StepperExample3> createState() => _StepperExample3State();
}

class _StepperExample3State extends State<StepperExample3> {
  final StepperController controller = StepperController(
    stepStates: {
      1: StepState.failed,
    },
    currentStep: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        Step(
          title: const Text('Step 1'),
          contentBuilder: (context) {
            return const StepContainer(
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 1,
                height: 200,
              ),
            );
          },
        ),
        Step(
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return const StepContainer(
              actions: [
                SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 2,
                height: 200,
              ),
            );
```
