---
title: "Class: ButtonStyle"
description: "Reference for ButtonStyle"
---

```dart
class ButtonStyle implements AbstractButtonStyle {
  final AbstractButtonStyle variance;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  const ButtonStyle({required this.variance, this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.primary({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.secondary({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.outline({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.ghost({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.link({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.text({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.destructive({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.fixed({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.menu({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.menubar({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.muted({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  const ButtonStyle.primaryIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.secondaryIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.outlineIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.ghostIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.linkIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.textIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.destructiveIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.fixedIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  const ButtonStyle.card({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  ButtonStateProperty<Decoration> get decoration;
  ButtonStateProperty<MouseCursor> get mouseCursor;
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  ButtonStateProperty<TextStyle> get textStyle;
  ButtonStateProperty<IconThemeData> get iconTheme;
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}
```
