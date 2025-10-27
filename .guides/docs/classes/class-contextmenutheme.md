---
title: "Class: ContextMenuTheme"
description: "Theme for [ContextMenuPopup] and context menu widgets."
---

```dart
/// Theme for [ContextMenuPopup] and context menu widgets.
class ContextMenuTheme {
  /// Surface opacity for the popup container.
  final double? surfaceOpacity;
  /// Surface blur for the popup container.
  final double? surfaceBlur;
  /// Creates a [ContextMenuTheme].
  const ContextMenuTheme({this.surfaceOpacity, this.surfaceBlur});
  /// Returns a copy of this theme with the given fields replaced.
  ContextMenuTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur});
  bool operator ==(Object other);
  int get hashCode;
}
```
