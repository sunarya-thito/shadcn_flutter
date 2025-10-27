---
title: "Class: Slider"
description: "Reference for Slider"
---

```dart
class Slider extends StatefulWidget {
  final SliderValue value;
  final ValueChanged<SliderValue>? onChanged;
  final ValueChanged<SliderValue>? onChangeStart;
  final ValueChanged<SliderValue>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final SliderValue? hintValue;
  final double? increaseStep;
  final double? decreaseStep;
  final bool? enabled;
  const Slider({super.key, required this.value, this.onChanged, this.onChangeStart, this.onChangeEnd, this.min = 0, this.max = 1, this.divisions, this.hintValue, this.increaseStep, this.decreaseStep, this.enabled = true});
  _SliderState createState();
}
```
