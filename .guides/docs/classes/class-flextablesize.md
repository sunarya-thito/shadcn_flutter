---
title: "Class: FlexTableSize"
description: "Table size mode that distributes available space using flex factors."
---

```dart
/// Table size mode that distributes available space using flex factors.
///
/// Similar to Flutter's [Flexible] widget, allocates space proportionally
/// based on the flex value. Used for responsive column/row sizing.
///
/// Example:
/// ```dart
/// FlexTableSize(flex: 2.0, fit: FlexFit.tight)
/// ```
class FlexTableSize extends TableSize {
  /// Flex factor for space distribution. Defaults to 1.
  final double flex;
  /// How the space should be allocated. Defaults to tight.
  final FlexFit fit;
  /// Creates a [FlexTableSize].
  const FlexTableSize({this.flex = 1, this.fit = FlexFit.tight});
}
```
