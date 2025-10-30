---
title: "Class: ButtonGroupData"
description: "Reference for ButtonGroupData"
---

```dart
class ButtonGroupData {
  static const ButtonGroupData none = ButtonGroupData.all(1.0);
  static const ButtonGroupData zero = ButtonGroupData.all(0.0);
  static const ButtonGroupData horizontalStart = ButtonGroupData.horizontal(end: 0.0);
  static const ButtonGroupData horizontalEnd = ButtonGroupData.horizontal(start: 0.0);
  static const ButtonGroupData verticalTop = ButtonGroupData.vertical(bottom: 0.0);
  static const ButtonGroupData verticalBottom = ButtonGroupData.vertical(top: 0.0);
  final double topStartValue;
  final double topEndValue;
  final double bottomStartValue;
  final double bottomEndValue;
  const ButtonGroupData({required this.topStartValue, required this.topEndValue, required this.bottomStartValue, required this.bottomEndValue});
  const ButtonGroupData.horizontal({double start = 1.0, double end = 1.0});
  const ButtonGroupData.vertical({double top = 1.0, double bottom = 1.0});
  const ButtonGroupData.all(double value);
  factory ButtonGroupData.horizontalIndex(int index, int length);
  factory ButtonGroupData.verticalIndex(int index, int length);
  BorderRadiusGeometry applyToBorderRadius(BorderRadiusGeometry borderRadius, TextDirection textDirection);
  ButtonGroupData applyToButtonGroupData(ButtonGroupData other);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
