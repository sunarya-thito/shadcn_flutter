import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        thickness: 1,
        indent: -4,
        endIndent: -4,
        color: theme.colorScheme.border,
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final Widget child;
  final List<Widget>? subMenu;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
  final FocusNode? focusNode;

  MenuButton({
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarData>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    assert(menuData != null || menuBarData != null,
        'MenuButton must be a descendant of Menubar or Menu');
    return Data<MenuData>.boundary(
      child: Data<MenubarData>.boundary(
        child: Popover(
          builder: (context) {
            return Button(
              style: menuBarData == null
                  ? ButtonVariance.menu
                  : ButtonVariance.menubar,
              trailing: widget.trailing,
              leading: widget.leading,
              disableTransition: true,
              enabled: widget.enabled,
              onHover: (value) {},
              onPressed: () {
                widget.onPressed?.call();
                if (widget.subMenu != null) {
                  context.showPopover();
                }
              },
              child: widget.child,
            );
          },
          popoverBuilder: (context) {
            if (widget.subMenu != null) {
              return Padding(
                padding: menuBarData != null
                    ? const EdgeInsets.only(top: 8)
                    : EdgeInsets.zero,
                child: Focus(
                  focusNode: _focusNode!,
                  onFocusChange: (value) {
                    print('focus changed ($_focusNode): $value');
                  },
                  child: MenuGroup(
                    dataBuilder: () {
                      return MenuData();
                    },
                    children: widget.subMenu!,
                    builder: (context, children) {
                      return MenuPopup(
                        children: children,
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
          popoverOffset: menuBarData != null ? null : const Offset(8, -4 + -1),
          alignment: Alignment.topLeft,
          anchorAlignment:
              menuBarData != null ? Alignment.bottomLeft : Alignment.topRight,
        ),
      ),
    );
  }
}

class MenubarData extends MenuData {}

class MenuData {
  final GlobalKey itemKey = GlobalKey();
  final GlobalKey popupKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  late int _index;
  late int _length;
}

class MenuGroup<T extends MenuData> extends StatefulWidget {
  final PopoverController? popoverController;
  final List<Widget> children;
  final T Function() dataBuilder;
  final Widget Function(BuildContext context, List<Widget> children) builder;
  final Alignment popoverAlignment;
  final Alignment anchorAlignment;

  MenuGroup({
    super.key,
    required this.dataBuilder,
    required this.children,
    required this.builder,
    this.popoverController,
    required this.popoverAlignment,
    required this.anchorAlignment,
  });

  @override
  State<MenuGroup<T>> createState() => _MenuGroupState<T>();
}

class _MenuGroupState<T extends MenuData> extends State<MenuGroup<T>> {
  late List<T> _data;
  late PopoverController _popoverController;

  void openMenu(List<Widget> children) {
    _popoverController.show(
        builder: builder,
        alignment: alignment,
        anchorAlignment: anchorAlignment);
  }

  @override
  void initState() {
    super.initState();
    _popoverController = widget.popoverController ?? PopoverController();
    _data = List.generate(widget.children.length, (i) {
      return widget.dataBuilder()
        .._index = i
        .._length = widget.children.length;
    });
  }

  @override
  void didUpdateWidget(covariant MenuGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.popoverController != oldWidget.popoverController) {
      _popoverController = widget.popoverController ?? PopoverController();
    }
    if (!listEquals(oldWidget.children, widget.children)) {
      _data = List.generate(widget.children.length, (i) {
        return widget.dataBuilder()
          .._index = i
          .._length = widget.children.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final data = _data[i];
      children.add(
        Data<T>(
          data: data,
          child: child,
        ),
      );
    }
    return widget.builder(context, children);
  }
}
