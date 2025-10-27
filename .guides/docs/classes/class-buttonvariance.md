---
title: "Class: ButtonVariance"
description: "Reference for ButtonVariance"
---

```dart
class ButtonVariance implements AbstractButtonStyle {
  static const AbstractButtonStyle primary = ComponentThemeButtonStyle<PrimaryButtonTheme>(fallback: ButtonVariance(decoration: _buttonPrimaryDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonPrimaryTextStyle, iconTheme: _buttonPrimaryIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle secondary = ComponentThemeButtonStyle<SecondaryButtonTheme>(fallback: ButtonVariance(decoration: _buttonSecondaryDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonSecondaryTextStyle, iconTheme: _buttonSecondaryIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle outline = ComponentThemeButtonStyle<OutlineButtonTheme>(fallback: ButtonVariance(decoration: _buttonOutlineDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonOutlineTextStyle, iconTheme: _buttonOutlineIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle ghost = ComponentThemeButtonStyle<GhostButtonTheme>(fallback: ButtonVariance(decoration: _buttonGhostDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonGhostTextStyle, iconTheme: _buttonGhostIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle link = ComponentThemeButtonStyle<LinkButtonTheme>(fallback: ButtonVariance(decoration: _buttonLinkDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonLinkTextStyle, iconTheme: _buttonLinkIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle text = ComponentThemeButtonStyle<TextButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonTextTextStyle, iconTheme: _buttonTextIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle destructive = ComponentThemeButtonStyle<DestructiveButtonTheme>(fallback: ButtonVariance(decoration: _buttonDestructiveDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonDestructiveTextStyle, iconTheme: _buttonDestructiveIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle fixed = ComponentThemeButtonStyle<FixedButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonStaticTextStyle, iconTheme: _buttonStaticIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle menu = ComponentThemeButtonStyle<MenuButtonTheme>(fallback: ButtonVariance(decoration: _buttonMenuDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonMenuPadding, textStyle: _buttonMenuTextStyle, iconTheme: _buttonMenuIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle menubar = ComponentThemeButtonStyle<MenubarButtonTheme>(fallback: ButtonVariance(decoration: _buttonMenuDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonMenubarPadding, textStyle: _buttonMenuTextStyle, iconTheme: _buttonMenuIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle muted = ComponentThemeButtonStyle<MutedButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonMutedTextStyle, iconTheme: _buttonMutedIconTheme, margin: _buttonZeroMargin));
  static const AbstractButtonStyle card = ComponentThemeButtonStyle<CardButtonTheme>(fallback: ButtonVariance(decoration: _buttonCardDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonCardPadding, textStyle: _buttonCardTextStyle, iconTheme: _buttonCardIconTheme, margin: _buttonZeroMargin));
  final ButtonStateProperty<Decoration> decoration;
  final ButtonStateProperty<MouseCursor> mouseCursor;
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  final ButtonStateProperty<TextStyle> textStyle;
  final ButtonStateProperty<IconThemeData> iconTheme;
  final ButtonStateProperty<EdgeInsetsGeometry> margin;
  const ButtonVariance({required this.decoration, required this.mouseCursor, required this.padding, required this.textStyle, required this.iconTheme, required this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
