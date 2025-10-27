---
title: "Extension: ButtonStyleExtension"
description: "Reference for extension"
---

```dart
extension ButtonStyleExtension on AbstractButtonStyle {
  AbstractButtonStyle copyWith({ButtonStatePropertyDelegate<Decoration>? decoration, ButtonStatePropertyDelegate<MouseCursor>? mouseCursor, ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding, ButtonStatePropertyDelegate<TextStyle>? textStyle, ButtonStatePropertyDelegate<IconThemeData>? iconTheme, ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin});
  AbstractButtonStyle withBackgroundColor({Color? color, Color? hoverColor, Color? focusColor, Color? disabledColor});
  AbstractButtonStyle withForegroundColor({Color? color, Color? hoverColor, Color? focusColor, Color? disabledColor});
  AbstractButtonStyle withBorder({Border? border, Border? hoverBorder, Border? focusBorder, Border? disabledBorder});
  AbstractButtonStyle withBorderRadius({BorderRadiusGeometry? borderRadius, BorderRadiusGeometry? hoverBorderRadius, BorderRadiusGeometry? focusBorderRadius, BorderRadiusGeometry? disabledBorderRadius});
  AbstractButtonStyle withPadding({EdgeInsetsGeometry? padding, EdgeInsetsGeometry? hoverPadding, EdgeInsetsGeometry? focusPadding, EdgeInsetsGeometry? disabledPadding});
}
```
