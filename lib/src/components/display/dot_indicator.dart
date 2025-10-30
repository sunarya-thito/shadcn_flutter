import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builder function type for creating custom dot widgets.
///
/// Takes the build context, dot index, and whether the dot is active,
/// and returns a widget to display for that dot.
typedef DotBuilder = Widget Function(
    BuildContext context, int index, bool active);

/// Theme configuration for [DotIndicator] and its dot items.
class DotIndicatorTheme {
  /// Spacing between dots.
  final double? spacing;

  /// Padding around the dots container.
  final EdgeInsetsGeometry? padding;

  /// Builder for individual dots.
  final DotBuilder? dotBuilder;

  /// Size of each dot.
  final double? size;

  /// Border radius of dots.
  final double? borderRadius;

  /// Color of the active dot.
  final Color? activeColor;

  /// Color of the inactive dot.
  final Color? inactiveColor;

  /// Border color of the inactive dot.
  final Color? inactiveBorderColor;

  /// Border width of the inactive dot.
  final double? inactiveBorderWidth;

  /// Creates a [DotIndicatorTheme].
  const DotIndicatorTheme({
    this.spacing,
    this.padding,
    this.dotBuilder,
    this.size,
    this.borderRadius,
    this.activeColor,
    this.inactiveColor,
    this.inactiveBorderColor,
    this.inactiveBorderWidth,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  DotIndicatorTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<DotBuilder?>? dotBuilder,
    ValueGetter<double?>? size,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? inactiveBorderColor,
    ValueGetter<double?>? inactiveBorderWidth,
  }) {
    return DotIndicatorTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      padding: padding == null ? this.padding : padding(),
      dotBuilder: dotBuilder == null ? this.dotBuilder : dotBuilder(),
      size: size == null ? this.size : size(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      inactiveBorderColor: inactiveBorderColor == null
          ? this.inactiveBorderColor
          : inactiveBorderColor(),
      inactiveBorderWidth: inactiveBorderWidth == null
          ? this.inactiveBorderWidth
          : inactiveBorderWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DotIndicatorTheme &&
        other.spacing == spacing &&
        other.padding == padding &&
        other.dotBuilder == dotBuilder &&
        other.size == size &&
        other.borderRadius == borderRadius &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.inactiveBorderColor == inactiveBorderColor &&
        other.inactiveBorderWidth == inactiveBorderWidth;
  }

  @override
  int get hashCode => Object.hash(
      spacing,
      padding,
      dotBuilder,
      size,
      borderRadius,
      activeColor,
      inactiveColor,
      inactiveBorderColor,
      inactiveBorderWidth);
}

/// Navigation indicator with customizable dots showing current position in a sequence.
///
/// A visual indicator widget that displays a series of dots representing items
/// in a sequence, with one dot highlighted to show the current position.
/// Commonly used with carousels, page views, and stepper interfaces.
///
/// ## Features
///
/// - **Position indication**: Clear visual representation of current position
/// - **Interactive navigation**: Optional tap-to-navigate functionality
/// - **Flexible orientation**: Horizontal or vertical dot arrangement
/// - **Custom dot builders**: Complete control over dot appearance and behavior
/// - **Responsive spacing**: Automatic scaling with theme configuration
/// - **Accessibility support**: Screen reader friendly with semantic information
///
/// The indicator automatically highlights the dot at the current index and
/// can optionally respond to taps to change the active position.
///
/// Example:
/// ```dart
/// DotIndicator(
///   index: currentPage,
///   length: totalPages,
///   onChanged: (newIndex) => pageController.animateToPage(newIndex),
///   direction: Axis.horizontal,
///   spacing: 12.0,
/// );
/// ```
class DotIndicator extends StatelessWidget {
  static Widget _defaultDotBuilder(
      BuildContext context, int index, bool active) {
    return active ? const ActiveDotItem() : const InactiveDotItem();
  }

  /// The current active index (0-based).
  final int index;

  /// The total number of dots to display.
  final int length;

  /// Callback invoked when a dot is tapped.
  final ValueChanged<int>? onChanged;

  /// Spacing between dots.
  final double? spacing;

  /// The direction of the dot layout (horizontal or vertical).
  final Axis direction;

  /// Padding around the dots container.
  final EdgeInsetsGeometry? padding;

  /// Custom builder for individual dots.
  final DotBuilder? dotBuilder;

