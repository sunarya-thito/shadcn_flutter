---
title: "Class: SelectableTextTheme"
description: "{@template selectable_text_theme}  Theme data for [SelectableText] to customize cursor and selection behavior."
---

```dart
/// {@template selectable_text_theme}
/// Theme data for [SelectableText] to customize cursor and selection behavior.
/// {@endtemplate}
class SelectableTextTheme {
  /// Width of the text cursor in logical pixels.
  ///
  /// If `null`, uses the default cursor width from the platform or theme.
  final double? cursorWidth;
  /// Height of the text cursor in logical pixels.
  ///
  /// If `null`, the cursor height matches the line height of the text.
  final double? cursorHeight;
  /// Corner radius of the text cursor.
  ///
  /// If `null`, the cursor has square corners (no rounding).
  final Radius? cursorRadius;
  /// Color of the text cursor.
  ///
  /// If `null`, uses the theme's primary color or platform default.
  final Color? cursorColor;
  /// How tall the selection highlight boxes should be.
  ///
  /// Determines vertical sizing behavior for text selection highlights.
  /// If `null`, uses platform or theme defaults.
  final ui.BoxHeightStyle? selectionHeightStyle;
  /// How wide the selection highlight boxes should be.
  ///
  /// Determines horizontal sizing behavior for text selection highlights.
  /// If `null`, uses platform or theme defaults.
  final ui.BoxWidthStyle? selectionWidthStyle;
  /// Whether to enable interactive text selection (e.g., selecting with mouse/touch).
  ///
  /// When `true`, users can select text by dragging. When `false`, text
  /// selection gestures are disabled. If `null`, uses platform defaults.
  final bool? enableInteractiveSelection;
  /// {@macro selectable_text_theme}
  const SelectableTextTheme({this.cursorWidth, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle, this.selectionWidthStyle, this.enableInteractiveSelection});
  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// Uses [ValueGetter] functions to allow nullable value replacement.
  /// Properties not provided retain their current values.
  ///
  /// Parameters:
  /// - [cursorWidth]: Optional getter for new cursor width
  /// - [cursorHeight]: Optional getter for new cursor height
  /// - [cursorRadius]: Optional getter for new cursor radius
  /// - [cursorColor]: Optional getter for new cursor color
  /// - [selectionHeightStyle]: Optional getter for new selection height style
  /// - [selectionWidthStyle]: Optional getter for new selection width style
  /// - [enableInteractiveSelection]: Optional getter for new interactive selection state
  ///
  /// Returns a new [SelectableTextTheme] with updated values.
  SelectableTextTheme copyWith({ValueGetter<double?>? cursorWidth, ValueGetter<double?>? cursorHeight, ValueGetter<Radius?>? cursorRadius, ValueGetter<Color?>? cursorColor, ValueGetter<ui.BoxHeightStyle?>? selectionHeightStyle, ValueGetter<ui.BoxWidthStyle?>? selectionWidthStyle, ValueGetter<bool?>? enableInteractiveSelection});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
