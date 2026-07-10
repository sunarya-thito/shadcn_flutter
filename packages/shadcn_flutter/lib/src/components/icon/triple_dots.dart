import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that displays multiple dots, commonly used for loading indicators or menus.
///
/// Creates a customizable row or column of circular dots that can be used as a
/// "more" indicator, loading animation, or menu icon. The number, size, color,
/// and spacing of dots can be configured.
///
/// Example:
/// ```dart
/// // Horizontal three-dot menu icon
/// MoreDots(
///   count: 3,
///   direction: Axis.horizontal,
///   spacing: 4,
/// )
///
/// // Vertical loading indicator
/// MoreDots(
///   count: 5,
///   direction: Axis.vertical,
///   color: Colors.blue,
/// )
/// ```
class MoreDots extends StatelessWidget {
  /// The layout direction of the dots.
  ///
  /// Can be [Axis.horizontal] for a row or [Axis.vertical] for a column.
  /// Defaults to horizontal.
  final Axis direction;

  /// The number of dots to display.
  ///
  /// Defaults to `3`.
  final int count;

  /// The size (diameter) of each dot.
  ///
  /// If `null`, calculates size based on the text style font size (20% of font size).
  final double? size;

  /// The color of the dots.
  ///
  /// If `null`, uses the current text color from the theme.
  final Color? color;

  /// The spacing between dots.
  ///
  /// Defaults to `2`.
  final double spacing;

  /// Padding around the entire dots group.
  ///
  /// If `null`, no padding is applied.
  final EdgeInsetsGeometry? padding;

  /// Creates a [MoreDots].
  ///
  /// Parameters:
  /// - [direction] (`Axis`, default: `Axis.horizontal`): Layout direction.
  /// - [count] (`int`, default: `3`): Number of dots.
  /// - [size] (`double?`, optional): Dot diameter.
  /// - [color] (`Color?`, optional): Dot color.
  /// - [spacing] (`double`, default: `2`): Space between dots.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Outer padding.
  const MoreDots({
    super.key,
    this.direction = Axis.horizontal,
    this.count = 3,
    this.size,
    this.color,
    this.spacing = 2,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = DefaultTextStyle.of(context).style;
    Color color = this.color ?? style.color!;
    double size = this.size ?? (style.fontSize ?? 12) * 0.2;
    List<Widget> children = [];
    for (int i = 0; i < count; i++) {
      children.add(Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ));
      if (i < count - 1) {
        children.add(SizedBox(
          width: direction == Axis.horizontal ? spacing : null,
          height: direction == Axis.vertical ? spacing : null,
        ));
      }
    }
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
    );
  }
}
