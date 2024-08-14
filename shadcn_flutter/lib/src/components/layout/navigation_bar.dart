import 'package:shadcn_flutter/shadcn_flutter.dart';

enum NavigationBarAlignment {
  start(MainAxisAlignment.start),
  center(MainAxisAlignment.center),
  end(MainAxisAlignment.end),
  spaceBetween(MainAxisAlignment.spaceBetween),
  spaceAround(MainAxisAlignment.spaceAround),
  spaceEvenly(MainAxisAlignment.spaceEvenly);

  final MainAxisAlignment mainAxisAlignment;

  const NavigationBarAlignment(this.mainAxisAlignment);
}

enum NavigationRailAlignment {
  start,
  center,
  end,
}

enum NavigationContainerType {
  rail,
  bar,
  sidebar;
}

class NavigationBar extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;
  final NavigationBarAlignment alignment;
  final Axis direction;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final bool expands;

  const NavigationBar({
    Key? key,
    this.backgroundColor,
    this.alignment = NavigationBarAlignment.center,
    this.direction = Axis.horizontal,
    this.spacing,
    this.labelType = NavigationLabelType.none,
    this.padding,
    this.constraints,
    this.expands = true,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding = padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    List<Widget> children = [];
    if (!expands) {
      children = List.of(this.children);
    } else {
      if (alignment == NavigationBarAlignment.spaceEvenly) {
        children.add(Spacer());
        for (var i = 0; i < this.children.length; i++) {
          children.add(Expanded(child: this.children[i]));
        }
        children.add(Spacer());
      } else if (alignment == NavigationBarAlignment.spaceAround) {
        children.add(Spacer());
        for (var i = 0; i < this.children.length; i++) {
          children.add(Expanded(
            child: this.children[i],
            flex: 2,
          ));
        }
        children.add(Spacer());
      } else if (alignment == NavigationBarAlignment.spaceBetween) {
        for (var i = 0; i < this.children.length; i++) {
          if (i > 0) {
            children.add(Spacer());
          }
          children.add(Expanded(
            child: this.children[i],
            flex: 2,
          ));
        }
      } else {
        for (var i = 0; i < this.children.length; i++) {
          children.add(Expanded(child: this.children[i]));
        }
      }
    }
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.bar,
        parentLabelType: labelType,
        parentPadding: resolvedPadding,
        direction: direction,
      ),
      child: AnimatedContainer(
        duration: kDefaultDuration,
        color: backgroundColor,
        padding: resolvedPadding,
        child: _wrapIntrinsic(
          Flex(
            direction: direction,
            mainAxisAlignment: alignment.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ).gap(spacing ?? (8 * scaling)),
        ),
      ),
    );
  }

  Widget _wrapIntrinsic(Widget child) {
    if (direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
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

class NavigationRail extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;
  final NavigationRailAlignment alignment;
  final Axis direction;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  const NavigationRail({
    Key? key,
    this.backgroundColor,
    this.alignment = NavigationRailAlignment.center,
    this.direction = Axis.vertical,
    this.spacing,
    this.labelType = NavigationLabelType.selected,
    this.padding,
    this.constraints,
    required this.children,
  }) : super(key: key);

  AlignmentGeometry get _alignment {
    switch ((alignment, direction)) {
      case (NavigationRailAlignment.start, Axis.horizontal):
        return AlignmentDirectional.centerStart;
      case (NavigationRailAlignment.center, Axis.horizontal):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.end, Axis.horizontal):
        return AlignmentDirectional.centerEnd;
      case (NavigationRailAlignment.start, Axis.vertical):
        return AlignmentDirectional.topCenter;
      case (NavigationRailAlignment.center, Axis.vertical):
        return AlignmentDirectional.center;
      case (NavigationRailAlignment.end, Axis.vertical):
        return AlignmentDirectional.bottomCenter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding = padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.rail,
        parentLabelType: labelType,
        parentPadding: resolvedPadding,
        direction: direction,
      ),
      child: AnimatedContainer(
        duration: kDefaultDuration,
        color: backgroundColor,
        alignment: _alignment,
        child: SingleChildScrollView(
          scrollDirection: direction,
          padding: resolvedPadding,
          child: _wrapIntrinsic(
            Flex(
              direction: direction,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ).gap(spacing ?? (8 * scaling)),
          ),
        ),
      ),
    );
  }

  Widget _wrapIntrinsic(Widget child) {
    if (direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}

class NavigationSidebar extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  const NavigationSidebar({
    Key? key,
    this.backgroundColor,
    this.spacing,
    this.labelType = NavigationLabelType.expanded,
    this.padding,
    this.constraints,
    required this.children,
  }) : super(key: key);

  BoxConstraints getDefaultConstraints(BuildContext context, ThemeData theme) {
    final scaling = theme.scaling;
    return BoxConstraints(
      minWidth: 200 * scaling,
      maxWidth: 200 * scaling,
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
    const direction = Axis.vertical;
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.sidebar,
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

enum NavigationLabelType {
  none,
  selected,
  all,
  expanded,
}

class NavigationControlData {
  final NavigationContainerType containerType;
  final NavigationLabelType parentLabelType;
  final EdgeInsets parentPadding;
  final Axis direction;

  NavigationControlData({
    required this.containerType,
    required this.parentLabelType,
    required this.parentPadding,
    required this.direction,
  });
}

class NavigationGap extends StatelessWidget {
  final double gap;

  const NavigationGap(
    this.gap, {
    Key? key,
  }) : super(key: key);

  Widget buildBox(BuildContext context) {
    return Gap(gap);
  }

  Widget buildSliver(BuildContext context) {
    return SliverGap(gap);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context);
    }
    return buildBox(context);
  }
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
    Widget child;
    if (direction == Axis.vertical) {
      child = Divider(
        indent: -parentPadding.left,
        endIndent: -parentPadding.right,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    } else {
      child = VerticalDivider(
        indent: -parentPadding.top,
        endIndent: -parentPadding.bottom,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    }
    if (data?.containerType == NavigationContainerType.sidebar) {
      return SliverToBoxAdapter(
        child: child,
      );
    }
    return child;
  }
}

class NavigationButton extends StatefulWidget {
  final Widget child;
  final Widget? label;
  final double? spacing;
  final bool selected;
  final ValueChanged<bool> onChanged;
  final ButtonStyle? style;
  final ButtonStyle? selectedStyle;
  final AlignmentGeometry? alignment;

  const NavigationButton({
    Key? key,
    this.spacing,
    this.label,
    this.style,
    this.selectedStyle,
    this.alignment,
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
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data);
    }
    return buildBox(context, data);
  }

  Widget buildSliver(BuildContext context, NavigationControlData? data) {
    return SliverToBoxAdapter(
      child: buildBox(context, data),
    );
  }

  Widget buildBox(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    if (labelType == NavigationLabelType.expanded) {
      return SelectedButton(
        value: widget.selected,
        onChanged: widget.onChanged,
        style: widget.style ?? ButtonStyle.ghost(),
        selectedStyle: widget.selectedStyle ?? ButtonStyle.secondary(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: widget.alignment ?? AlignmentDirectional.centerStart,
              child: widget.child,
            ),
            if (widget.label != null) Gap(widget.spacing ?? (8 * scaling)),
            if (widget.label != null)
              Flexible(
                child: Align(
                  alignment:
                      widget.alignment ?? AlignmentDirectional.centerStart,
                  child: OverflowMarquee(child: widget.label!),
                ),
              ),
          ],
        ),
      );
    }
    return SelectedButton(
      value: widget.selected,
      onChanged: widget.onChanged,
      style: widget.style ??
          ButtonStyle.ghost(
            density: ButtonDensity.icon,
          ),
      selectedStyle: widget.selectedStyle ??
          ButtonStyle.secondary(
            density: ButtonDensity.icon,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.child,
          if (data?.parentLabelType != NavigationLabelType.none &&
              widget.label != null)
            Flexible(
              child: AnimatedSize(
                alignment: direction == Axis.vertical
                    ? Alignment.topCenter
                    : Alignment.center,
                duration: kDefaultDuration,
                curve: Curves.easeInOut,
                child: SizedBox(
                  height: (widget.label != null &&
                          (labelType == NavigationLabelType.all ||
                              widget.selected))
                      ? null
                      : 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(widget.spacing ?? (8 * scaling)),
                      DefaultTextStyle.merge(
                        textAlign: TextAlign.center,
                        child: OverflowMarquee(
                          child: widget.label!.xSmall(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
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
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context);
    }
    return buildBox(context);
  }

  Widget buildBox(BuildContext context) {
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: child.xSmall(),
    );
  }

  Widget buildSliver(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SliverPersistentHeader(
      pinned: true,
      delegate: _NavigationLabelDelegate(
        maxExtent: 48 * scaling,
        minExtent: 48 * scaling,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Scrollable.ensureVisible(
              context,
              duration: kDefaultDuration,
              curve: Curves.easeInOut,
            );
          },
          child: Container(
            alignment: alignment,
            padding: EdgeInsets.symmetric(horizontal: 16 * scaling),
            child: OverflowMarquee(child: child),
          ).semiBold().large(),
        ),
      ),
    );
  }
}

class _NavigationLabelDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  _NavigationLabelDelegate({
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
  bool shouldRebuild(covariant _NavigationLabelDelegate oldDelegate) {
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
