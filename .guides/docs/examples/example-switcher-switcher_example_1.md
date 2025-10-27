---
title: "Example: components/switcher/switcher_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample1 extends StatefulWidget {
  const SwitcherExample1({super.key});

  @override
  State<SwitcherExample1> createState() => _SwitcherExample1State();
}

class _SwitcherExample1State extends State<SwitcherExample1> {
  List<AxisDirection> directions = const [
    AxisDirection.up,
    AxisDirection.down,
    AxisDirection.left,
    AxisDirection.right,
  ];
  List<Size> sizes = const [
    Size(200, 300),
    Size(300, 200),
  ];
  int directionIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
            child: Text(
                'Switch Direction (${directions[directionIndex % directions.length]})'),
            onPressed: () {
              setState(() {
                directionIndex++;
              });
            }),
        gap(8),
        PrimaryButton(
            child: const Text('Next Item'),
            onPressed: () {
              setState(() {
                index++;
              });
            }),
        gap(24),
        ClipRect(
          child: Switcher(
            // The index selects which child is visible; transitions are directional.
            index: index,
            direction: directions[directionIndex % directions.length],
            onIndexChanged: (index) {
              setState(() {
                this.index = index;
              });
            },
            children: [
              for (int i = 0; i < 100; i++)
                NumberedContainer(
                  index: i,
```
