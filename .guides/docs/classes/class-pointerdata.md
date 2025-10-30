---
title: "Class: PointerData"
description: "Data about the current pointer position."
---

```dart
/// Data about the current pointer position.
///
/// Used to track mouse/pointer location in the app.
class PointerData {
  /// The current position of the pointer.
  final Offset position;
  /// Creates pointer data with the given position.
  PointerData({required this.position});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
