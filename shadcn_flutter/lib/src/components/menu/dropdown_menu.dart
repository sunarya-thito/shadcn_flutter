import 'package:shadcn_flutter/shadcn_flutter.dart';

class DropdownMenu extends StatefulWidget {
  final List<MenuItem> children;

  const DropdownMenu({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        subMenuOffset: const Offset(8, -4),
        onDismissed: () {
          Navigator.of(context).pop();
        },
        builder: (context, children) {
          return MenuPopup(
            children: children,
          );
        },
        children: widget.children,
      ),
    );
  }
}
