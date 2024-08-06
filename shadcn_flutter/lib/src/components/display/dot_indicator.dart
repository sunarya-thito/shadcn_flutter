import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef DotBuilder = Widget Function(
    BuildContext context, int index, bool active);

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

  const DotIndicator({
    Key? key,
    required this.index,
    required this.length,
    this.onChanged,
    this.spacing,
    this.direction = Axis.horizontal,
    this.padding,
    this.dotBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final directionality = Directionality.of(context);
    final scaling = theme.scaling;
    final spacing = this.spacing ?? (8 * scaling);
    final padding =
        (this.padding ?? const EdgeInsets.all(8)).resolve(directionality) *
            theme.scaling;
    final dotBuilder = this.dotBuilder ?? _defaultDotBuilder;
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
    Key? key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    Key? key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final size = this.size ?? (12 * scaling);
    final color = this.color ?? theme.colorScheme.primary;
    final borderRadius = this.borderRadius ?? theme.radiusMd;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null && borderWidth != null
            ? Border.all(color: borderColor!, width: borderWidth!)
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
    Key? key,
    this.size,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final size = this.size ?? (12 * scaling);
    final borderRadius = this.borderRadius ?? theme.radiusMd;
    final borderColor = this.borderColor ?? theme.colorScheme.secondary;
    final borderWidth = this.borderWidth ?? (2 * scaling);
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
