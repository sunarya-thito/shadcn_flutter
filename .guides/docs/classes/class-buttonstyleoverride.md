---
title: "Class: ButtonStyleOverride"
description: "Reference for ButtonStyleOverride"
---

```dart
class ButtonStyleOverride extends StatelessWidget {
  final bool inherit;
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  final Widget child;
  const ButtonStyleOverride({super.key, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin, required this.child});
  const ButtonStyleOverride.inherit({super.key, this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin, required this.child});
  Widget build(BuildContext context);
}
```
