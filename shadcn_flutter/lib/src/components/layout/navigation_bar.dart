import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationBar extends StatelessWidget {
  final Color? backgroundColor;
  final bool extended;
  final List<Widget> leading;
  final List<Widget> trailing;
  final int? index;
  final ValueChanged<int?>? onChanged;
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final bool canUnselect;
  final Axis direction;
  final double? spacing;
  final double? trailingGap;
  final double? leadingGap;
  final double? trailingSpacing;
  final double? leadingSpacing;
  final NavigationLabelType labelType;
  final EdgeInsetsGeometry? padding;

  const NavigationBar({
    Key? key,
    this.backgroundColor,
    this.extended = false,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.index,
    this.onChanged,
    this.alignment = AlignmentDirectional.center,
    this.canUnselect = false,
    this.direction = Axis.horizontal,
    this.spacing,
    this.trailingGap,
    this.leadingGap,
    this.trailingSpacing,
    this.leadingSpacing,
    this.labelType = NavigationLabelType.selected,
    this.padding,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> children = List.of(this.children);
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      children[i] = Data.inherit(
        data: NavigationControlData(
          index: i,
          selectedIndex: index,
          count: children.length,
          parentLabelType: labelType,
        ),
        child: child,
      );
    }
    return SurfaceCard(
      padding: padding ?? (const EdgeInsets.all(8) * scaling),
      child: Flex(
        direction: direction,
        children: [
          if (leading.isNotEmpty)
            ...leading.joinSeparator(
              Gap(leadingSpacing ?? (4 * scaling)),
            ),
          if (leading.isNotEmpty) Gap(leadingGap ?? (8 * scaling)),
          if (extended)
            Expanded(
              child: Flex(
                direction: direction,
                children: children.joinSeparator(
                  Gap(spacing ?? (8 * scaling)),
                ),
              ),
            )
          else
            ...children.joinSeparator(
              Gap(spacing ?? (8 * scaling)),
            ),
          if (trailing.isNotEmpty) Gap(trailingGap ?? (8 * scaling)),
          if (trailing.isNotEmpty)
            ...trailing.joinSeparator(
              Gap(trailingSpacing ?? (4 * scaling)),
            ),
        ],
      ),
    );
  }
}

// basically a copy of the NavigationBar class, but with different direction (vertical)
class NavigationRail extends NavigationBar {
  const NavigationRail({
    super.key,
    super.backgroundColor,
    super.extended,
    super.leading,
    super.trailing,
    super.index,
    super.onChanged,
    super.alignment = AlignmentDirectional.topCenter,
    super.canUnselect,
    super.direction = Axis.vertical,
    super.spacing,
    super.trailingGap,
    super.leadingGap,
    super.trailingSpacing,
    super.leadingSpacing,
    super.labelType = NavigationLabelType.selected,
    required super.children,
  });
}

enum NavigationLabelType {
  none,
  selected,
  all,
}

class NavigationControlData {
  final int index;
  final int? selectedIndex;
  final int count;
  final NavigationLabelType parentLabelType;

  NavigationControlData({
    required this.index,
    required this.selectedIndex,
    required this.count,
    required this.parentLabelType,
  });
}

class NavigationButton extends StatelessWidget {
  final Widget child;
  final Widget? label;
  final double? spacing;

  const NavigationButton({
    Key? key,
    required this.child,
    this.spacing,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final isSelected = data?.selectedIndex == data?.index;
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    return Toggle(
      value: isSelected,
      child: Column(
        children: [
          child,
          if (label != null &&
              (labelType == NavigationLabelType.all || isSelected))
            Gap(spacing ?? (4 * scaling)),
          if (label != null &&
              (labelType == NavigationLabelType.all || isSelected))
            label!,
        ],
      ),
    );
  }
}
