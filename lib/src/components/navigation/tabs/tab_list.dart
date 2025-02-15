import 'package:shadcn_flutter/shadcn_flutter.dart';

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
      BuildContext context, TabContainerData data, Widget child) {
    final theme = Theme.of(context);
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
            child: Container(
              height: 2 * theme.scaling,
              color: theme.colorScheme.primary,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return TabContainer(
        selected: index,
        onSelect: onChanged,
        builder: (context, children) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.border,
                  width: 1 * scaling,
                ),
              ),
            ),
            child: Row(
              children: children,
            ),
          );
        },
        childBuilder: _childBuilder,
        children: children);
  }
}
