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

abstract class NavigationBarItem extends Widget {
  const NavigationBarItem({super.key});

  bool get selectable;
}

class NavigationBar extends StatefulWidget {
  final Color? backgroundColor;
  final List<NavigationBarItem> children;
  final NavigationBarAlignment alignment;
  final Axis direction;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final bool expands;
  final int? index;
  final ValueChanged<int>? onSelected;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const NavigationBar({
    super.key,
    this.backgroundColor,
    this.alignment = NavigationBarAlignment.center,
    this.direction = Axis.horizontal,
    this.spacing,
    this.labelType = NavigationLabelType.none,
    this.padding,
    this.constraints,
    this.expands = true,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with NavigationContainerMixin {
  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    List<Widget> rawChildren = wrapChildren(context, widget.children);
    List<Widget> children = [];
    if (!widget.expands) {
      children = List.of(rawChildren);
    } else {
      if (widget.alignment == NavigationBarAlignment.spaceEvenly) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
        children.add(const Spacer());
      } else if (widget.alignment == NavigationBarAlignment.spaceAround) {
        children.add(const Spacer());
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(
            flex: 2,
            child: rawChildren[i],
          ));
        }
        children.add(const Spacer());
      } else if (widget.alignment == NavigationBarAlignment.spaceBetween) {
        for (var i = 0; i < rawChildren.length; i++) {
          if (i > 0) {
            children.add(const Spacer());
          }
          children.add(Expanded(
            flex: 2,
            child: rawChildren[i],
          ));
        }
      } else {
        for (var i = 0; i < rawChildren.length; i++) {
          children.add(Expanded(child: rawChildren[i]));
        }
      }
    }
    return AppBar(
      padding: EdgeInsets.zero,
      surfaceBlur: widget.surfaceBlur,
      surfaceOpacity: widget.surfaceOpacity,
      child: Data.inherit(
        data: NavigationControlData(
          containerType: NavigationContainerType.bar,
          parentLabelType: widget.labelType,
          parentPadding: resolvedPadding,
          direction: widget.direction,
          selectedIndex: widget.index,
          onSelected: _onSelected,
        ),
        child: Container(
          color: widget.backgroundColor,
          padding: resolvedPadding,
          child: _wrapIntrinsic(
            Flex(
              direction: widget.direction,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: widget.alignment.mainAxisAlignment,
              children: children,
            ).gap(widget.spacing ?? (8 * scaling)),
          ),
        ),
      ),
    );
  }

  Widget _wrapIntrinsic(Widget child) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}

double _startPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.top;
  }
  return padding.left;
}

double _endPadding(EdgeInsets padding, Axis direction) {
  if (direction == Axis.vertical) {
    return padding.bottom;
  }
  return padding.right;
}

mixin NavigationContainerMixin {
  List<Widget> wrapChildren(
      BuildContext context, List<NavigationBarItem> children) {
    int index = 0;
    List<Widget> newChildren = List.of(children);
    for (var i = 0; i < children.length; i++) {
      if (children[i].selectable) {
        newChildren[i] = Data.inherit(
          data: NavigationChildControlData(
            index: index,
          ),
          child: children[i],
        );
        index++;
      }
    }
    return newChildren;
  }
}

