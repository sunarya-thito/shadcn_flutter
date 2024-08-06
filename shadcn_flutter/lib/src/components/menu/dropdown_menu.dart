import 'package:shadcn_flutter/shadcn_flutter.dart';

void showDropdown(
    {required BuildContext context, required WidgetBuilder builder}) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final GlobalKey key = GlobalKey();
  showPopover(
    context: context,
    alignment: Alignment.topCenter,
    offset: const Offset(0, 4) * scaling,
    consumeOutsideTaps: false,
    regionGroupId: key,
    modal: false,
    dismissBackdropFocus: true,
    builder: (context) {
      return Data.inherit(
        data: DropdownMenuData(key),
        child: builder(context),
      );
    },
  );
}

class DropdownMenuData {
  final GlobalKey key;

  DropdownMenuData(this.key);
}

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
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 192,
      ),
      child: MenuGroup(
        regionGroupId: Data.maybeOf<DropdownMenuData>(context)?.key,
        subMenuOffset: const Offset(8, -4) * theme.scaling,
        onDismissed: () {
          closePopover(context);
        },
        direction: Axis.vertical,
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
