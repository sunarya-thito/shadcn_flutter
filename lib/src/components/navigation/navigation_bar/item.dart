import 'dart:math' as math;

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';
import 'data.dart';
import 'misc.dart';

/// Base class for navigation bar items.
///
/// Abstract widget class that all navigation items must extend.
/// Provides common interface for items within [NavigationBar].
abstract class NavigationBarItem extends Widget {
  /// Creates a [NavigationBarItem].
  const NavigationBarItem({super.key});

  /// Number of selectable items represented by this item.
  int get selectableCount;
}

/// Selectable navigation item with selection state management.
///
/// Represents a clickable navigation item that can be selected. Supports
/// custom styling for selected/unselected states, labels, and icons.
///
/// Example:
/// ```dart
/// NavigationItem(
///   index: 0,
///   label: Text('Home'),
///   child: Icon(Icons.home),
///   selected: selectedIndex == 0,
///   onChanged: (selected) => setState(() => selectedIndex = 0),
/// )
/// ```
class NavigationItem extends AbstractNavigationButton {
  /// Custom style when item is selected.
  final AbstractButtonStyle? selectedStyle;

  /// Whether this item is currently selected.
  final bool? selected;

  /// Callback when selection state changes.
  final ValueChanged<bool>? onChanged;

  /// Optional index for selection management.
  final int? index;

