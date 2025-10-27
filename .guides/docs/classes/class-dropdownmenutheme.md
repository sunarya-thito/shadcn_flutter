---
title: "Class: DropdownMenuTheme"
description: "Theme for [DropdownMenu]."
---

```dart
/// Theme for [DropdownMenu].
class DropdownMenuTheme {
  /// Surface opacity for the popup container.
  final double? surfaceOpacity;
  /// Surface blur for the popup container.
  final double? surfaceBlur;
  /// Creates a [DropdownMenuTheme].
  const DropdownMenuTheme({this.surfaceOpacity, this.surfaceBlur});
  /// Returns a copy of this theme with the given fields replaced.
  DropdownMenuTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur});
  bool operator ==(Object other);
  int get hashCode;
}
```
