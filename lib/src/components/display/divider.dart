import 'dart:ui';

import '../../../shadcn_flutter.dart';

/// Properties that define the visual appearance of divider components.
///
/// Contains styling information for dividers including color, thickness,
/// and indentation values. Used by divider widgets to maintain consistent
/// appearance and enable smooth animations between different states.
///
/// Example:
/// ```dart
/// const properties = DividerProperties(
///   color: Colors.grey,
///   thickness: 1.0,
///   indent: 16.0,
///   endIndent: 16.0,
/// );
/// ```
class DividerProperties {
  /// The color of the divider line.
  final Color color;

  /// The thickness of the divider line in logical pixels.
  final double thickness;

  /// The amount of empty space before the divider line.
  final double indent;

  /// The amount of empty space after the divider line.
  final double endIndent;

  /// Creates [DividerProperties] with the specified styling values.
  ///
  /// Parameters:
  /// - [color] (Color, required): The color of the divider.
  /// - [thickness] (double, required): The thickness of the divider.
  /// - [indent] (double, required): Leading indent space.
  /// - [endIndent] (double, required): Trailing indent space.
  const DividerProperties({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  /// Linearly interpolates between two [DividerProperties] instances.
  ///
  /// Animates all properties (color, thickness, indents) from the first
  /// instance to the second using the interpolation factor. Used for
  /// smooth transitions in animated dividers.
  ///
  /// Parameters:
  /// - [a] (DividerProperties): The starting properties.
  /// - [b] (DividerProperties): The ending properties.
  /// - [t] (double): The interpolation factor (0.0 to 1.0).
  ///
  /// Returns:
  /// A [DividerProperties] instance with interpolated values.
  ///
  /// Example:
  /// ```dart
  /// final result = DividerProperties.lerp(startProps, endProps, 0.5);
  /// ```
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
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

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

class DividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

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

class VerticalDividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

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

class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

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
