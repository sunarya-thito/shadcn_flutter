---
title: "Example: components/dot_indicator/dot_indicator_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DotIndicatorExample1 extends StatefulWidget {
  const DotIndicatorExample1({super.key});

  @override
  State<DotIndicatorExample1> createState() => _DotIndicatorExample1State();
}

class _DotIndicatorExample1State extends State<DotIndicatorExample1> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    // A simple pager-like dot indicator with 5 steps.
    // Tap/click updates the current index via onChanged.
    return DotIndicator(
        index: _index,
        length: 5,
        onChanged: (index) {
          setState(() {
            _index = index;
          });
        });
  }
}

```
