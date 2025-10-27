---
title: "Class: TextFieldTheme"
description: "Theme data for customizing [TextField] appearance."
---

```dart
/// Theme data for customizing [TextField] appearance.
///
/// This class defines the visual properties that can be applied to
/// [TextField] widgets, including border styling, fill state, padding,
/// and border radius. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TextFieldTheme {
  final BorderRadiusGeometry? borderRadius;
  final bool? filled;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  const TextFieldTheme({this.border, this.borderRadius, this.filled, this.padding});
  TextFieldTheme copyWith({ValueGetter<Border?>? border, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? filled, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
