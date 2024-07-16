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
  late FocusNode _focusNode;

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
    final menuBarData = Data.maybeOf<MenubarState>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    return Data<MenuData>.boundary(
      child: Data<MenubarState>.boundary(
        child: PopoverPortal(
          controller: menuData!.popoverController,
          child: AnimatedBuilder(
              animation: menuData.popoverController,
              builder: (context, child) {
                return Button(
                  style: (menuBarData == null
                          ? ButtonVariance.menu
                          : ButtonVariance.menubar)
                      .copyWith(
                    decoration: (context, states, value) {
                      final theme = Theme.of(context);
                      return (value as BoxDecoration).copyWith(
                        color: menuData.popoverController.hasOpenPopovers
                            ? theme.colorScheme.accent
                            : null,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                      );
                    },
                  ),
                  trailing: menuBarData != null
                      ? widget.trailing
                      : Row(
                          children: [
                            if (widget.trailing != null) widget.trailing!,
                            if (widget.subMenu != null && menuBarData == null)
                              const Icon(
                                RadixIcons.chevronRight,
                                size: 16,
                              ),
                          ],
                        ).gap(8),
                  leading: widget.leading,
                  disableTransition: true,
                  enabled: widget.enabled,
                  focusNode: _focusNode,
                  onHover: (value) {
                    if (value) {
                      _focusNode.requestFocus();
                    }
                  },
                  onPressed: () {
                    widget.onPressed?.call();
                    if (widget.subMenu != null &&
                        !menuData.popoverController.hasOpenPopovers) {
                      menuData.popoverController.show(
                        builder: (context) {
                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 192, // 12rem
                            ),
                            child: MenuGroup(
                                children: widget.subMenu!,
                                builder: (context, children) {
                                  return MenuPopup(
                                    children: children,
                                  );
                                }),
                          );
                        },
                        alignment: Alignment.topLeft,
                        anchorAlignment: menuBarData != null
                            ? Alignment.bottomLeft
                            : Alignment.topRight,
                        offset: menuBarData != null
                            ? menuBarData.widget.border
                                ? const Offset(-4, 8)
                                : const Offset(0, 4)
                            : const Offset(8, -4 + -1),
                      );
                    }
                  },
                  child: widget.child,
                );
              }),
        ),
      ),
    );
  }
}

class MenuData {
  final PopoverController popoverController = PopoverController();
}

class MenuGroup extends StatefulWidget {
  final PopoverController? popoverController;
  final List<Widget> children;
  final Widget Function(BuildContext context, List<Widget> children) builder;

  MenuGroup({
    super.key,
    required this.children,
    required this.builder,
    this.popoverController,
  });

  @override
  State<MenuGroup> createState() => _MenuGroupState();
}

class _MenuGroupState extends State<MenuGroup> {
  late List<MenuData> _data;

  @override
  void initState() {
    super.initState();
    _data = List.generate(widget.children.length, (i) {
      return MenuData();
    });
  }

  @override
  void didUpdateWidget(covariant MenuGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      _data = List.generate(widget.children.length, (i) {
        return MenuData();
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
        Data<MenuData>(
          data: data,
          child: child,
        ),
      );
    }
    return widget.builder(context, children);
  }
}
