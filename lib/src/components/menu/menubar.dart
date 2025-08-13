import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [Menubar].
class MenubarTheme {
  /// Whether to draw border around the menubar.
  final bool? border;

  /// Offset of submenu popovers.
  final Offset? subMenuOffset;

  /// Padding inside the menubar.
  final EdgeInsetsGeometry? padding;

  /// Color of the border when [border] is true.
  final Color? borderColor;

  /// Background color of the menubar container.
  final Color? backgroundColor;

  /// Border radius of the menubar container.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [MenubarTheme].
  const MenubarTheme({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  MenubarTheme copyWith({
    ValueGetter<bool?>? border,
    ValueGetter<Offset?>? subMenuOffset,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? borderColor,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return MenubarTheme(
      border: border == null ? this.border : border(),
      subMenuOffset:
          subMenuOffset == null ? this.subMenuOffset : subMenuOffset(),
      padding: padding == null ? this.padding : padding(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenubarTheme &&
        other.border == border &&
        other.subMenuOffset == subMenuOffset &&
        other.padding == padding &&
        other.borderColor == borderColor &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        border,
        subMenuOffset,
        padding,
        borderColor,
        backgroundColor,
        borderRadius,
      );
}

class Menubar extends StatefulWidget {
  final List<MenuItem> children;
  final Offset? popoverOffset;
  final bool border;

  const Menubar({
    super.key,
    this.popoverOffset,
    this.border = true,
    required this.children,
  });

  @override
  State<Menubar> createState() => MenubarState();
}

class MenubarState extends State<Menubar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<MenubarTheme>(context);
    final bool border = compTheme?.border ?? widget.border;
    final borderColor = compTheme?.borderColor ?? theme.colorScheme.border;
    final backgroundColor =
        compTheme?.backgroundColor ?? theme.colorScheme.background;
    final borderRadius = compTheme?.borderRadius ?? theme.borderRadiusMd;
    final padding =
        compTheme?.padding ?? const EdgeInsets.all(4) * theme.scaling;

    if (border) {
      return OutlinedContainer(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        child: AnimatedPadding(
          duration: kDefaultDuration,
          padding: padding,
          child: buildContainer(context, theme,
              compTheme?.subMenuOffset ?? widget.popoverOffset, border),
        ),
      );
    }
    return buildContainer(context, theme,
        compTheme?.subMenuOffset ?? widget.popoverOffset, border);
  }

  Widget buildContainer(BuildContext context, ThemeData theme,
      Offset? subMenuOffset, bool border) {
    final scaling = theme.scaling;
    final offset = subMenuOffset ??
        ((border ? const Offset(-4, 8) : const Offset(0, 4)) * scaling);
    return Data.inherit(
      data: this,
      child: MenuGroup(
        regionGroupId: this,
        direction: Axis.vertical,
        itemPadding: EdgeInsets.zero,
        subMenuOffset: offset,
        autofocus: false,
        builder: (context, children) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ).medium();
        },
        children: widget.children,
      ),
    );
  }
}
