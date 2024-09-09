import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabList extends StatelessWidget {
  final List<Widget> children;
  final int? index;

  const TabList({
    super.key,
    required this.children,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
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
        children: [
          for (var i = 0; i < children.length; i++)
            Stack(
              children: [
                i == index ? children[i].foreground() : children[i].muted(),
                if (i == index)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2 * scaling,
                      color: theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
