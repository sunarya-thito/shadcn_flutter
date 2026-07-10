import 'dart:ui';

import 'package:flutter/rendering.dart';

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
class DividerTheme extends ComponentThemeData {
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

  /// Alignment of [Divider.child] along the divider axis.
  final AxisAlignmentGeometry? childAlignment;

  /// Creates a [DividerTheme].
  const DividerTheme({
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
    this.childAlignment,
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
    ValueGetter<AxisAlignmentGeometry?>? childAlignment,
  }) {
    return DividerTheme(
      color: color == null ? this.color : color(),
      height: height == null ? this.height : height(),
      thickness: thickness == null ? this.thickness : thickness(),
      indent: indent == null ? this.indent : indent(),
      endIndent: endIndent == null ? this.endIndent : endIndent(),
      padding: padding == null ? this.padding : padding(),
      childAlignment:
          childAlignment == null ? this.childAlignment : childAlignment(),
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
      padding == other.padding &&
      childAlignment == other.childAlignment;

  @override
  int get hashCode => Object.hash(
      color, height, thickness, indent, endIndent, padding, childAlignment);
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

  /// Alignment of the [child] along the divider axis.
  final AxisAlignmentGeometry? childAlignment;

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
    this.childAlignment,
  });

  @override
  Size get preferredSize => Size(0, height ?? 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DividerTheme>(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final color = styleValue(
      widgetValue: this.color,
      themeValue: compTheme?.color,
      defaultValue: theme.colorScheme.border,
    );
    final densityGap = theme.density.baseGap * theme.scaling;
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
      defaultValue: EdgeInsets.symmetric(horizontal: densityGap),
    );
    final childAlignment = styleValue(
      widgetValue: this.childAlignment,
      themeValue: compTheme?.childAlignment,
      defaultValue: AxisAlignment.center,
    ).resolve(textDirection);
    if (child != null) {
      final clampedAlignmentValue = childAlignment.value.clamp(-1.0, 1.0);
      final leftRatio = (clampedAlignmentValue + 1) / 2;
      Widget buildLine(double lineIndent, double lineEndIndent) {
        return AnimatedValueBuilder(
            value: DividerProperties(
              color: color,
              thickness: thickness,
              indent: lineIndent,
              endIndent: lineEndIndent,
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
            });
      }

      return _DividerWithChild(
        leftRatio: leftRatio,
        lineHeight: height,
        leftLine: buildLine(indent, 0),
        content: child!.muted().small().withPadding(padding: padding),
        rightLine: buildLine(0, endIndent),
      );
    }
    return _DividerLine(
      lineHeight: height,
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

/// Lays out a single divider line, stretching it to fill the available
/// width only when the incoming constraints are bounded. Forcing an
/// infinite width inside an unbounded context (e.g. a [Column] nested in a
/// horizontal [SingleChildScrollView]) throws a layout error, so this
/// collapses to a zero-width line instead when unbounded, matching how
/// Material's `Divider` needs an `IntrinsicWidth` ancestor to stretch there.
class _DividerLine extends SingleChildRenderObjectWidget {
  final double lineHeight;

  const _DividerLine({
    required this.lineHeight,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderDividerLine(lineHeight: lineHeight);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderDividerLine renderObject) {
    renderObject.lineHeight = lineHeight;
  }
}

class _RenderDividerLine extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderDividerLine({required double lineHeight}) : _lineHeight = lineHeight;

  double _lineHeight;

  set lineHeight(double value) {
    if (_lineHeight == value) return;
    _lineHeight = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final width = constraints.hasBoundedWidth ? constraints.maxWidth : 0.0;
    child?.layout(BoxConstraints.tightFor(width: width, height: _lineHeight));
    size = constraints.constrain(Size(width, _lineHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result, position: position) ?? false;
  }
}

/// Lays out a [Divider]'s optional [child] between two divider lines,
/// splitting the remaining space to the left and right of it according to
/// [leftRatio]. When the incoming width constraints are unbounded, the
/// lines collapse to zero width instead of throwing, since there is no
/// bounded space to split between them.
class _DividerWithChild extends MultiChildRenderObjectWidget {
  final double leftRatio;
  final double lineHeight;

  _DividerWithChild({
    required this.leftRatio,
    required this.lineHeight,
    required Widget leftLine,
    required Widget content,
    required Widget rightLine,
  }) : super(children: [leftLine, content, rightLine]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderDividerWithChild(
      leftRatio: leftRatio,
      lineHeight: lineHeight,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderDividerWithChild renderObject) {
    renderObject
      ..leftRatio = leftRatio
      ..lineHeight = lineHeight;
  }
}

class _DividerParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderDividerWithChild extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DividerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DividerParentData> {
  _RenderDividerWithChild({
    required double leftRatio,
    required double lineHeight,
  })  : _leftRatio = leftRatio,
        _lineHeight = lineHeight;

  double _leftRatio;

  set leftRatio(double value) {
    if (_leftRatio == value) return;
    _leftRatio = value;
    markNeedsLayout();
  }

  double _lineHeight;

  set lineHeight(double value) {
    if (_lineHeight == value) return;
    _lineHeight = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DividerParentData) {
      child.parentData = _DividerParentData();
    }
  }

  @override
  void performLayout() {
    final children = getChildrenAsList();
    final leftLine = children[0];
    final content = children[1];
    final rightLine = children[2];

    content.layout(
      BoxConstraints(maxHeight: constraints.maxHeight),
      parentUsesSize: true,
    );

    final bounded = constraints.hasBoundedWidth;
    var leftWidth = 0.0;
    var rightWidth = 0.0;
    var totalWidth = content.size.width;
    if (bounded) {
      final remaining =
          (constraints.maxWidth - content.size.width).clamp(0.0, double.infinity);
      leftWidth = remaining * _leftRatio;
      rightWidth = remaining - leftWidth;
      totalWidth = constraints.maxWidth;
    }

    leftLine.layout(BoxConstraints.tightFor(width: leftWidth, height: _lineHeight));
    rightLine
        .layout(BoxConstraints.tightFor(width: rightWidth, height: _lineHeight));

    final height = _lineHeight > content.size.height ? _lineHeight : content.size.height;

    (leftLine.parentData! as _DividerParentData).offset =
        Offset(0, (height - _lineHeight) / 2);
    (content.parentData! as _DividerParentData).offset =
        Offset(leftWidth, (height - content.size.height) / 2);
    (rightLine.parentData! as _DividerParentData).offset =
        Offset(leftWidth + content.size.width, (height - _lineHeight) / 2);

    size = constraints.constrain(Size(totalWidth, height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
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

  /// Alignment of the [child] along the divider axis.
  final AxisAlignmentGeometry? childAlignment;

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
    this.childAlignment,
  });

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final resolvedChildAlignment =
        (childAlignment ?? AxisAlignment.center).resolve(textDirection);
    final lineWidth = width ?? 1;
    if (child != null) {
      final clampedAlignmentValue =
          resolvedChildAlignment.value.clamp(-1.0, 1.0);
      final topRatio = (clampedAlignmentValue + 1) / 2;
      Widget buildLine(double lineIndent, double lineEndIndent) {
        return AnimatedValueBuilder(
            value: DividerProperties(
              color: color ?? theme.colorScheme.border,
              thickness: thickness ?? 1,
              indent: lineIndent,
              endIndent: lineEndIndent,
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
            });
      }

      return _VerticalDividerWithChild(
        topRatio: topRatio,
        lineWidth: lineWidth,
        topLine: buildLine(indent ?? 0, 0),
        content: child!.muted().small().withPadding(padding: padding),
        bottomLine: buildLine(0, endIndent ?? 0),
      );
    }
    return _VerticalDividerLine(
      lineWidth: lineWidth,
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

/// Lays out a single divider line, stretching it to fill the available
/// height only when the incoming constraints are bounded. Forcing an
/// infinite height inside an unbounded context (e.g. a [Row] nested in a
/// [SingleChildScrollView]) throws a layout error, so this collapses to a
/// zero-height line instead when unbounded, matching how Material's
/// `VerticalDivider` needs an `IntrinsicHeight` ancestor to stretch there.
class _VerticalDividerLine extends SingleChildRenderObjectWidget {
  final double lineWidth;

  const _VerticalDividerLine({
    required this.lineWidth,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVerticalDividerLine(lineWidth: lineWidth);
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderVerticalDividerLine renderObject) {
    renderObject.lineWidth = lineWidth;
  }
}

class _RenderVerticalDividerLine extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderVerticalDividerLine({required double lineWidth})
      : _lineWidth = lineWidth;

  double _lineWidth;

  set lineWidth(double value) {
    if (_lineWidth == value) return;
    _lineWidth = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final height = constraints.hasBoundedHeight ? constraints.maxHeight : 0.0;
    child?.layout(BoxConstraints.tightFor(width: _lineWidth, height: height));
    size = constraints.constrain(Size(_lineWidth, height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result, position: position) ?? false;
  }
}

/// Lays out a [VerticalDivider]'s optional [child] between two divider
/// lines, splitting the remaining space above and below it according to
/// [topRatio]. When the incoming height constraints are unbounded, the
/// lines collapse to zero height instead of throwing, since there is no
/// bounded space to split between them.
class _VerticalDividerWithChild extends MultiChildRenderObjectWidget {
  final double topRatio;
  final double lineWidth;

  _VerticalDividerWithChild({
    required this.topRatio,
    required this.lineWidth,
    required Widget topLine,
    required Widget content,
    required Widget bottomLine,
  }) : super(children: [topLine, content, bottomLine]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVerticalDividerWithChild(
      topRatio: topRatio,
      lineWidth: lineWidth,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderVerticalDividerWithChild renderObject) {
    renderObject
      ..topRatio = topRatio
      ..lineWidth = lineWidth;
  }
}

class _VerticalDividerParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderVerticalDividerWithChild extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _VerticalDividerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _VerticalDividerParentData> {
  _RenderVerticalDividerWithChild({
    required double topRatio,
    required double lineWidth,
  })  : _topRatio = topRatio,
        _lineWidth = lineWidth;

  double _topRatio;

  set topRatio(double value) {
    if (_topRatio == value) return;
    _topRatio = value;
    markNeedsLayout();
  }

  double _lineWidth;

  set lineWidth(double value) {
    if (_lineWidth == value) return;
    _lineWidth = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _VerticalDividerParentData) {
      child.parentData = _VerticalDividerParentData();
    }
  }

  @override
  void performLayout() {
    final children = getChildrenAsList();
    final topLine = children[0];
    final content = children[1];
    final bottomLine = children[2];

    content.layout(
      BoxConstraints(maxWidth: constraints.maxWidth),
      parentUsesSize: true,
    );

    final bounded = constraints.hasBoundedHeight;
    var topHeight = 0.0;
    var bottomHeight = 0.0;
    var totalHeight = content.size.height;
    if (bounded) {
      final remaining =
          (constraints.maxHeight - content.size.height).clamp(0.0, double.infinity);
      topHeight = remaining * _topRatio;
      bottomHeight = remaining - topHeight;
      totalHeight = constraints.maxHeight;
    }

    topLine.layout(BoxConstraints.tightFor(width: _lineWidth, height: topHeight));
    bottomLine
        .layout(BoxConstraints.tightFor(width: _lineWidth, height: bottomHeight));

    final width = _lineWidth > content.size.width ? _lineWidth : content.size.width;

    (topLine.parentData! as _VerticalDividerParentData).offset =
        Offset((width - _lineWidth) / 2, 0);
    (content.parentData! as _VerticalDividerParentData).offset =
        Offset((width - content.size.width) / 2, topHeight);
    (bottomLine.parentData! as _VerticalDividerParentData).offset =
        Offset((width - _lineWidth) / 2, topHeight + content.size.height);

    size = constraints.constrain(Size(width, totalHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
