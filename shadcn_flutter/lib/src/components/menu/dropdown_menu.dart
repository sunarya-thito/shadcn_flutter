import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DropdownMenu extends StatefulWidget {
  final TriggerBuilder builder;
  final List<MenuItem> items;
  final HitTestBehavior behavior;
  final Offset? offset;
  final Alignment alignment;
  final Alignment? anchorAlignment;

  const DropdownMenu({
    Key? key,
    required this.builder,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
    this.offset,
    this.alignment = Alignment.topCenter,
    this.anchorAlignment = Alignment.bottomCenter,
  }) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late ValueNotifier<List<MenuItem>> _children;

  @override
  void initState() {
    super.initState();
    _children = ValueNotifier(widget.items);
  }

  @override
  void didUpdateWidget(covariant DropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.items, oldWidget.items)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _children.value = widget.items;
      });
    }
  }

  @override
  void dispose() {
    _children.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Popover(
      builder: widget.builder,
      popoverBuilder: (context) {
        return AnimatedBuilder(
            animation: _children,
            builder: (context, child) {
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 192,
                ),
                child: MenuGroup(
                  children: _children.value,
                  subMenuOffset: const Offset(8, -4),
                  onDismissed: () {
                    Navigator.of(context).pop();
                  },
                  builder: (context, children) {
                    return MenuPopup(
                      children: children,
                    );
                  },
                ),
              );
            });
      },
      alignment: widget.alignment,
      anchorAlignment: widget.anchorAlignment,
      modal: false,
    );
  }
}
