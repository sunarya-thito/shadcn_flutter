import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template collapsible_theme}
/// Styling options for [Collapsible], [CollapsibleTrigger].
/// {@endtemplate}
class CollapsibleTheme {
  /// Padding around the [CollapsibleTrigger].
  final double? padding;

  /// Icon to display in the [CollapsibleTrigger] when the [Collapsible] is expanded.
  final IconData? iconExpanded;

  /// Icon to display in the [CollapsibleTrigger] when the [Collapsible] is collapsed.
  final IconData? iconCollapsed;

  /// The alignment of the children along the cross axis in the [Collapsible].
  final CrossAxisAlignment? crossAxisAlignment;

  /// The alignment of the children along the main axis in the [Collapsible].
  final MainAxisAlignment? mainAxisAlignment;

  /// The gap between the icon and the label in the [CollapsibleTrigger].
  final double? iconGap;

  /// {@macro collapsible_theme}
  const CollapsibleTheme({
    this.padding,
    this.iconExpanded,
    this.iconCollapsed,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.iconGap,
  });

  /// Creates a copy of this [CollapsibleTheme] with the given fields replaced.
  CollapsibleTheme copyWith({
    double? padding,
    IconData? iconExpanded,
    IconData? iconCollapsed,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
  }) {
    return CollapsibleTheme(
      padding: padding ?? this.padding,
      iconExpanded: iconExpanded ?? this.iconExpanded,
      iconCollapsed: iconCollapsed ?? this.iconCollapsed,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollapsibleTheme &&
        other.padding == padding &&
        other.iconExpanded == iconExpanded &&
        other.iconCollapsed == iconCollapsed &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.iconGap == iconGap;
  }

  @override
  int get hashCode =>
      padding.hashCode ^
      iconExpanded.hashCode ^
      iconCollapsed.hashCode ^
      crossAxisAlignment.hashCode ^
      mainAxisAlignment.hashCode ^
      iconGap.hashCode;
}

/// https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
class Collapsible extends StatefulWidget {
  final List<Widget> children;

  /// Initial expansion state of this widget (if null, defaults to false).
  final bool? isExpanded;

  /// If overridden, the parent widget is responsible for managing the expansion state.
  final ValueChanged<bool>? onExpansionChanged;

  /// https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
  const Collapsible({
    super.key,
    required this.children,
    this.isExpanded,
    this.onExpansionChanged,
  });

  @override
  State<Collapsible> createState() => CollapsibleState();
}

class CollapsibleState extends State<Collapsible> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
  }

  @override
  void didUpdateWidget(covariant Collapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != null) {
      _isExpanded = widget.isExpanded!;
    }
  }

  void _handleTap() {
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Data.inherit(
      data:
          CollapsibleStateData(isExpanded: _isExpanded, handleTap: _handleTap),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment:
              compTheme?.crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisAlignment:
              compTheme?.mainAxisAlignment ?? MainAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}

class CollapsibleStateData {
  final VoidCallback handleTap;
  final bool isExpanded;

  const CollapsibleStateData({
    required this.isExpanded,
    required this.handleTap,
  });
}

class CollapsibleTrigger extends StatelessWidget {
  final Widget child;

  const CollapsibleTrigger({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final state = Data.of<CollapsibleStateData>(context);

    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(child: child.small().semiBold()),
      Gap(compTheme?.iconGap ?? 16 * scaling),
      GhostButton(
        onPressed: state.handleTap,
        child: Icon(
          state.isExpanded
              ? compTheme?.iconExpanded ?? Icons.unfold_less
              : compTheme?.iconCollapsed ?? Icons.unfold_more,
        ).iconXSmall(),
      ),
    ]).withPadding(horizontal: compTheme?.padding ?? 16 * scaling);
  }
}

class CollapsibleContent extends StatelessWidget {
  final bool collapsible;
  final Widget child;

  const CollapsibleContent({
    super.key,
    this.collapsible = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = Data.of<CollapsibleStateData>(context);
    return Offstage(
      offstage: !state.isExpanded && collapsible,
      child: child,
    );
  }
}
