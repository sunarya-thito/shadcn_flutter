---
title: "Class: SelectableTextTheme"
description: "{@template selectable_text_theme}  Theme data for [SelectableText] to customize cursor and selection behavior."
---

```dart
/// {@template selectable_text_theme}
/// Theme data for [SelectableText] to customize cursor and selection behavior.
/// {@endtemplate}
class SelectableTextTheme {
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle? selectionHeightStyle;
  final ui.BoxWidthStyle? selectionWidthStyle;
  final bool? enableInteractiveSelection;
  /// {@macro selectable_text_theme}
  const SelectableTextTheme({this.cursorWidth, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle, this.selectionWidthStyle, this.enableInteractiveSelection});
  SelectableTextTheme copyWith({ValueGetter<double?>? cursorWidth, ValueGetter<double?>? cursorHeight, ValueGetter<Radius?>? cursorRadius, ValueGetter<Color?>? cursorColor, ValueGetter<ui.BoxHeightStyle?>? selectionHeightStyle, ValueGetter<ui.BoxWidthStyle?>? selectionWidthStyle, ValueGetter<bool?>? enableInteractiveSelection});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
