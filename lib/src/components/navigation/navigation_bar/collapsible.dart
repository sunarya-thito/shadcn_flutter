import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';
import 'misc.dart';

/// A navigation item that can expand to reveal nested navigation items.
///
/// Provides a labeled header row that toggles visibility of sub-items. Intended
/// for hierarchical navigation structures, especially in vertical sidebars or
/// rails.
class NavigationCollapsible extends StatefulWidget {
  /// Optional leading widget for the group header.
  final Widget? leading;

  /// Label widget for the group header.
  final Widget label;

  /// The nested navigation items for this group.
  final List<Widget> children;

  /// Whether the group is expanded (controlled mode).
  final bool? expanded;

  /// Initial expanded state when uncontrolled.
  final bool initialExpanded;

  /// Callback when expansion state changes.
  final ValueChanged<bool>? onExpandedChanged;

  /// Custom style when the group header is selected.
  final AbstractButtonStyle? selectedStyle;

  /// Whether the group header is currently selected.
  final bool? selected;

  /// Callback when header selection changes.
  final ValueChanged<bool>? onChanged;

  /// Optional button style for the header.
  final AbstractButtonStyle? style;

  /// Optional custom trailing widget for the expand indicator.
  final Widget? trailing;

  /// Indentation applied to nested items.
  final double? childIndent;

  /// Branch line style for connecting group items.
  final BranchLine? branchLine;

  /// Spacing between leading widget and label.
  final double? spacing;

  /// Content alignment within the header button.
  final AlignmentGeometry? alignment;

  /// Whether the header is enabled for interaction.
  final bool? enabled;

  /// How to handle label overflow.
  final NavigationOverflow overflow;

  /// Creates a [NavigationCollapsible].
  const NavigationCollapsible({
    super.key,
    this.leading,
    required this.label,
    required this.children,
    this.expanded,
    this.initialExpanded = false,
    this.onExpandedChanged,
    this.selectedStyle,
    this.selected,
    this.onChanged,
    this.style,
    this.trailing,
    this.childIndent,
    this.branchLine,
    this.spacing,
    this.alignment,
    this.enabled,
    this.overflow = NavigationOverflow.marquee,
  });

  @override
  State<NavigationCollapsible> createState() => _NavigationCollapsibleState();
}

class _NavigationCollapsibleState extends State<NavigationCollapsible> {
  late bool _expanded;

