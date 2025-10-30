import 'dart:ui';

import '../../../shadcn_flutter.dart';

/// Immutable properties for divider appearance.
///
/// [DividerProperties] stores the visual characteristics of a divider,
/// including color, thickness, and indentation. This class is used for
/// theme interpolation and default value management.
///
/// All properties are required and non-nullable.
class DividerProperties {
  /// The color of the divider line.
  final Color color;

  /// The thickness of the divider line in logical pixels.
  final double thickness;

  /// The amount of empty space to the leading edge of the divider.
  final double indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double endIndent;

  /// Creates divider properties with the specified values.
  const DividerProperties({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  /// Linearly interpolates between two [DividerProperties] objects.
  ///
  /// Used for smooth theme transitions. Parameter [t] should be between 0.0 and 1.0,
  /// where 0.0 returns [a] and 1.0 returns [b].
  static DividerProperties lerp(
      DividerProperties a, DividerProperties b, double t) {
    return DividerProperties(
      color: Color.lerp(a.color, b.color, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      indent: lerpDouble(a.indent, b.indent, t)!,
      endIndent: lerpDouble(a.endIndent, b.endIndent, t)!,
    );
  }
}

/// Theme data for customizing [Divider] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Divider] widgets, including line color, dimensions, spacing, and
/// child padding. These properties can be set at the theme level
/// to provide consistent styling across the application.
class DividerTheme {
  /// Color of the divider line.
  final Color? color;

  /// Height of the divider widget.
  final double? height;

  /// Thickness of the divider line.
  final double? thickness;

  /// Empty space to the leading edge of the divider.
  final double? indent;

  /// Empty space to the trailing edge of the divider.
  final double? endIndent;

  /// Padding around the [Divider.child].
  final EdgeInsetsGeometry? padding;

  /// Creates a [DividerTheme].
  const DividerTheme({
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
  });

  /// Creates a copy of this theme but with the given fields replaced by the
  /// new values.
  DividerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? height,
    ValueGetter<double?>? thickness,
    ValueGetter<double?>? indent,
    ValueGetter<double?>? endIndent,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return DividerTheme(
      color: color == null ? this.color : color(),
      height: height == null ? this.height : height(),
      thickness: thickness == null ? this.thickness : thickness(),
      indent: indent == null ? this.indent : indent(),
      endIndent: endIndent == null ? this.endIndent : endIndent(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DividerTheme &&
      color == other.color &&
      height == other.height &&
      thickness == other.thickness &&
      indent == other.indent &&
      endIndent == other.endIndent &&
      padding == other.padding;

  @override
  int get hashCode =>
      Object.hash(color, height, thickness, indent, endIndent, padding);
}

/// A horizontal line widget used to visually separate content sections.
///
/// [Divider] creates a thin horizontal line that spans the available width,
/// optionally with indentation from either end. It's commonly used to separate
/// content sections, list items, or create visual breaks in layouts. The divider
/// can optionally contain a child widget (such as text) that appears centered
/// on the divider line.
///
/// Key features:
/// - Horizontal line spanning available width
/// - Configurable thickness and color
/// - Optional indentation from start and end
/// - Support for child widgets (text, icons, etc.)
/// - Customizable padding around child content
/// - Theme integration for consistent styling
/// - Implements PreferredSizeWidget for flexible layout
///
/// The divider automatically adapts to the current theme's border color
/// and can be customized through individual properties or theme configuration.
/// When a child is provided, the divider line is broken to accommodate the
/// child content with appropriate padding.
///
/// Common use cases:
/// - Separating sections in forms or settings screens
/// - Creating breaks between list items
/// - Dividing content areas in complex layouts
/// - Adding labeled dividers with text or icons
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('Section 1'),
///     Divider(),
///     Text('Section 2'),
///     Divider(
///       child: Text('OR', style: TextStyle(color: Colors.grey)),
///       thickness: 2,
///       indent: 20,
///       endIndent: 20,
///     ),
///     Text('Section 3'),
///   ],
/// );
/// ```
class Divider extends StatelessWidget implements PreferredSizeWidget {
  /// The color of the divider line.
  final Color? color;

  /// The total height of the divider (including padding).
  final double? height;

  /// The thickness of the divider line.
  final double? thickness;

  /// The amount of empty space before the divider line starts.
  final double? indent;

  /// The amount of empty space after the divider line ends.
  final double? endIndent;

  /// Optional child widget to display alongside the divider (e.g., text label).
  final Widget? child;

  /// Padding around the divider content.
  final EdgeInsetsGeometry? padding;

  /// Creates a horizontal divider.
  const Divider({
    super.key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding,
  });

  @override
  Size get preferredSize => Size(0, height ?? 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DividerTheme>(context);
    final color = styleValue(
      widgetValue: this.color,
      themeValue: compTheme?.color,
      defaultValue: theme.colorScheme.border,
    );
    final thickness = styleValue(
      widgetValue: this.thickness,
      themeValue: compTheme?.thickness,
      defaultValue: 1.0,
    );
    final height = styleValue(
      widgetValue: this.height,
      themeValue: compTheme?.height,
      defaultValue: thickness,
    );
    final indent = styleValue(
      widgetValue: this.indent,
      themeValue: compTheme?.indent,
      defaultValue: 0.0,
    );
    final endIndent = styleValue(
      widgetValue: this.endIndent,
      themeValue: compTheme?.endIndent,
      defaultValue: 0.0,
    );
    final padding = styleValue(
      widgetValue: this.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(horizontal: theme.scaling * 8),
    );
    if (child != null) {
      return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: height,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color,
                        thickness: thickness,
                        indent: indent,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(padding: padding),
              Expanded(
                child: SizedBox(
                  height: height,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color,
                        thickness: thickness,
                        indent: 0,
                        endIndent: endIndent,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: double.infinity,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: DividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}

/// Custom painter for drawing horizontal divider lines.
///
/// Renders a horizontal line with specified color, thickness, and indents.
class DividerPainter extends CustomPainter {
  /// The color of the divider line.
  final Color color;

  /// The thickness of the divider line.
  final double thickness;

  /// The indent from the start edge.
  final double indent;

  /// The indent from the end edge.
  final double endIndent;

  /// Creates a divider painter with the specified properties.
  DividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(indent, size.height / 2);
    final end = Offset(size.width - endIndent, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant DividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

/// Custom painter for drawing vertical divider lines.
///
/// Renders a vertical line with specified color, thickness, and indents.
class VerticalDividerPainter extends CustomPainter {
  /// The color of the divider line.
  final Color color;

  /// The thickness of the divider line.
  final double thickness;

  /// The indent from the top edge.
  final double indent;

  /// The indent from the bottom edge.
  final double endIndent;

  /// Creates a vertical divider painter with the specified properties.
  const VerticalDividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(size.width / 2, indent);
    final end = Offset(size.width / 2, size.height - endIndent);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant VerticalDividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

/// A vertical line used to separate content in a layout.
///
/// Similar to [Divider] but renders vertically, useful for separating
/// content in horizontal layouts like rows or navigation panels.
class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  /// The color of the divider line.
  final Color? color;

  /// The total width of the divider (including padding).
  final double? width;

  /// The thickness of the divider line.
  final double? thickness;

  /// The amount of empty space before the divider line starts.
  final double? indent;

  /// The amount of empty space after the divider line ends.
  final double? endIndent;

  /// Optional child widget to display alongside the divider.
  final Widget? child;

  /// Padding around the divider content.
  final EdgeInsetsGeometry? padding;

  /// Creates a vertical divider.
  const VerticalDivider({
    super.key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return SizedBox(
        height: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: indent ?? 0,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(padding: padding),
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: 0,
                        endIndent: endIndent ?? 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: width ?? 1,
      height: double.infinity,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color ?? theme.colorScheme.border,
            thickness: thickness ?? 1,
            indent: indent ?? 0,
            endIndent: endIndent ?? 0,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: VerticalDividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}
