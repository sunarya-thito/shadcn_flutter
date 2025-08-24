import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builder function for creating custom dot indicator widgets.
///
/// This function is called for each dot in a dot indicator to allow complete
/// customization of dot appearance based on its state. The builder receives
/// the dot's index and active state, enabling different visual presentations
/// for active and inactive dots.
///
/// Parameters:
/// - [context] (BuildContext): Build context for theme and localization access
/// - [index] (int): Zero-based index of this dot in the indicator
/// - [active] (bool): Whether this dot represents the currently active item
///
/// Returns: Widget - A widget representing the dot indicator
///
/// Example:
/// ```dart
/// DotBuilder customDotBuilder = (context, index, active) {
///   return AnimatedContainer(
///     duration: Duration(milliseconds: 200),
///     width: active ? 16.0 : 8.0,
///     height: 8.0,
///     decoration: BoxDecoration(
///       color: active ? Colors.blue : Colors.grey,
///       borderRadius: BorderRadius.circular(4.0),
///     ),
///   );
/// };
/// ```
typedef DotBuilder = Widget Function(
    BuildContext context, int index, bool active);

/// Theme configuration for [DotIndicator] appearance and behavior.
///
/// [DotIndicatorTheme] provides comprehensive styling options for dot indicator
/// components including dot sizing, spacing, colors, and custom builders. It
/// integrates with the shadcn_flutter theming system to ensure consistent
/// dot indicator styling across applications.
///
/// The theme supports both default dot rendering and completely custom dot
/// builders, allowing for flexible visual presentation while maintaining
/// consistent behavior and accessibility features.
///
/// Example:
/// ```dart
/// ComponentTheme<DotIndicatorTheme>(
///   data: DotIndicatorTheme(
///     spacing: 8.0,
///     size: 10.0,
///     activeColor: Colors.blue,
///     inactiveColor: Colors.grey.shade300,
///     borderRadius: 5.0,
///     padding: EdgeInsets.all(16.0),
///   ),
///   child: DotIndicator(count: 5, activeIndex: 2),
/// )
/// ```
class DotIndicatorTheme {
  /// Horizontal spacing between individual dots.
  ///
  /// Controls the gap between adjacent dots in the indicator. Proper spacing
  /// ensures dots are visually distinct while maintaining a cohesive appearance.
  /// When null, uses a default spacing appropriate for the dot size.
  final double? spacing;

  /// Padding around the entire dots container.
  ///
  /// Provides external spacing around the complete dot indicator, useful for
  /// positioning the indicator within its parent layout. When null, uses
  /// minimal default padding.
  final EdgeInsetsGeometry? padding;

  /// Custom builder function for rendering individual dots.
  ///
  /// When provided, this builder is used instead of the default dot rendering.
  /// Allows complete customization of dot appearance, animation, and behavior.
  /// When null, uses the default dot rendering with theme colors and sizing.
  final DotBuilder? dotBuilder;

  /// Size of each dot in logical pixels.
  ///
  /// Controls both width and height of circular dots. Larger sizes improve
  /// accessibility on touch devices. When null, uses a default size that
  /// balances visibility with space efficiency.
  final double? size;

  /// Border radius for dot corners.
  ///
  /// Controls the rounding of dot corners. Use half the dot size for perfect
  /// circles, or smaller values for rounded rectangles. When null, creates
  /// circular dots by default.
  final double? borderRadius;

  /// Color of the active dot (representing current position).
  ///
  /// Should provide clear visual distinction from inactive dots to indicate
  /// the current position. When null, uses the theme's primary color for
  /// good visibility and brand consistency.
  final Color? activeColor;

  /// Color of inactive dots (not representing current position).
  ///
  /// Should be subtle enough to not distract from the active dot while
  /// remaining visible. When null, uses a muted color from the theme.
  final Color? inactiveColor;

  /// Border color for inactive dots.
  ///
  /// Provides additional visual definition for inactive dots, especially
  /// useful when the inactive color is very light or transparent. When null,
  /// no border is applied to inactive dots.
  final Color? inactiveBorderColor;

  /// Border width for inactive dots in logical pixels.
  ///
  /// Controls the thickness of the border around inactive dots when
  /// [inactiveBorderColor] is specified. When null, uses a minimal
  /// default border width.
  final double? inactiveBorderWidth;

  /// Creates a [DotIndicatorTheme] with optional styling properties.
  ///
  /// All parameters are optional and fall back to theme defaults when null.
  /// Use this constructor to customize dot indicator appearance throughout
  /// your application.
  ///
  /// Parameters:
  /// - [spacing]: Gap between dots
  /// - [padding]: External padding around indicator
  /// - [dotBuilder]: Custom dot rendering function
  /// - [size]: Size of each dot
  /// - [borderRadius]: Corner rounding for dots
  /// - [activeColor]: Color for the active dot
  /// - [inactiveColor]: Color for inactive dots
  /// - [inactiveBorderColor]: Border color for inactive dots
  /// - [inactiveBorderWidth]: Border thickness for inactive dots
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

  final int index;
  final int length;
  final ValueChanged<int>? onChanged;
  final double? spacing;
  final Axis direction;
  final EdgeInsetsGeometry? padding;
  final DotBuilder? dotBuilder;

  /// Creates a [DotIndicator].
  ///
  /// The indicator shows [length] dots with the dot at [index] highlighted
  /// as active. When [onChanged] is provided, tapping dots triggers navigation.
  ///
  /// Parameters:
  /// - [index] (int, required): current active dot position (0-based)
  /// - [length] (int, required): total number of dots to display
  /// - [onChanged] (ValueChanged<int>?, optional): callback when dot is tapped
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

class DotItem extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

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

class ActiveDotItem extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

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

class InactiveDotItem extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

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
    final borderColor =
        this.borderColor ?? compTheme?.inactiveBorderColor ?? theme.colorScheme.secondary;
    final borderWidth =
        this.borderWidth ?? compTheme?.inactiveBorderWidth ?? (2 * scaling);
    final color =
        this.color ?? compTheme?.inactiveColor;
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