class NavigationRail extends StatefulWidget {
  final Color? backgroundColor;
  final List<NavigationBarItem> children;
  final NavigationRailAlignment alignment;
  final Axis direction;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final int? index;
  final ValueChanged<int>? onSelected;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const NavigationRail({
    super.key,
    this.backgroundColor,
    this.alignment = NavigationRailAlignment.center,
    this.direction = Axis.vertical,
    this.spacing,
    this.labelType = NavigationLabelType.selected,
    this.padding,
    this.constraints,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<NavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<NavigationRail>
    with NavigationContainerMixin {
  AlignmentGeometry get _alignment {
    switch ((widget.alignment, widget.direction)) {
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

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.rail,
        parentLabelType: widget.labelType,
        parentPadding: resolvedPadding,
        direction: widget.direction,
        selectedIndex: widget.index,
        onSelected: _onSelected,
      ),
      child: SurfaceBlur(
        surfaceBlur: widget.surfaceBlur,
        child: Container(
          color: widget.backgroundColor ??
              (theme.colorScheme.background
                  .scaleAlpha(widget.surfaceOpacity ?? 1)),
          alignment: _alignment,
          child: SingleChildScrollView(
            scrollDirection: widget.direction,
            padding: resolvedPadding,
            child: _wrapIntrinsic(
              Flex(
                direction: widget.direction,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: wrapChildren(context, widget.children),
              ).gap(widget.spacing ?? (8 * scaling)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wrapIntrinsic(Widget child) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}

class NavigationSidebar extends StatefulWidget {
  final Color? backgroundColor;
  final List<NavigationBarItem> children;
  final double? spacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final int? index;
  final ValueChanged<int>? onSelected;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const NavigationSidebar({
    super.key,
    this.backgroundColor,
    this.spacing,
    this.labelType = NavigationLabelType.expanded,
    this.padding,
    this.constraints,
    this.index,
    this.onSelected,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar>
    with NavigationContainerMixin {
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

  void _onSelected(int index) {
    widget.onSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> children = wrapChildren(context, widget.children);
    var parentPadding = widget.padding ??
        (const EdgeInsets.symmetric(vertical: 8, horizontal: 12) * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);
    const direction = Axis.vertical;
    return Data.inherit(
      data: NavigationControlData(
        containerType: NavigationContainerType.sidebar,
        parentLabelType: widget.labelType,
        parentPadding: resolvedPadding,
        direction: direction,
        onSelected: _onSelected,
        selectedIndex: widget.index,
      ),
      child: ConstrainedBox(
        constraints:
            widget.constraints ?? getDefaultConstraints(context, theme),
        child: SurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: Container(
            color: widget.backgroundColor,
            child: ClipRect(
              child: CustomScrollView(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                scrollDirection: direction,
                slivers: [
                  SliverGap(_startPadding(resolvedPadding, direction)),
                  ...children.map(
                    (e) {
                      return SliverPadding(
                        padding: _childPadding(resolvedPadding, direction),
                        sliver: e,
                      ) as Widget;
                    },
                  ).joinSeparator(
                    SliverGap(widget.spacing ?? 0),
                  ),
                  SliverGap(_endPadding(resolvedPadding, direction)),
                ],
              ),
            ),
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
  tooltip,
}

class NavigationChildControlData {
  final int? index;

  NavigationChildControlData({
    this.index,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationChildControlData && other.index == index;
  }

  @override
  int get hashCode {
    return index.hashCode;
  }
}

class NavigationControlData {
  final NavigationContainerType containerType;
  final NavigationLabelType parentLabelType;
  final EdgeInsets parentPadding;
  final Axis direction;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  NavigationControlData({
    required this.containerType,
    required this.parentLabelType,
    required this.parentPadding,
    required this.direction,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationControlData &&
        other.containerType == containerType &&
        other.parentLabelType == parentLabelType &&
        other.parentPadding == parentPadding &&
        other.direction == direction &&
        other.selectedIndex == selectedIndex &&
        other.onSelected == onSelected;
  }

  @override
  int get hashCode {
    return Object.hash(
      containerType,
      parentLabelType,
      parentPadding,
      direction,
      selectedIndex,
      onSelected,
    );
  }
}

class NavigationGap extends StatelessWidget implements NavigationBarItem {
  final double gap;

  const NavigationGap(
    this.gap, {
    super.key,
  });

  @override
  bool get selectable => false;

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

class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  final double? thickness;
  final Color? color;

  const NavigationDivider({
    super.key,
    this.thickness,
    this.color,
  });

  @override
  bool get selectable => false;

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

class NavigationButton extends StatefulWidget implements NavigationBarItem {
  final Widget child;
  final Widget? trailing;
  final Widget? label;
  final double? spacing;
  final bool? selected;
  final ValueChanged<bool>? onChanged;
  final AbstractButtonStyle? style;
  final AbstractButtonStyle? selectedStyle;
  final AlignmentGeometry? alignment;
  final int? index;
  final bool? enabled;
  final NavigationOverflow overflow;
  final AlignmentGeometry? marginAlignment;

  const NavigationButton({
    super.key,
    this.spacing,
    this.trailing,
    this.label,
    this.style,
    this.selectedStyle,
    this.alignment,
    this.index,
    this.onChanged,
    this.selected,
    this.enabled,
    this.overflow = NavigationOverflow.marquee,
    this.marginAlignment,
    required this.child,
  });

  @override
  bool get selectable {
    // if index is not null, then the child itself handles the selection
    // if index is null, then the parent handles the selection
    return index == null;
  }

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final childData = Data.maybeOf<NavigationChildControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data, childData);
    }
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return buildTooltip(context, data, childData);
    }
    return buildBox(context, data, childData);
  }

  Widget buildTooltip(BuildContext context, NavigationControlData? data,
      NavigationChildControlData? childData) {
    if (widget.label == null) {
      return buildBox(context, data, childData);
    }
    AlignmentGeometry alignment = Alignment.topCenter;
    AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
    if (data?.direction == Axis.vertical) {
      alignment = AlignmentDirectional.centerStart;
      anchorAlignment = AlignmentDirectional.centerEnd;
    }
    return Tooltip(
      waitDuration: !isMobile(Theme.of(context).platform)
          ? Duration.zero
          : const Duration(milliseconds: 500),
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      tooltip: TooltipContainer(child: widget.label!),
      child: buildBox(context, data, childData),
    );
  }

  Widget buildSliver(BuildContext context, NavigationControlData? data,
      NavigationChildControlData? childData) {
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return SliverToBoxAdapter(
        child: buildTooltip(context, data, childData),
      );
    }
    return SliverToBoxAdapter(
      child: buildBox(context, data, childData),
    );
  }

  Widget buildBox(BuildContext context, NavigationControlData? data,
      NavigationChildControlData? childData) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    var index = childData?.index ?? widget.index;
    var isSelected = widget.selected ?? index == data?.selectedIndex;
    var parentIndex = childData?.index;
    AbstractButtonStyle style = widget.style ??
        (labelType != NavigationLabelType.expanded
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());
    AbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (labelType != NavigationLabelType.expanded
            ? const ButtonStyle.secondary(density: ButtonDensity.icon)
            : const ButtonStyle.secondary());
    if (labelType == NavigationLabelType.expanded) {
      return SelectedButton(
        value: isSelected,
        marginAlignment: widget.marginAlignment,
        enabled: widget.enabled,
        onChanged: parentIndex != null || widget.index != null
            ? (value) {
                widget.onChanged?.call(value);
                data?.onSelected(parentIndex ?? widget.index!);
              }
            : widget.onChanged,
        style: style,
        selectedStyle: selectedStyle,
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
                  child: _NavigationChildOverflowHandle(
                    overflow: widget.overflow,
                    child: widget.label!,
                  ),
                ),
              ),
            if (widget.trailing != null) Gap(widget.spacing ?? (8 * scaling)),
            if (widget.trailing != null)
              Align(
                alignment: widget.alignment ?? AlignmentDirectional.centerStart,
                child: widget.trailing,
              ),
          ],
        ),
      );
    }
    return SelectedButton(
      value: isSelected,
      enabled: widget.enabled,
      onChanged: parentIndex != null || widget.index != null
          ? (value) {
              widget.onChanged?.call(value);
              data?.onSelected(parentIndex ?? widget.index!);
            }
          : widget.onChanged,
      marginAlignment: widget.marginAlignment,
      style: style,
      selectedStyle: selectedStyle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.child,
          if (data?.parentLabelType != NavigationLabelType.none &&
              data?.parentLabelType != NavigationLabelType.tooltip &&
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
                          (labelType == NavigationLabelType.all || isSelected))
                      ? null
                      : 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(widget.spacing ?? (8 * scaling)),
                      DefaultTextStyle.merge(
                        textAlign: TextAlign.center,
                        child: _NavigationChildOverflowHandle(
                          overflow: widget.overflow,
                          child: widget.label!.xSmall(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (widget.trailing != null) Gap(widget.spacing ?? (8 * scaling)),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

enum NavigationOverflow {
  clip,
  marquee,
  ellipsis,
  none,
}

class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final NavigationOverflow overflow;

  // these options are ignored in NavigationBar and NavigationRail
  final bool floating;
  final bool pinned;

  const NavigationLabel({
    super.key,
    this.alignment = AlignmentDirectional.centerStart,
    this.floating = false,
    this.pinned = false,
    this.overflow = NavigationOverflow.marquee,
    this.padding,
    required this.child,
  });

  @override
  bool get selectable => false;

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
      pinned: pinned,
      floating: floating,
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
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16 * scaling),
            // child: OverflowMarquee(child: child),
            child: _NavigationChildOverflowHandle(
              overflow: overflow,
              child: child,
            ),
          ).semiBold().large(),
        ),
      ),
    );
  }
}

class _NavigationChildOverflowHandle extends StatelessWidget {
  final NavigationOverflow overflow;
  final Widget child;

  const _NavigationChildOverflowHandle({
    required this.overflow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (overflow) {
      case NavigationOverflow.clip:
        return ClipRect(child: child);
      case NavigationOverflow.marquee:
        return OverflowMarquee(child: child);
      case NavigationOverflow.ellipsis:
        return DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: child,
        );
      case NavigationOverflow.none:
        return child;
    }
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

typedef NavigationWidgetBuilder = Widget Function(
    BuildContext context, bool selected);

class NavigationWidget extends StatelessWidget implements NavigationBarItem {
  final int? index;
  final Widget? child;
  final NavigationWidgetBuilder? builder;

  const NavigationWidget({
    super.key,
    this.index,
    required Widget this.child,
  }) : builder = null;

  const NavigationWidget.builder({
    super.key,
    this.index,
    required NavigationWidgetBuilder this.builder,
  }) : child = null;

  @override
  bool get selectable {
    return index == null;
  }

  @override
  Widget build(BuildContext context) {
    var data = Data.maybeOf<NavigationControlData>(context);
    var childData = Data.maybeOf<NavigationChildControlData>(context);
    var index = childData?.index ?? this.index;
    var isSelected = index == data?.selectedIndex;
    return child ?? builder!(context, isSelected);
  }
}