  /// Creates a [DotIndicator].
  ///
  /// The indicator shows [length] dots with the dot at [index] highlighted
  /// as active. When [onChanged] is provided, tapping dots triggers navigation.
  ///
  /// Parameters:
  /// - [index] (int, required): current active dot position (0-based)
  /// - [length] (int, required): total number of dots to display
  /// - [onChanged] (`ValueChanged<int>?`, optional): callback when dot is tapped
  /// - [spacing] (double?, optional): override spacing between dots
  /// - [direction] (Axis, default: horizontal): layout direction of dots
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around dot container
  /// - [dotBuilder] (DotBuilder?, optional): custom builder for dot widgets
  ///
  /// Example:
  /// ```dart
  /// DotIndicator(
  ///   index: 1,
  ///   length: 5,
  ///   onChanged: (index) => print('Navigate to $index'),
  ///   direction: Axis.horizontal,
  ///   dotBuilder: (context, index, active) => Container(
  ///     width: active ? 16 : 8,
  ///     height: 8,
  ///     decoration: BoxDecoration(
  ///       color: active ? Colors.blue : Colors.grey,
  ///       borderRadius: BorderRadius.circular(4),
  ///     ),
  ///   ),
  /// )
  /// ```
  const DotIndicator({
    super.key,
    required this.index,
    required this.length,
    this.onChanged,
    this.spacing,
    this.direction = Axis.horizontal,
    this.padding,
    this.dotBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final directionality = Directionality.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<DotIndicatorTheme>(context);
    final spacing = styleValue(
        widgetValue: this.spacing,
        themeValue: compTheme?.spacing,
        defaultValue: 8 * scaling);
    final padding = styleValue(
                widgetValue: this.padding,
                themeValue: compTheme?.padding,
                defaultValue: const EdgeInsets.all(8))
            .resolve(directionality) *
        theme.scaling;
    final dotBuilder =
        this.dotBuilder ?? compTheme?.dotBuilder ?? _defaultDotBuilder;
    List<Widget> children = [];
    for (int i = 0; i < length; i++) {
      double topPadding = padding.top;
      double bottomPadding = padding.bottom;
      double leftPadding = i == 0 ? padding.left : (spacing / 2);
      double rightPadding = i == length - 1 ? padding.right : (spacing / 2);
      final itemPadding = EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      );
      children.add(Flexible(
        child: Clickable(
          behavior: HitTestBehavior.translucent,
          onPressed: onChanged != null ? () => onChanged!(i) : null,
          mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
          child: Padding(
            padding: itemPadding,
            child: dotBuilder(context, i, i == index),
          ),
        ),
      ));
    }
    return IntrinsicHeight(
      child: Flex(
        direction: direction,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

/// A basic dot item widget with customizable appearance.
///
/// Used as a base component for creating custom dot indicators.
class DotItem extends StatelessWidget {
  /// The size of the dot.
  final double? size;

  /// The color of the dot.
  final Color? color;

  /// The border radius of the dot.
  final double? borderRadius;

  /// The border color of the dot.
  final Color? borderColor;

  /// The border width of the dot.
  final double? borderWidth;

  /// Creates a dot item with the specified properties.
  const DotItem({
    super.key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kDefaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        border: borderColor != null && borderWidth != null
            ? Border.all(color: borderColor!, width: borderWidth!)
            : null,
      ),
    );
  }
}

/// An active dot item widget representing the current position.
///
/// Styled to highlight the currently active item in a dot indicator.
class ActiveDotItem extends StatelessWidget {
  /// The size of the dot.
  final double? size;

  /// The color of the dot.
  final Color? color;

  /// The border radius of the dot.
  final double? borderRadius;

  /// The border color of the dot.
  final Color? borderColor;

  /// The border width of the dot.
  final double? borderWidth;

  /// Creates an active dot item with the specified properties.
  const ActiveDotItem({
    super.key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DotIndicatorTheme>(context);
    final scaling = theme.scaling;
    final size = styleValue(
        widgetValue: this.size,
        themeValue: compTheme?.size,
        defaultValue: 12 * scaling);
    final color = styleValue(
        widgetValue: this.color,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final borderRadius = styleValue(
        widgetValue: this.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radiusMd);
    final borderColor = this.borderColor;
    final borderWidth = this.borderWidth;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null && borderWidth != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
    );
  }
}

/// An inactive dot item widget representing non-current positions.
///
/// Styled to indicate inactive items in a dot indicator with
/// optional border styling.
class InactiveDotItem extends StatelessWidget {
  /// The size of the dot.
  final double? size;

  /// The color of the dot.
  final Color? color;

  /// The border radius of the dot.
  final double? borderRadius;

  /// The border color of the dot.
  final Color? borderColor;

  /// The border width of the dot.
  final double? borderWidth;

  /// Creates an inactive dot item with the specified properties.
  const InactiveDotItem({
    super.key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DotIndicatorTheme>(context);
    final scaling = theme.scaling;
    final size = styleValue(
        widgetValue: this.size,
        themeValue: compTheme?.size,
        defaultValue: 12 * scaling);
    final borderRadius = styleValue(
        widgetValue: this.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.radiusMd);
    final borderColor = this.borderColor ??
        compTheme?.inactiveBorderColor ??
        theme.colorScheme.secondary;
    final borderWidth =
        this.borderWidth ?? compTheme?.inactiveBorderWidth ?? (2 * scaling);
    final color = this.color ?? compTheme?.inactiveColor;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
