---
title: "Class: NavigationChildControlData"
description: "Data class tracking navigation child position and selection state."
---

```dart
/// Data class tracking navigation child position and selection state.
///
/// Associates a navigation item with its logical index (for selection)
/// and actual index (for layout position).
class NavigationChildControlData {
  /// Logical index for selection (null if not selectable).
  final int? index;
  /// Actual position index in the navigation layout.
  final int actualIndex;
  /// Creates navigation child control data.
  ///
  /// Parameters:
  /// - [index] (int?): Logical selection index
  /// - [actualIndex] (int, required): Layout position index
  NavigationChildControlData({this.index, required this.actualIndex});
  bool operator ==(Object other);
  int get hashCode;
}
```
