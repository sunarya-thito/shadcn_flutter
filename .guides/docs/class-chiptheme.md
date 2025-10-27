---
title: "Class: ChipTheme"
description: "Theme for [Chip]."
---

```dart
/// Theme for [Chip].
class ChipTheme {
  /// The padding inside the chip.
  final EdgeInsetsGeometry? padding;
  /// The default [Button] style of the chip.
  final AbstractButtonStyle? style;
  /// Creates a [ChipTheme].
  const ChipTheme({this.padding, this.style});
  /// Creates a copy of this theme with the given values replaced.
  ChipTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<AbstractButtonStyle?>? style});
  bool operator ==(Object other);
  int get hashCode;
}
```
