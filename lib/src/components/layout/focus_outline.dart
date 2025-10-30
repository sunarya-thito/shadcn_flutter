import '../../../shadcn_flutter.dart';

/// Theme configuration for focus outline appearance.
///
/// Defines styling properties for focus outlines that indicate which element
/// has keyboard focus. Used by [FocusOutline] to apply consistent focus
/// visualization across the application.
class FocusOutlineTheme {
  /// The alignment offset of the outline relative to the widget bounds.
  ///
  /// Positive values expand the outline outward, negative values contract it.
  final double? align;

  /// Border radius for rounded corners on the focus outline.
  final BorderRadiusGeometry? borderRadius;

  /// The border style for the focus outline.
  final Border? border;

  /// Creates a [FocusOutlineTheme].
  ///
  /// Parameters:
  /// - [align] (`double?`, optional): Outline alignment offset.
  /// - [border] (`Border?`, optional): Outline border style.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  const FocusOutlineTheme({
    this.align,
    this.border,
    this.borderRadius,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [border] (`ValueGetter<Border?>?`, optional): New border.
  /// - [align] (`ValueGetter<double?>?`, optional): New alignment offset.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius.
  ///
  /// Returns: A new [FocusOutlineTheme] with updated properties.
  FocusOutlineTheme copyWith({
    ValueGetter<Border?>? border,
    ValueGetter<double?>? align,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return FocusOutlineTheme(
      align: align == null ? this.align : align(),
      border: border == null ? this.border : border(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FocusOutlineTheme &&
        other.align == align &&
        other.border == border &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(border, align, borderRadius);
}

/// A widget that displays a visual outline when focused.
///
/// Wraps a child widget with a customizable border that appears when the
/// [focused] property is true. Commonly used to indicate keyboard focus state
/// for interactive elements.
///
/// Example:
/// ```dart
/// FocusOutline(
///   focused: hasFocus,
///   borderRadius: BorderRadius.circular(8),
///   child: TextButton(
///     onPressed: () {},
///     child: Text('Focused Button'),
///   ),
/// )
/// ```
class FocusOutline extends StatelessWidget {
  /// The child widget to wrap with the focus outline.
  final Widget child;

  /// Whether to display the focus outline.
  ///
  /// When `true`, the outline is visible. When `false`, it's hidden.
  final bool focused;

  /// Border radius for the focus outline corners.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final BorderRadiusGeometry? borderRadius;

  /// Alignment offset for positioning the outline.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final double? align;

  /// The border style for the outline.
  ///
  /// If `null`, uses the default from [FocusOutlineTheme].
  final Border? border;

  /// The shape of the outline.
  ///
  /// Can be [BoxShape.rectangle] or [BoxShape.circle].
  final BoxShape? shape;

  /// Creates a [FocusOutline].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to wrap.
  /// - [focused] (`bool`, required): Whether to show the outline.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  /// - [align] (`double?`, optional): Outline offset.
  /// - [border] (`Border?`, optional): Border style.
  /// - [shape] (`BoxShape?`, optional): Outline shape.
  const FocusOutline({
    super.key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align,
    this.border,
    this.shape,
  });

  BorderRadius _getAdjustedBorderRadius(
    TextDirection textDirection,
    double align,
    BorderRadiusGeometry? borderRadius,
  ) {
    var rawRadius = borderRadius;
    if (rawRadius == null) return BorderRadius.zero;
    var resolved = rawRadius.resolve(textDirection);
    return BorderRadius.only(
      topLeft: resolved.topLeft + Radius.circular(align),
      topRight: resolved.topRight + Radius.circular(align),
      bottomLeft: resolved.bottomLeft + Radius.circular(align),
      bottomRight: resolved.bottomRight + Radius.circular(align),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<FocusOutlineTheme>(context);
    final double align = styleValue(
      defaultValue: 3.0,
      themeValue: compTheme?.align,
      widgetValue: this.align,
    );
    final BorderRadiusGeometry? borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      widgetValue: this.borderRadius,
      defaultValue: null,
    );
    final double offset = -align;
    TextDirection textDirection = Directionality.of(context);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        AnimatedValueBuilder(
            value: focused ? 1.0 : 0.0,
            duration: kDefaultDuration,
            builder: (context, value, child) {
              return Positioned(
                top: offset * value,
                right: offset * value,
                bottom: offset * value,
                left: offset * value,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: shape != BoxShape.circle
                            ? _getAdjustedBorderRadius(
                                textDirection,
                                align,
                                borderRadius,
                              )
                            : null,
                        shape: shape ?? BoxShape.rectangle,
                        border: styleValue(
                          defaultValue: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .ring
                                .scaleAlpha(0.5),
                            width: 3.0,
                          ),
                          themeValue: compTheme?.border,
                          widgetValue: border,
                        ).scale(value)),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
