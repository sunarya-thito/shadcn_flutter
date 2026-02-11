import 'package:shadcn_flutter/shadcn_flutter.dart';

class IconContainerTheme extends ComponentThemeData {
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const IconContainerTheme({
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
  });

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

class IconContainer extends StatelessWidget {
  final Widget icon;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
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
