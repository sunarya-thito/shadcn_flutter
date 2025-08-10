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
      borderRadius:
          borderRadius == null ? this.borderRadius : borderRadius(),
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

class MenuPopup extends StatelessWidget {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final List<Widget> children;

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
