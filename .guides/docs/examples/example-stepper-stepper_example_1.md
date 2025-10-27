---
title: "Example: components/stepper/stepper_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample1 extends StatefulWidget {
  const StepperExample1({super.key});

  @override
  State<StepperExample1> createState() => _StepperExample1State();
}

class _StepperExample1State extends State<StepperExample1> {
  final StepperController controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controller: controller,
      // Vertical layout with 3 steps and Next/Prev actions.
      direction: Axis.vertical,
      steps: [
        Step(
          title: const Text('Step 1'),
          contentBuilder: (context) {
            return StepContainer(
              actions: [
                const SecondaryButton(
                  child: Text('Prev'),
                ),
                PrimaryButton(
                    child: const Text('Next'),
                    onPressed: () {
                      // Advance to the next step.
                      controller.nextStep();
                    }),
              ],
              child: const NumberedContainer(
                index: 1,
                height: 200,
              ),
            );
          },
        ),
        Step(
          title: const Text('Step 2'),
          contentBuilder: (context) {
            return StepContainer(
              actions: [
                SecondaryButton(
                  child: const Text('Prev'),
                  onPressed: () {
                    // Move back one step.
                    controller.previousStep();
                  },
                ),
                PrimaryButton(
                    child: const Text('Next'),
                    onPressed: () {
                      controller.nextStep();
                    }),
              ],
```
