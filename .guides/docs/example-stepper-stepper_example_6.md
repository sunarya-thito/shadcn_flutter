---
title: "Example: components/stepper/stepper_example_6.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepperExample6 extends StatefulWidget {
  const StepperExample6({super.key});

  @override
  State<StepperExample6> createState() => _StepperExample6State();
}

class _StepperExample6State extends State<StepperExample6> {
  static const List<StepVariant> _variants = [
    StepVariant.circle,
    StepVariant.circleAlt,
    StepVariant.line,
  ];
  static const List<String> _variantNames = [
    'Circle',
    'Circle Alt',
    'Line',
  ];
  static const List<StepSize> _stepSize = StepSize.values;
  static const List<String> _stepSizeNames = [
    'Small',
    'Medium',
    'Large',
  ];
  final StepperController controller = StepperController();
  int _currentVariant = 0;
  int _currentStepSize = 0;
  Axis direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Toggle(
              value: direction == Axis.horizontal,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                } else {
                  setState(() {
                    direction = Axis.vertical;
                  });
                }
              },
              child: const Text('Horizontal'),
            ),
            Toggle(
              value: direction == Axis.vertical,
```
