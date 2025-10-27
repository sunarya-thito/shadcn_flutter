---
title: "Class: ComponentThemeButtonStyle"
description: "Reference for ComponentThemeButtonStyle"
---

```dart
class ComponentThemeButtonStyle<T extends ButtonTheme> implements AbstractButtonStyle {
  final AbstractButtonStyle fallback;
  const ComponentThemeButtonStyle({required this.fallback});
  T? find(BuildContext context);
  ButtonStateProperty<Decoration> get decoration;
  ButtonStateProperty<IconThemeData> get iconTheme;
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
  ButtonStateProperty<MouseCursor> get mouseCursor;
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  ButtonStateProperty<TextStyle> get textStyle;
}
```
