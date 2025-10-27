---
title: "Class: SliderValue"
description: "Reference for SliderValue"
---

```dart
class SliderValue {
  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t);
  const SliderValue.single(double value);
  const SliderValue.ranged(double this._start, this._end);
  bool get isRanged;
  double get start;
  double get end;
  double get value;
  bool operator ==(Object other);
  int get hashCode;
  SliderValue roundToDivisions(int divisions);
}
```
