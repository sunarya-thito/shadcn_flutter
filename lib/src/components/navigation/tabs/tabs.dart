import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabsTheme {
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? tabPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const TabsTheme({
    this.containerPadding,
    this.tabPadding,
    this.backgroundColor,
    this.borderRadius,
  });

  TabsTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? containerPadding,
    ValueGetter<EdgeInsetsGeometry?>? tabPadding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return TabsTheme(
      containerPadding: containerPadding == null
          ? this.containerPadding
          : containerPadding(),
      tabPadding: tabPadding == null ? this.tabPadding : tabPadding(),
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabsTheme &&
        other.containerPadding == containerPadding &&
        other.tabPadding == tabPadding &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode =>
      Object.hash(containerPadding, tabPadding, backgroundColor, borderRadius);
}

class Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<TabChild> children;
  final EdgeInsetsGeometry? padding;

  const Tabs({
    super.key,
    required this.index,
    required this.onChanged,
    required this.children,
    this.padding,
  });

  Widget _childBuilder(
    BuildContext context,
    TabContainerData data,
    Widget child,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TabsTheme>(context);
    final tabPadding = styleValue(
      defaultValue:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4) * scaling,
      themeValue: compTheme?.tabPadding,
      widgetValue: padding,
    );
    final i = data.index;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onChanged(i);
      },
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 50,
          ), // slightly faster than kDefaultDuration
          alignment: Alignment.center,
          padding: tabPadding,
          decoration: BoxDecoration(
            color: i == index ? theme.colorScheme.background : null,
            borderRadius: BorderRadius.circular(theme.radiusMd),
          ),
          child: (i == index ? child.foreground() : child.muted())
              .small()
              .medium(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TabsTheme>(context);
    final containerPadding = styleValue(
      defaultValue: const EdgeInsets.all(4) * scaling,
      themeValue: compTheme?.containerPadding,
    );
    final backgroundColor = styleValue(
      defaultValue: theme.colorScheme.muted,
      themeValue: compTheme?.backgroundColor,
    );
    final borderRadius = styleValue(
      defaultValue: BorderRadius.circular(theme.radiusLg),
      themeValue: compTheme?.borderRadius,
    );
    return TabContainer(
      selected: index,
      onSelect: onChanged,
      builder: (context, children) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius is BorderRadius
                ? borderRadius
                : borderRadius.resolve(Directionality.of(context)),
          ),
          padding: containerPadding,
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ).muted(),
          ),
        );
      },
      childBuilder: _childBuilder,
      children: children,
    );
  }
}
