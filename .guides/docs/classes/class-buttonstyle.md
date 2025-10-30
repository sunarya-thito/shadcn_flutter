---
title: "Class: ButtonStyle"
description: "Configurable button style combining variance, size, density, and shape."
---

```dart
/// Configurable button style combining variance, size, density, and shape.
///
/// [ButtonStyle] implements [AbstractButtonStyle] and provides a composable way
/// to create button styles by combining a base variance (primary, secondary, outline,
/// etc.) with size, density, and shape modifiers. This allows for flexible button
/// customization while maintaining consistency.
///
/// The class provides named constructors for common button variants (primary,
/// secondary, outline, etc.) and can be further customized with size and density options.
///
/// Example:
/// ```dart
/// // Create a large primary button
/// const ButtonStyle.primary(
///   size: ButtonSize.large,
///   density: ButtonDensity.comfortable,
/// )
///
/// // Create a small outline button with circular shape
/// const ButtonStyle.outline(
///   size: ButtonSize.small,
///   shape: ButtonShape.circle,
/// )
/// ```
class ButtonStyle implements AbstractButtonStyle {
  /// The base style variance (primary, secondary, outline, etc.).
  final AbstractButtonStyle variance;
  /// The size configuration affecting padding and minimum dimensions.
  final ButtonSize size;
  /// The density configuration affecting spacing and compactness.
  final ButtonDensity density;
  /// The shape configuration (rectangle or circle).
  final ButtonShape shape;
  /// Creates a custom [ButtonStyle] with the specified variance and modifiers.
  ///
  /// Parameters:
  /// - [variance] (required): The base button style variant
  /// - [size]: The button size. Defaults to [ButtonSize.normal]
  /// - [density]: The button density. Defaults to [ButtonDensity.normal]
  /// - [shape]: The button shape. Defaults to [ButtonShape.rectangle]
  const ButtonStyle({required this.variance, this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a primary button style with prominent filled appearance.
  ///
  /// Primary buttons use the theme's primary color with high contrast, making them
  /// ideal for the main action on a screen.
  const ButtonStyle.primary({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a secondary button style with muted appearance.
  ///
  /// Secondary buttons have less visual prominence than primary buttons, suitable
  /// for supporting or alternative actions.
  const ButtonStyle.secondary({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates an outline button style with border and no background.
  ///
  /// Outline buttons feature a border with transparent background, providing a
  /// clear but subtle appearance for secondary actions.
  const ButtonStyle.outline({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a ghost button style with minimal visual presence.
  ///
  /// Ghost buttons have no background or border, only showing on hover, making
  /// them ideal for tertiary actions.
  const ButtonStyle.ghost({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a link button style resembling a text hyperlink.
  ///
  /// Link buttons appear as inline links with underline decoration, typically
  /// used for navigation or inline actions.
  const ButtonStyle.link({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a text-only button style with no background or border.
  ///
  /// Text buttons display only their text content, making them the most minimal
  /// button style for unobtrusive actions.
  const ButtonStyle.text({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a destructive button style for delete/remove actions.
  ///
  /// Destructive buttons use warning colors (typically red) to indicate actions
  /// that remove or delete data.
  const ButtonStyle.destructive({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a fixed-size button style with consistent dimensions.
  ///
  /// Fixed buttons maintain specific dimensions regardless of content, useful
  /// for icon buttons or grid layouts.
  const ButtonStyle.fixed({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a menu button style for dropdown menu triggers.
  ///
  /// Menu buttons are designed for triggering dropdown menus, with appropriate
  /// spacing and styling for menu contexts.
  const ButtonStyle.menu({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a menubar button style for menubar items.
  ///
  /// Menubar buttons are optimized for horizontal menu bars with appropriate
  /// padding and hover effects.
  const ButtonStyle.menubar({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a muted button style with subdued appearance.
  ///
  /// Muted buttons use low-contrast colors for minimal visual impact while
  /// remaining functional.
  const ButtonStyle.muted({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  /// Creates a primary icon button style with compact icon density.
  ///
  /// Icon buttons are optimized for displaying icons without text, using
  /// [ButtonDensity.icon] for appropriate spacing.
  const ButtonStyle.primaryIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a secondary icon button style with compact icon density.
  const ButtonStyle.secondaryIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates an outline icon button style with compact icon density.
  const ButtonStyle.outlineIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a ghost icon button style with compact icon density.
  const ButtonStyle.ghostIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a link icon button style with compact icon density.
  const ButtonStyle.linkIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a text icon button style with compact icon density.
  const ButtonStyle.textIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a destructive icon button style with compact icon density.
  const ButtonStyle.destructiveIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a fixed icon button style with compact icon density.
  const ButtonStyle.fixedIcon({this.size = ButtonSize.normal, this.density = ButtonDensity.icon, this.shape = ButtonShape.rectangle});
  /// Creates a card button style with elevated appearance.
  ///
  /// Card buttons feature subtle shadows and borders creating an elevated,
  /// card-like appearance suitable for content-heavy layouts.
  const ButtonStyle.card({this.size = ButtonSize.normal, this.density = ButtonDensity.normal, this.shape = ButtonShape.rectangle});
  ButtonStateProperty<Decoration> get decoration;
  ButtonStateProperty<MouseCursor> get mouseCursor;
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  ButtonStateProperty<TextStyle> get textStyle;
  ButtonStateProperty<IconThemeData> get iconTheme;
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}
```
