import '../../../shadcn_flutter.dart';

/// A theme for [MenuPopup].
class MenuPopupTheme {
  /// The opacity of the surface.
  final double? surfaceOpacity;

  /// The blur applied to the surface.
  final double? surfaceBlur;

  /// The padding inside the popup.
  final EdgeInsetsGeometry? padding;

  /// The background color of the popup.
  final Color? fillColor;

  /// The border color of the popup.
  final Color? borderColor;

  /// The border radius of the popup.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [MenuPopupTheme].
  const MenuPopupTheme({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  MenuPopupTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? fillColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return MenuPopupTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      padding: padding == null ? this.padding : padding(),
      fillColor: fillColor == null ? this.fillColor : fillColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuPopupTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.padding == padding &&
        other.fillColor == fillColor &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        surfaceOpacity,
        surfaceBlur,
        padding,
        fillColor,
        borderColor,
        borderRadius,
      );
}

/// A styled container widget for displaying popup menus.
///
/// Provides a consistent visual container for menu items with customizable
/// appearance including background, borders, padding, and surface effects.
/// Automatically adapts its layout based on context (sheet overlay, dialog, etc.).
///
/// Features:
/// - **Surface Effects**: Configurable opacity and blur for backdrop
/// - **Styled Border**: Custom border color and radius
/// - **Flexible Layout**: Automatically adjusts for vertical/horizontal menus
/// - **Scrollable**: Content scrolls when it exceeds available space
/// - **Themeable**: Integrates with component theming system
///
/// Typically used as a container for menu items within dropdown menus,
/// context menus, or other popup menu components.
///
/// Example:
/// ```dart
/// MenuPopup(
///   padding: EdgeInsets.all(8),
///   fillColor: Colors.white,
///   borderRadius: BorderRadius.circular(8),
///   children: [
///     MenuItem(title: Text('Option 1')),
///     MenuItem(title: Text('Option 2')),
///     MenuItem(title: Text('Option 3')),
///   ],
/// )
/// ```
///
/// See also:
/// - [MenuPopupTheme] for theming options
/// - [MenuItem] for individual menu items
/// - [DropdownMenu] for complete dropdown menu implementation
class MenuPopup extends StatelessWidget {
  /// Opacity of the surface blur effect.
  ///
  /// Controls the transparency of the backdrop blur. Higher values make
  /// the blur more visible. If `null`, uses theme default.
  final double? surfaceOpacity;

  /// Amount of blur to apply to the surface behind the popup.
  ///
  /// Higher values create more blur effect. If `null`, uses theme default.
  final double? surfaceBlur;

  /// Internal padding around the menu items.
  ///
  /// Defines the space between the popup's border and its content.
  /// If `null`, uses theme default or adaptive default based on overlay type.
  final EdgeInsetsGeometry? padding;

  /// Background fill color of the popup.
  ///
  /// If `null`, uses the theme's popover color.
  final Color? fillColor;

  /// Border color of the popup.
  ///
  /// If `null`, uses the theme's border color.
  final Color? borderColor;

  /// Corner radius of the popup border.
  ///
  /// If `null`, uses the theme's medium border radius.
  final BorderRadiusGeometry? borderRadius;

  /// The menu items to display inside the popup.
  ///
  /// Typically a list of [MenuItem] widgets or similar menu components.
  final List<Widget> children;

  /// Creates a menu popup container.
  ///
  /// Parameters:
  /// - [children]: Menu items to display (required)
  /// - [surfaceOpacity]: Backdrop blur opacity
  /// - [surfaceBlur]: Amount of surface blur
  /// - [padding]: Internal padding
  /// - [fillColor]: Background color
  /// - [borderColor]: Border color
  /// - [borderRadius]: Corner radius
  const MenuPopup({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    required this.children,
  });

  Widget _buildIntrinsicContainer(Widget child, Axis direction, bool wrap) {
    if (!wrap) {
      return child;
    }
    if (direction == Axis.vertical) {
      return IntrinsicWidth(child: child);
    }
    return IntrinsicHeight(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<MenuGroupData>(context);
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<MenuPopupTheme>(context);
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = DialogOverlayHandler.isDialogOverlay(context);
    final pad = styleValue(
        widgetValue: padding,
        themeValue: compTheme?.padding,
        defaultValue: isSheetOverlay
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 4) *
                theme.scaling
            : const EdgeInsets.all(4) * theme.scaling);
    return ModalContainer(
      borderRadius: styleValue(
          widgetValue: borderRadius,
          themeValue: compTheme?.borderRadius,
          defaultValue: theme.borderRadiusMd),
      filled: true,
      fillColor: styleValue(
          widgetValue: fillColor,
          themeValue: compTheme?.fillColor,
          defaultValue: theme.colorScheme.popover),
      borderColor: styleValue(
          widgetValue: borderColor,
          themeValue: compTheme?.borderColor,
          defaultValue: theme.colorScheme.border),
      surfaceBlur: styleValue(
          widgetValue: surfaceBlur,
          themeValue: compTheme?.surfaceBlur,
          defaultValue: theme.surfaceBlur),
      surfaceOpacity: styleValue(
          widgetValue: surfaceOpacity,
          themeValue: compTheme?.surfaceOpacity,
          defaultValue: theme.surfaceOpacity),
      padding: pad,
      child: SingleChildScrollView(
        scrollDirection: data?.direction ?? Axis.vertical,
        child: _buildIntrinsicContainer(
          Flex(
            direction: data?.direction ?? Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
          data?.direction ?? Axis.vertical,
          !isSheetOverlay && !isDialogOverlay,
        ),
      ),
    ).normal();
  }
}