  /// Creates a navigation item.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [selectedStyle] (AbstractButtonStyle?): Style when selected
  /// - [selected] (bool?): Current selection state
  /// - [onChanged] (`ValueChanged<bool>?`): Selection change callback
  /// - [index] (int?): Item index for selection
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Default style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationItem({
    super.key,
    this.selectedStyle,
    this.selected,
    this.onChanged,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    this.index,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  int get selectableCount {
    // if index is not null, then the child itself handles the selection
    // if index is null, then the parent handles the selection
    return index == null ? 1 : 0;
  }

  @override
  State<AbstractNavigationButton> createState() => _NavigationItemState();
}

class _NavigationItemState
    extends _AbstractNavigationButtonState<NavigationItem> {
  @override
  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    var index = childData?.index ?? widget.index;
    var isSelected = widget.selected ?? index == data?.selectedIndex;
    var parentIndex = childData?.index;
    bool showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.selected && isSelected) ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());
    AbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.secondary(density: ButtonDensity.icon)
            : const ButtonStyle.secondary());

    Widget? label = widget.label == null
        ? const SizedBox()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: NavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == NavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected);
    return NavigationPadding(
      child: SelectedButton(
        value: isSelected,
        enabled: widget.enabled,
        onChanged: parentIndex != null || widget.index != null
            ? (value) {
                widget.onChanged?.call(value);
                data?.onSelected?.call(parentIndex ?? widget.index!);
              }
            : widget.onChanged,
        marginAlignment: widget.marginAlignment,
        style: style,
        selectedStyle: selectedStyle,
        alignment: widget.alignment ??
            () {
              if (data?.expanded == true) {
                return Alignment.center;
              }
              if (data?.containerType == NavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal) {
                if (data?.parentLabelPosition ==
                    NavigationLabelPosition.start) {
                  return AlignmentDirectional.centerEnd;
                } else if (data?.parentLabelPosition ==
                    NavigationLabelPosition.end) {
                  return AlignmentDirectional.centerStart;
                } else {
                  return Alignment.center;
                }
              }
              return null;
            }(),
        child: NavigationLabeled(
          label: label,
          showLabel: showLabel,
          labelType: labelType,
          direction: direction,
          keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
          keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
          position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
          spacing: widget.spacing ?? densityGap,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Non-selectable navigation button for actions.
///
/// Similar to [NavigationItem] but without selection state. Used for
/// action buttons in navigation (e.g., settings, logout) that trigger
/// callbacks rather than changing navigation state.
///
/// Example:
/// ```dart
/// NavigationButton(
///   label: Text('Settings'),
///   child: Icon(Icons.settings),
///   onPressed: () => _openSettings(),
/// )
/// ```
class NavigationButton extends AbstractNavigationButton {
  /// Callback when button is pressed.
  final VoidCallback? onPressed;
  final bool? enableFeedback;

  /// Creates a navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [enableFeedback] (bool?) : Whether to enable haptic feedback
  /// - [onPressed] (VoidCallback?): Press callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationButton({
    super.key,
    this.onPressed,
    this.enableFeedback = true,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  int get selectableCount => 0;

  @override
  State<AbstractNavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState
    extends _AbstractNavigationButtonState<NavigationButton> {
  @override
  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    bool showLabel = labelType == NavigationLabelType.all ||
        (labelType == NavigationLabelType.expanded && data?.expanded == true);
    AbstractButtonStyle style = widget.style ??
        (data?.containerType != NavigationContainerType.sidebar
            ? const ButtonStyle.ghost(density: ButtonDensity.icon)
            : const ButtonStyle.ghost());

    Widget? label = widget.label == null
        ? const SizedBox()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: NavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == NavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == NavigationLabelType.expanded ||
        labelType == NavigationLabelType.all ||
        labelType == NavigationLabelType.selected);
    return NavigationPadding(
      child: Button(
        enabled: widget.enabled,
        onPressed: widget.onPressed,
        marginAlignment: widget.marginAlignment,
        style: style,
        enableFeedback: widget.enableFeedback,
        alignment: widget.alignment ??
            (data?.containerType == NavigationContainerType.sidebar &&
                    data?.labelDirection == Axis.horizontal
                ? (data?.parentLabelPosition == NavigationLabelPosition.start
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart)
                : null),
        child: NavigationLabeled(
          label: label,
          showLabel: showLabel,
          labelType: labelType,
          direction: direction,
          keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
          keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
          position: data?.parentLabelPosition ?? NavigationLabelPosition.bottom,
          spacing: widget.spacing ?? densityGap,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Abstract base class for navigation button widgets.
///
/// Provides common properties and behavior for navigation items and buttons.
/// Subclasses include [NavigationItem] and [NavigationButton].
///
/// Handles layout, labels, styling, and integration with navigation containers.
abstract class AbstractNavigationButton extends StatefulWidget
    implements NavigationBarItem {
  /// Main content widget (typically an icon).
  final Widget child;

  /// Optional label text widget.
  final Widget? label;

  /// Spacing between icon and label.
  final double? spacing;

  /// Custom button style.
  final AbstractButtonStyle? style;

  /// Content alignment within the button.
  final AlignmentGeometry? alignment;

  /// Whether the button is enabled for interaction.
  final bool? enabled;

  /// How to handle label overflow.
  final NavigationOverflow overflow;

  /// Alignment for margins.
  final AlignmentGeometry? marginAlignment;

  /// Creates an abstract navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content (icon)
  /// - [spacing] (double?): Icon-label spacing
  /// - [label] (Widget?): Label widget
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Enabled state
  /// - [overflow] (NavigationOverflow): Overflow behavior, defaults to marquee
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const AbstractNavigationButton({
    super.key,
    this.spacing,
    this.label,
    this.style,
    this.alignment,
    this.enabled,
    this.overflow = NavigationOverflow.marquee,
    this.marginAlignment,
    required this.child,
  });

  @override
  State<AbstractNavigationButton> createState();
}

abstract class _AbstractNavigationButtonState<
    T extends AbstractNavigationButton> extends State<T> {
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
    return _buildBox(context, data, childData);
  }

  Widget buildTooltip(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
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
      tooltip: TooltipContainer(child: widget.label!).call,
      child: buildBox(context, data, childData),
    );
  }

  Widget buildSliver(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return SliverToBoxAdapter(child: buildTooltip(context, data, childData));
    }
    return SliverToBoxAdapter(child: _buildBox(context, data, childData));
  }

  Widget _buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final box = childData == null
        ? buildBox(context, data, null)
        : RepaintBoundary.wrap(
            buildBox(context, data, childData),
            childData.actualIndex,
          );
    return box;
  }

  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  );
}

