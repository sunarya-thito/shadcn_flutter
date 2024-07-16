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
  final FocusScopeNode? focusScopeNode;

  MenuButton({
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
    this.focusScopeNode,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late FocusScopeNode? _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = widget.focusScopeNode ?? FocusScopeNode();
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusScopeNode != oldWidget.focusScopeNode) {
      _focusScopeNode = widget.focusScopeNode ?? FocusScopeNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarData>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    assert(menuData != null || menuBarData != null,
        'MenuButton must be a descendant of Menubar or Menu');
    var focusNode = menuBarData?.focusNode ?? menuData!.focusNode;
    var parentFocusNode =
        menuBarData?.parentFocusScopeNode ?? menuData!.parentFocusScopeNode;
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
              focusNode: focusNode,
              onHover: (value) {
                print('onHover $value ${parentFocusNode.hasFocus}');
                if (value &&
                    (parentFocusNode.hasFocus || menuBarData == null)) {
                  context.showPopover();
                }
              },
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
                child: FocusScope(
                  node: _focusScopeNode!,
                  child: MenuGroup(
                    dataBuilder: () {
                      return MenuData(
                        parentFocusScopeNode: _focusScopeNode!,
                      );
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

class MenubarData extends MenuData {
  MenubarData({required super.parentFocusScopeNode});
}

class MenuData {
  final GlobalKey itemKey = GlobalKey();
  final GlobalKey popupKey = GlobalKey();
  final FocusNode focusNode = FocusNode();
  final FocusScopeNode parentFocusScopeNode;

  late int _index;
  late int _length;

  MenuData({required this.parentFocusScopeNode});
}

class MenuGroup<T extends MenuData> extends StatefulWidget {
  final List<Widget> children;
  final T Function() dataBuilder;
  final Widget Function(BuildContext context, List<Widget> children) builder;

  MenuGroup({
    super.key,
    required this.dataBuilder,
    required this.children,
    required this.builder,
  });

  @override
  State<MenuGroup<T>> createState() => _MenuGroupState<T>();
}

class _MenuGroupState<T extends MenuData> extends State<MenuGroup<T>> {
  late List<T> _data;

  @override
  void initState() {
    super.initState();
    _data = List.generate(widget.children.length, (i) {
      return widget.dataBuilder()
        .._index = i
        .._length = widget.children.length;
    });
  }

  @override
  void didUpdateWidget(covariant MenuGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
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
