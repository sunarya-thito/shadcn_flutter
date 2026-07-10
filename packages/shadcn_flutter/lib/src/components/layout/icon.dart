import 'package:shadcn_flutter/shadcn_flutter.dart';
/// Provides themed icon container widgets for shadcn_flutter components.
///
/// Includes [IconContainerTheme] and [IconContainer] for styling icons with background, padding, and border radius.

class IconContainerTheme extends ComponentThemeData {
  /// Background color for the icon container.
  final Color? backgroundColor;
  /// Color for the icon inside the container.
  final Color? iconColor;
  /// Padding inside the icon container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the icon container.
  final BorderRadius? borderRadius;

  /// Creates an [IconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// Creates an [IconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  const IconContainerTheme({
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  IconContainerTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? iconColor,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderRadius?>? borderRadius,
  }) {
    return IconContainerTheme(
      backgroundColor:
          backgroundColor != null ? backgroundColor() : this.backgroundColor,
      iconColor: iconColor != null ? iconColor() : this.iconColor,
      padding: padding != null ? padding() : this.padding,
      borderRadius: borderRadius != null ? borderRadius() : this.borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconContainerTheme &&
        other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.padding == padding &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      iconColor,
      padding,
      borderRadius,
    );
  }
}

/// A container widget for displaying an icon with customizable padding, background, and border radius.
///
/// Use [IconContainer] to wrap an icon and apply theme or custom styling.
///
/// Example:
/// ```dart
/// IconContainer(
///   icon: Icon(Icons.star),
///   backgroundColor: Colors.yellow,
///   borderRadius: BorderRadius.circular(8),
/// )
/// ```
class IconContainer extends StatelessWidget {
  /// The icon widget to display.
  final Widget icon;
  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the container.
  final BorderRadius? borderRadius;
  /// Background color for the container.
  final Color? backgroundColor;
  /// Color for the icon.
  final Color? iconColor;
  /// Creates an [IconContainer].
  ///
  /// Parameters:
  /// - [icon] (`Widget`, required): Icon widget to display.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  const IconContainer({
    super.key,
    required this.icon,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<IconContainerTheme>(context);
    return Container(
      padding: styleValue(
          defaultValue: EdgeInsetsDensity.all(padXs)
              .resolveDensity(theme.density.baseContainerPadding),
          widgetValue: padding,
          themeValue: compTheme?.padding),
      decoration: BoxDecoration(
        color: styleValue(
            defaultValue: theme.colorScheme.primary,
            widgetValue: backgroundColor,
            themeValue: compTheme?.backgroundColor),
        borderRadius: styleValue(
            defaultValue: theme.borderRadiusMd,
            widgetValue: borderRadius,
            themeValue: compTheme?.borderRadius),
      ),
      child: IconTheme(
        data: IconThemeData(
          color: styleValue(
              defaultValue: theme.colorScheme.primaryForeground,
              widgetValue: iconColor,
              themeValue: compTheme?.iconColor),
        ),
        child: icon,
      ),
    );
  }
}
