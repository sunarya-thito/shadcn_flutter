import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabListTheme {
  final Color? borderColor;
  final double? borderWidth;
  final Color? indicatorColor;
  final double? indicatorHeight;

  const TabListTheme({
    this.borderColor,
    this.borderWidth,
    this.indicatorColor,
    this.indicatorHeight,
  });

  TabListTheme copyWith({
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<Color?>? indicatorColor,
    ValueGetter<double?>? indicatorHeight,
  }) {
    return TabListTheme(
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      indicatorColor: indicatorColor == null
          ? this.indicatorColor
          : indicatorColor(),
      indicatorHeight: indicatorHeight == null
          ? this.indicatorHeight
          : indicatorHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabListTheme &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.indicatorColor == indicatorColor &&
        other.indicatorHeight == indicatorHeight;
  }

  @override
  int get hashCode =>
      Object.hash(borderColor, borderWidth, indicatorColor, indicatorHeight);
}

class TabList extends StatelessWidget {
  final List<TabChild> children;
  final int index;
  final ValueChanged<int>? onChanged;

  const TabList({
    super.key,
    required this.children,
    required this.index,
    required this.onChanged,
  });

  Widget _childBuilder(
    BuildContext context,
    TabContainerData data,
    Widget child,
  ) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabListTheme>(context);
    final indicatorColor = styleValue(
      defaultValue: theme.colorScheme.primary,
      themeValue: compTheme?.indicatorColor,
    );
    final indicatorHeight = styleValue(
      defaultValue: 2 * theme.scaling,
      themeValue: compTheme?.indicatorHeight,
    );
    child = TabButton(
      enabled: data.onSelect != null,
      onPressed: () {
        data.onSelect?.call(data.index);
      },
      child: child,
    );
    return Stack(
      fit: StackFit.passthrough,
      children: [
        data.index == index ? child.foreground() : child.muted(),
        if (data.index == index)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: indicatorHeight, color: indicatorColor),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TabListTheme>(context);
    final borderColor = styleValue(
      defaultValue: theme.colorScheme.border,
      themeValue: compTheme?.borderColor,
    );
    final borderWidth = styleValue(
      defaultValue: 1 * scaling,
      themeValue: compTheme?.borderWidth,
    );
    return TabContainer(
      selected: index,
      onSelect: onChanged,
      builder: (context, children) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor, width: borderWidth),
            ),
          ),
          child: Row(children: children),
        );
      },
      childBuilder: _childBuilder,
      children: children,
    );
  }
}
