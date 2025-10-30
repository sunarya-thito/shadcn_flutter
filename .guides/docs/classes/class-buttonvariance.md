---
title: "Class: ButtonVariance"
description: "Implementation of [AbstractButtonStyle] providing concrete button style variants."
---

```dart
/// Implementation of [AbstractButtonStyle] providing concrete button style variants.
///
/// [ButtonVariance] implements [AbstractButtonStyle] with state property functions
/// and provides static constants for all standard button variants (primary, secondary,
/// outline, etc.). Each variant is wrapped in a [ComponentThemeButtonStyle] to enable
/// theme-level customization.
///
/// The static variance constants serve as the base styles used by [ButtonStyle]'s
/// named constructors and can be used directly when creating custom button styles.
///
/// Example:
/// ```dart
/// // Use a variant directly
/// Button(
///   style: ButtonVariance.primary,
///   child: Text('Click Me'),
/// )
/// ```
class ButtonVariance implements AbstractButtonStyle {
  /// Primary button variant with prominent filled appearance.
  ///
  /// Features high-contrast styling suitable for the main action on a screen.
  static const AbstractButtonStyle primary = ComponentThemeButtonStyle<PrimaryButtonTheme>(fallback: ButtonVariance(decoration: _buttonPrimaryDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonPrimaryTextStyle, iconTheme: _buttonPrimaryIconTheme, margin: _buttonZeroMargin));
  /// Secondary button variant with muted appearance.
  ///
  /// Features subtle styling suitable for supporting or alternative actions.
  static const AbstractButtonStyle secondary = ComponentThemeButtonStyle<SecondaryButtonTheme>(fallback: ButtonVariance(decoration: _buttonSecondaryDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonSecondaryTextStyle, iconTheme: _buttonSecondaryIconTheme, margin: _buttonZeroMargin));
  /// Outline button variant with border and transparent background.
  ///
  /// Features a visible border without filled background, suitable for secondary actions.
  static const AbstractButtonStyle outline = ComponentThemeButtonStyle<OutlineButtonTheme>(fallback: ButtonVariance(decoration: _buttonOutlineDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonOutlineTextStyle, iconTheme: _buttonOutlineIconTheme, margin: _buttonZeroMargin));
  /// Ghost button variant with minimal visual presence.
  ///
  /// Features no background or border by default, only showing on hover.
  static const AbstractButtonStyle ghost = ComponentThemeButtonStyle<GhostButtonTheme>(fallback: ButtonVariance(decoration: _buttonGhostDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonGhostTextStyle, iconTheme: _buttonGhostIconTheme, margin: _buttonZeroMargin));
  /// Link button variant resembling a text hyperlink.
  ///
  /// Features inline link styling with underline decoration.
  static const AbstractButtonStyle link = ComponentThemeButtonStyle<LinkButtonTheme>(fallback: ButtonVariance(decoration: _buttonLinkDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonLinkTextStyle, iconTheme: _buttonLinkIconTheme, margin: _buttonZeroMargin));
  /// Text button variant with only text content.
  ///
  /// Features minimal styling with no background or border decoration.
  static const AbstractButtonStyle text = ComponentThemeButtonStyle<TextButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonTextTextStyle, iconTheme: _buttonTextIconTheme, margin: _buttonZeroMargin));
  /// Destructive button variant for delete/remove actions.
  ///
  /// Features warning colors (typically red) to indicate data-destructive actions.
  static const AbstractButtonStyle destructive = ComponentThemeButtonStyle<DestructiveButtonTheme>(fallback: ButtonVariance(decoration: _buttonDestructiveDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonDestructiveTextStyle, iconTheme: _buttonDestructiveIconTheme, margin: _buttonZeroMargin));
  /// Fixed button variant with consistent dimensions.
  ///
  /// Features fixed sizing regardless of content, suitable for icon buttons.
  static const AbstractButtonStyle fixed = ComponentThemeButtonStyle<FixedButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonStaticTextStyle, iconTheme: _buttonStaticIconTheme, margin: _buttonZeroMargin));
  /// Menu button variant for dropdown menu triggers.
  ///
  /// Features appropriate spacing and styling for menu contexts.
  static const AbstractButtonStyle menu = ComponentThemeButtonStyle<MenuButtonTheme>(fallback: ButtonVariance(decoration: _buttonMenuDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonMenuPadding, textStyle: _buttonMenuTextStyle, iconTheme: _buttonMenuIconTheme, margin: _buttonZeroMargin));
  /// Menubar button variant for horizontal menu bars.
  ///
  /// Features optimized padding and styling for menubar contexts.
  static const AbstractButtonStyle menubar = ComponentThemeButtonStyle<MenubarButtonTheme>(fallback: ButtonVariance(decoration: _buttonMenuDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonMenubarPadding, textStyle: _buttonMenuTextStyle, iconTheme: _buttonMenuIconTheme, margin: _buttonZeroMargin));
  /// Muted button variant with subdued appearance.
  ///
  /// Features low-contrast styling for minimal visual impact.
  static const AbstractButtonStyle muted = ComponentThemeButtonStyle<MutedButtonTheme>(fallback: ButtonVariance(decoration: _buttonTextDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonPadding, textStyle: _buttonMutedTextStyle, iconTheme: _buttonMutedIconTheme, margin: _buttonZeroMargin));
  /// Card button variant with elevated appearance.
  ///
  /// Features subtle shadows and borders creating a card-like elevated look.
  static const AbstractButtonStyle card = ComponentThemeButtonStyle<CardButtonTheme>(fallback: ButtonVariance(decoration: _buttonCardDecoration, mouseCursor: _buttonMouseCursor, padding: _buttonCardPadding, textStyle: _buttonCardTextStyle, iconTheme: _buttonCardIconTheme, margin: _buttonZeroMargin));
  final ButtonStateProperty<Decoration> decoration;
  final ButtonStateProperty<MouseCursor> mouseCursor;
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  final ButtonStateProperty<TextStyle> textStyle;
  final ButtonStateProperty<IconThemeData> iconTheme;
  final ButtonStateProperty<EdgeInsetsGeometry> margin;
  /// Creates a custom [ButtonVariance] with the specified style properties.
  ///
  /// All parameters are required [ButtonStateProperty] functions that resolve
  /// values based on the button's current state.
  const ButtonVariance({required this.decoration, required this.mouseCursor, required this.padding, required this.textStyle, required this.iconTheme, required this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
