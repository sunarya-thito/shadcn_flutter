---
title: "Class: DividerTheme"
description: "Theme data for customizing [Divider] widget appearance."
---

```dart
/// Theme data for customizing [Divider] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Divider] widgets, including line color, dimensions, spacing, and
/// child padding. These properties can be set at the theme level
/// to provide consistent styling across the application.
class DividerTheme {
  /// Color of the divider line.
  final Color? color;
  /// Height of the divider widget.
  final double? height;
  /// Thickness of the divider line.
  final double? thickness;
  /// Empty space to the leading edge of the divider.
  final double? indent;
  /// Empty space to the trailing edge of the divider.
  final double? endIndent;
  /// Padding around the [Divider.child].
  final EdgeInsetsGeometry? padding;
  /// Creates a [DividerTheme].
  const DividerTheme({this.color, this.height, this.thickness, this.indent, this.endIndent, this.padding});
  /// Creates a copy of this theme but with the given fields replaced by the
  /// new values.
  DividerTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? height, ValueGetter<double?>? thickness, ValueGetter<double?>? indent, ValueGetter<double?>? endIndent, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