  bool get _isExpanded => widget.expanded ?? _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded ?? widget.initialExpanded;
  }

  @override
  void didUpdateWidget(covariant NavigationCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != null && widget.expanded != oldWidget.expanded) {
      _expanded = widget.expanded ?? _expanded;
    }
  }

  void _toggleExpanded() {
    if (widget.enabled == false || widget.children.isEmpty) {
      return;
    }
    final next = !_isExpanded;
    if (widget.expanded == null) {
      setState(() {
        _expanded = next;
      });
    }
    widget.onExpandedChanged?.call(next);
  }

  EdgeInsetsGeometry _indentForDirection(double indent, Axis direction) {
    if (direction == Axis.vertical) {
      return EdgeInsetsDirectional.only(start: indent);
    }
    return EdgeInsetsDirectional.only(top: indent);
  }

  Widget _buildGroupGuide(
    BuildContext context,
    int childIndex,
    int childCount,
    Axis direction,
  ) {
    if (direction != Axis.vertical) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final depth = [TreeNodeDepth(childIndex, childCount)];
    final compTheme = ComponentTheme.maybeOf<TreeTheme>(context);
    final branchLine =
        widget.branchLine ?? compTheme?.branchLine ?? BranchLine.line;
    final guideIndex = branchLine is IndentGuideLine ? 1 : 0;
    final guide = branchLine.build(context, depth, guideIndex);
    return SizedBox(width: densityGap * 2, child: guide);
  }

  Widget _wrapGroupChild(
    BuildContext context,
    Widget child,
    int childIndex,
    int childCount,
    Axis direction,
  ) {
    final guide = _buildGroupGuide(context, childIndex, childCount, direction);
    if (direction != Axis.vertical) {
      return child;
    }
    if (child is SliverToBoxAdapter) {
      return SliverToBoxAdapter(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              guide,
              Expanded(child: child.child ?? const SizedBox.shrink()),
            ],
          ),
        ),
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          guide,
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NavigationControlData? data) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    final showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    final canShowLabel = labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected;
    final label = DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      child: NavigationChildOverflowHandle(
        overflow: widget.overflow,
        child: data?.parentLabelSize == NavigationLabelSize.small
            ? widget.label.xSmall
            : widget.label,
      ),
    );
    final content = NavigationLabeled(
      label: label,
      showLabel: showLabel,
      labelType: labelType,
      direction: direction,
      keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
      keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
      position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
      spacing: widget.spacing ?? densityGap,
      child: widget.leading ?? const SizedBox.shrink(),
    );

    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());
    AbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.secondary(density: ButtonDensity.icon)
            : const ButtonStyle.secondary());

    final hasChildren = widget.children.isNotEmpty;
    final trailing = hasChildren
        ? Hidden(
            hidden: !(data?.expanded ?? true),
            direction: Axis.horizontal,
            // curve: Curves.easeInOut,
            duration: kDefaultDuration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(densityGap),
                AnimatedRotation(
                  turns: _isExpanded ? 0.25 : 0.0,
                  duration: kDefaultDuration,
                  // curve: Curves.easeInOut,
                  child: IconTheme.merge(
                    data: IconThemeData(size: 16 * scaling),
                    child:
                        widget.trailing ?? const Icon(LucideIcons.chevronRight),
                  ),
                ),
              ],
            ),
          )
        : null;

    final parentExpanded = data?.expanded ?? true;
    final isSelected = widget.selected ??
        (widget.key != null && widget.key == data?.selectedKey);

    Widget header = SelectedButton(
      value: isSelected,
      enabled: widget.enabled,
      onChanged: (value) {
        widget.onChanged?.call(value);
        if (widget.key != null) {
          data?.onSelected?.call(widget.key);
        }
        if (hasChildren && parentExpanded) {
          _toggleExpanded();
        }
      },
      style: style,
      selectedStyle: selectedStyle,
      alignment: widget.alignment ??
          (data?.containerType == NavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal
              ? (data?.parentLabelPosition == NavigationLabelPosition.start
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart)
              : null),
      child: Row(
        children: [
          Expanded(child: content),
          if (trailing != null) trailing,
        ],
      ),
    );

    if (labelType == NavigationLabelType.tooltip) {
      AlignmentGeometry alignment = Alignment.topCenter;
      AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
      if (direction == Axis.vertical) {
        alignment = AlignmentDirectional.centerStart;
        anchorAlignment = AlignmentDirectional.centerEnd;
      }
      header = Tooltip(
        waitDuration: !isMobile(theme.platform)
            ? Duration.zero
            : const Duration(milliseconds: 500),
        alignment: alignment,
        anchorAlignment: anchorAlignment,
        tooltip: TooltipContainer(child: widget.label).call,
        child: header,
      );
    }

    return header;
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final direction = data?.direction ?? Axis.vertical;

    final children = widget.children;

    final childControlData = data == null
        ? null
        : NavigationControlData(
            containerType: data.containerType,
            parentLabelType: data.parentLabelType,
            parentLabelPosition: data.parentLabelPosition,
            parentLabelSize: data.parentLabelSize,
            parentPadding: data.parentPadding,
            direction: Axis.vertical,
            selectedKey: data.selectedKey,
            onSelected: data.onSelected,
            expanded: data.expanded,
            childCount: children.length,
            spacing: data.spacing,
            keepCrossAxisSize: data.keepCrossAxisSize,
            keepMainAxisSize: data.keepMainAxisSize,
          );

    final indent = widget.childIndent ?? densityGap;
    final indentPadding = _indentForDirection(indent, direction);

    final parentExpanded = data?.expanded ?? true;
    if (data?.containerType == NavigationContainerType.sidebar) {
      final decoratedChildren = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        decoratedChildren.add(
          _wrapGroupChild(
            context,
            children[i],
            i,
            children.length,
            direction,
          ),
        );
      }
      final slivers = <Widget>[
        SliverToBoxAdapter(child: _buildHeader(context, data)),
        if (parentExpanded && _isExpanded && decoratedChildren.isNotEmpty)
          ...decoratedChildren.map(
            (child) => SliverPadding(
              padding: indentPadding,
              sliver: Data.inherit(
                data: childControlData,
                child: child,
              ),
            ),
          ),
      ];
      return SliverMainAxisGroup(slivers: slivers);
    }

    final decoratedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      decoratedChildren.add(
        _wrapGroupChild(
          context,
          children[i],
          i,
          children.length,
          direction,
        ),
      );
    }
    final childList = Data.inherit(
      data: childControlData,
      child: Padding(
        padding: indentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: decoratedChildren,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(context, data),
        ClipRect(
          child: Hidden(
            hidden: !_isExpanded || !parentExpanded,
            direction: Axis.vertical,
            // curve: Curves.easeInOut,
            duration: kDefaultDuration,
            reverse: true,
            child: childList,
          ),
        ),
      ],
    );
  }
}
