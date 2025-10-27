---
title: "Class: ButtonTheme"
description: "Reference for ButtonTheme"
---

```dart
abstract class ButtonTheme {
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  const ButtonTheme({this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
