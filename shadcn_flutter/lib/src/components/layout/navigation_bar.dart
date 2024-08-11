import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationBar extends StatelessWidget {
  final Color? backgroundColor;
  final bool extended;
  final int? index;
  final ValueChanged<int?>? onChanged;
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final bool canUnselect;
  final Axis direction;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  const NavigationBar({
    Key? key,
    this.backgroundColor,
    this.extended = true,
    this.index,
    this.onChanged,
    this.alignment = AlignmentDirectional.center,
    this.canUnselect = false,
    this.direction = Axis.horizontal,
    this.spacing,
    this.labelType = NavigationLabelType.selected,
    this.padding,
    this.constraints,
    required this.children,
  }) : super(key: key);

  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(
      minHeight: 48 * scaling,
      maxHeight: 48 * scaling,
    );
  }

  EdgeInsets _childPadding(EdgeInsets padding, Axis direction) {
    if (direction == Axis.vertical) {
      return EdgeInsets.only(left: padding.left, right: padding.right);
    }
    return EdgeInsets.only(top: padding.top, bottom: padding.bottom);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> children = List.of(this.children);
    var parentPadding = padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    return Data.inherit(
      data: NavigationControlData(
        parentLabelType: labelType,
        parentPadding: resolvedPadding,
        direction: direction,
      ),
      child: ConstrainedBox(
        constraints: constraints ?? getDefaultConstraints(context, theme),
        child: ClipRect(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            scrollDirection: direction,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _GapHeader(_startPadding(resolvedPadding, direction)),
              ),
              ...children.map(
                (e) {
                  return SliverPadding(
                    padding: _childPadding(resolvedPadding, direction),
                    sliver: e,
                  ) as Widget;
                },
              ).joinSeparator(
                SliverGap(spacing ?? 0),
              ),
              SliverGap(_endPadding(resolvedPadding, direction)),
            ],
          ),
        ),
      ),
    );
  }
}

double _startPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.left;
  }
  return padding.top;
}

double _endPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.right;
  }
  return padding.bottom;
}

class _GapHeader extends SliverPersistentHeaderDelegate {
  final double extent;

  _GapHeader(this.extent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.background;
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    return SizedBox(
      height: direction == Axis.horizontal ? null : extent,
      width: direction == Axis.vertical ? null : extent,
      child: CustomPaint(
        painter: _NavigationLabelBackgroundPainter(
          color: color,
          indent: -_startPadding(parentPadding, direction),
          endIndent: -_endPadding(parentPadding, direction),
          direction: direction,
        ),
      ),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(covariant _GapHeader oldDelegate) {
    return oldDelegate.extent != extent;
  }
}

// basically a copy of the NavigationBar class, but with different direction (vertical)
class NavigationRail extends NavigationBar {
  const NavigationRail({
    super.key,
    super.backgroundColor,
    super.extended,
    super.index,
    super.onChanged,
    super.alignment = AlignmentDirectional.topCenter,
    super.canUnselect,
    super.direction = Axis.vertical,
    super.spacing,
    super.labelType = NavigationLabelType.selected,
    super.padding,
    required super.children,
  });

  @override
  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(
      minWidth: 48 * scaling,
      maxWidth: 48 * scaling,
    );
  }
}

class NavigationSidebar extends NavigationBar {
  const NavigationSidebar({
    super.key,
    super.backgroundColor,
    super.extended,
    super.index,
    super.onChanged,
    super.alignment = AlignmentDirectional.topCenter,
    super.canUnselect,
    super.direction = Axis.vertical,
    super.spacing,
    super.labelType = NavigationLabelType.expanded,
    super.padding,
    required super.children,
  });

  @override
  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(
      minWidth: 240 * scaling,
      maxWidth: 240 * scaling,
    );
  }
}

enum NavigationLabelType {
  none,
  selected,
  all,
  expanded,
}

class NavigationControlData {
  final NavigationLabelType parentLabelType;
  final EdgeInsets parentPadding;
  final Axis direction;

  NavigationControlData({
    required this.parentLabelType,
    required this.parentPadding,
    required this.direction,
  });
}

class NavigationDivider extends StatelessWidget {
  final double? thickness;
  final Color? color;

  const NavigationDivider({
    Key? key,
    this.thickness,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    if (direction == Axis.vertical) {
      return SliverToBoxAdapter(
        child: Divider(
          indent: -parentPadding.left,
          endIndent: -parentPadding.right,
          thickness: thickness ?? (1 * scaling),
          color: color ?? theme.colorScheme.muted,
        ),
      );
    }
    return SliverToBoxAdapter(
      child: VerticalDivider(
        indent: -parentPadding.top,
        endIndent: -parentPadding.bottom,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      ),
    );
  }
}

class NavigationButton extends StatefulWidget {
  final Widget child;
  final Widget? label;
  final double? spacing;
  final bool selected;
  final ValueChanged<bool> onChanged;

  const NavigationButton({
    Key? key,
    this.spacing,
    this.label,
    required this.onChanged,
    required this.selected,
    required this.child,
  }) : super(key: key);

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.expanded) {
      return SliverToBoxAdapter(
        child: SelectedButton(
          value: widget.selected,
          onChanged: widget.onChanged,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
              if (widget.label != null) Gap(widget.spacing ?? (8 * scaling)),
              if (widget.label != null) widget.label!,
            ],
          ),
        ),
      );
    }
    return SliverToBoxAdapter(
      child: SelectedButton(
        value: widget.selected,
        onChanged: widget.onChanged,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            if (widget.label != null &&
                (labelType == NavigationLabelType.all || widget.selected))
              Gap(widget.spacing ?? (8 * scaling)),
            if (widget.label != null &&
                (labelType == NavigationLabelType.all || widget.selected))
              widget.label!,
          ],
        ),
      ),
    );
  }
}

class NavigationLabel extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry alignment;

  const NavigationLabel({
    Key? key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SliverPersistentHeader(
      pinned: true,
      delegate: NavigationLabelDelegate(
        maxExtent: 48 * scaling,
        minExtent: 48 * scaling,
        child: Container(
          alignment: alignment,
          padding: EdgeInsets.symmetric(horizontal: 16 * scaling),
          child: child,
        ).semiBold().large(),
      ),
    );
  }
}

class NavigationLabelDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  NavigationLabelDelegate({
    required this.maxExtent,
    required this.minExtent,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    final color = theme.colorScheme.background;
    return CustomPaint(
      painter: _NavigationLabelBackgroundPainter(
        color: color,
        indent: -_startPadding(parentPadding, direction),
        endIndent: -_endPadding(parentPadding, direction),
        direction: direction,
      ),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant NavigationLabelDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}

class _NavigationLabelBackgroundPainter extends CustomPainter {
  final Color color;
  final double indent;
  final double endIndent;
  final Axis direction;

  _NavigationLabelBackgroundPainter({
    required this.color,
    required this.indent,
    required this.endIndent,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // indent and endIndent is direction dependent
    if (direction == Axis.vertical) {
      canvas.drawRect(
        Rect.fromLTWH(indent, 0, size.width - indent - endIndent, size.height),
        paint,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, indent, size.width, size.height - indent - endIndent),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NavigationLabelBackgroundPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent ||
        oldDelegate.direction != direction;
  }
}
