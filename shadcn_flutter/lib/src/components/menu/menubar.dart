import 'package:shadcn_flutter/shadcn_flutter.dart';

class Menubar extends StatefulWidget {
  final List<Widget> children;
  final Offset? popoverOffset;
  final bool border;

  const Menubar({
    this.popoverOffset,
    this.border = true,
    required this.children,
  });

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  @override
  Widget build(BuildContext context) {
    if (widget.border) {
      final theme = Theme.of(context);
      return OutlinedContainer(
        borderColor: theme.colorScheme.border,
        backgroundColor: theme.colorScheme.background,
        borderRadius: theme.radiusMd,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: buildContainer(context),
        ),
      );
    }
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    return MenuGroup<MenubarData>(
      anchorAlignment: Alignment.bottomLeft,
      popoverAlignment: Alignment.topLeft,
      popoverOffset: widget.popoverOffset ??
          Offset(widget.border ? -4 : 0, widget.border ? 8 : 4),
      children: widget.children,
      dataBuilder: () {
        return MenubarData();
      },
      builder: (context, children) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ).medium();
      },
    );
  }
}
