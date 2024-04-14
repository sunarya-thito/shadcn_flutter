import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

mixin MenuParent {
  MenuParent? get parent;
  int? get focusedChild;
  set focusedChild(int? index);
}

class MenuChild {
  final int index;
  final MenuParent parent;
  final bool focused;
  MenuChild({required this.index, required this.parent, this.focused = false});

  void focusNextSibling() {
    parent.focusedChild = index + 1;
  }

  void focusPreviousSibling() {
    parent.focusedChild = index - 1;
  }

  void focusNextParentSibling() {
    if (parent is MenuChildState) {
      MenuChild? handler = (parent as MenuChildState).handler;
      if (handler != null) {
        handler.focusNextSibling();
      }
    }
  }

  void focusPreviousParentSibling() {
    if (parent is MenuChildState) {
      MenuChild? handler = (parent as MenuChildState).handler;
      if (handler != null) {
        handler.focusPreviousSibling();
      }
    }
  }

  void focus() {
    parent.focusedChild = index;
  }
}

mixin MenuChildState<T extends StatefulWidget> on State<T> {
  MenuChild? _currentHandler;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentHandler = Data.maybeOf(context);
  }

  MenuChild? get handler => _currentHandler;
}

class MenuBar extends StatefulWidget {
  final List<Widget> children;

  const MenuBar({super.key, required this.children});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with MenuParent {
  int? _focusedChild;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  MenuParent? _parent;

  @override
  int? get focusedChild {
    return _focusedChild;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MenuParent? oldParent = _parent;
    _parent = Data.maybeOf(context);
    if (oldParent != _parent) {
      didChangeParent(oldParent);
    }
  }

  void didChangeParent(MenuParent? oldParent) {}

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        focusedChild = null;
      },
      child: Data<MenuParent>(
        data: this,
        child: FocusScope.withExternalFocusNode(
          focusScopeNode: _focusScopeNode,
          onFocusChange: (value) {
            print('focus $value');
          },
          child: Container(
            padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
            child: Row(children: [
              for (int i = 0; i < widget.children.length; i++)
                Data<MenuChild>(
                  data: MenuChild(
                    index: i,
                    parent: this,
                    focused: _focusedChild == i,
                  ),
                  child: widget.children[i],
                ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  MenuParent? get parent => _parent;

  @override
  set focusedChild(int? index) {
    setState(() {
      _focusedChild = index;
    });
  }
}

class MenuItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool _dispatchOnFocus;

  const MenuItem({super.key, required this.child, this.onPressed})
      : _dispatchOnFocus = false;

  const MenuItem._({
    super.key,
    required this.child,
    required this.onPressed,
    required bool dispatchOnFocus,
  }) : _dispatchOnFocus = dispatchOnFocus;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class MenuNextSiblingIntent extends Intent {
  const MenuNextSiblingIntent();
}

class MenuPreviousSiblingIntent extends Intent {
  const MenuPreviousSiblingIntent();
}

class MenuNextParentSiblingIntent extends Intent {
  const MenuNextParentSiblingIntent();
}

class MenuPreviousParentSiblingIntent extends Intent {
  const MenuPreviousParentSiblingIntent();
}

class _MenuItemState extends State<MenuItem> with MenuChildState {
  final FocusNode _focusNode = FocusNode();
  bool _hover = false;
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    MenuParent? parent = Data.maybeOf(context);
    MenuChild menuChild = Data.of(context);
    return GestureDetector(
      onTap: () {
        widget.onPressed?.call();
        if (widget._dispatchOnFocus) {
          menuChild.focus();
        }
      },
      child: FocusableActionDetector(
        focusNode: _focusNode,
        enabled: widget.onPressed != null,
        mouseCursor: widget.onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown):
              const MenuNextSiblingIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp):
              const MenuPreviousSiblingIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const MenuNextParentSiblingIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const MenuPreviousParentSiblingIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (e) {
              widget.onPressed?.call();
              return true;
            },
          ),
        },
        onShowHoverHighlight: (value) {
          if (value && (parent?.focusedChild != null || parent is _MenuState)) {
            menuChild.focus();
            if (widget._dispatchOnFocus || parent is _MenuBarState) {
              widget.onPressed?.call();
            }
          }
          setState(() {
            _hover = value;
          });
        },
        onShowFocusHighlight: (value) {
          setState(() {
            _focus = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.radiusSm),
            color: (menuChild.focused || _focus || _hover) &&
                    widget.onPressed != null
                ? theme.colorScheme.accent
                : null,
          ),
          margin: parent is _MenuState
              ? const EdgeInsets.symmetric(horizontal: 4)
              : const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          alignment:
              parent is _MenuState ? Alignment.centerLeft : Alignment.center,
          child: mergeAnimatedTextStyle(
            style: TextStyle(
              color: widget.onPressed != null
                  ? theme.colorScheme.accentForeground
                  : theme.colorScheme.muted,
            ),
            child: widget.child,
            duration: kDefaultDuration,
          ),
        ),
      ),
    );
  }
}

class MenuDivider extends StatelessWidget {
  const MenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Divider(),
    );
  }
}

class Menu extends StatefulWidget {
  final Widget child;
  final List<Widget> items;

  const Menu({super.key, required this.child, required this.items});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with MenuParent, MenuChildState {
  final PopoverController _controller = PopoverController();
  final FocusScopeNode _focusNode = FocusScopeNode();
  MenuParent? _parent;
  final ValueNotifier<int?> _focusedChild = ValueNotifier(null);

  @override
  set focusedChild(int? index) {
    _focusedChild.value = index;
  }

  @override
  int? get focusedChild {
    return _focusedChild.value == null
        ? null
        : _focusedChild.value! % widget.items.length;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MenuParent? oldParent = _parent;
    _parent = Data.maybeOf(context);
    if (oldParent != _parent) {
      didChangeParent(oldParent);
    }
    MenuChild menuChild = Data.of(context);
    if (!menuChild.focused && _controller.hasOpenPopovers) {
      _controller.close();
    }
  }

  void _show() {
    if (_controller.hasOpenPopovers) return;
    _controller.show(
      builder: (context) {
        return ValueListenableBuilder(
            valueListenable: _focusedChild,
            builder: (context, value, _) {
              return Shortcuts(
                shortcuts: {
                  LogicalKeySet(LogicalKeyboardKey.arrowDown):
                      const MenuNextSiblingIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowUp):
                      const MenuPreviousSiblingIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowRight):
                      const MenuNextParentSiblingIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                      const MenuPreviousParentSiblingIntent(),
                },
                child: Actions(
                  actions: {
                    MenuNextSiblingIntent: CallbackAction(
                      onInvoke: (e) {
                        focusedChild = (focusedChild ?? -1) + 1;
                        return true;
                      },
                    ),
                    MenuPreviousSiblingIntent: CallbackAction(
                      onInvoke: (e) {
                        focusedChild = (focusedChild ?? 1) - 1;
                        return true;
                      },
                    ),
                    MenuNextParentSiblingIntent: CallbackAction(
                      onInvoke: (e) {
                        if (_parent is MenuChildState) {
                          MenuChild? handler =
                              (_parent as MenuChildState).handler;
                          if (handler != null) {
                            handler.focusNextSibling();
                          }
                        }
                        return true;
                      },
                    ),
                    MenuPreviousParentSiblingIntent: CallbackAction(
                      onInvoke: (e) {
                        if (_parent is MenuChildState) {
                          MenuChild? handler =
                              (_parent as MenuChildState).handler;
                          if (handler != null) {
                            handler.focusPreviousSibling();
                          }
                        }
                        return true;
                      },
                    ),
                  },
                  child: Focus(
                    focusNode: _focusNode,
                    autofocus: true,
                    child: MenuPopover(
                      parent: parent,
                      current: this,
                      items: widget.items,
                      focusedChild: focusedChild,
                    ),
                  ),
                ),
              );
            });
      },
      alignment:
          _parent is _MenuBarState ? Alignment.bottomRight : Alignment.topLeft,
      anchorAlignment: Alignment.topRight,
      offset:
          _parent is _MenuBarState ? const Offset(0, 0) : const Offset(4, -4),
    );
  }

  void didChangeParent(MenuParent? oldParent) {}

  @override
  Widget build(BuildContext context) {
    return PopoverPortal(
      controller: _controller,
      child: MenuItem._(
        dispatchOnFocus: true,
        onPressed: widget.items.isNotEmpty ? _show : null,
        child: widget.child,
      ),
    );
  }

  @override
  MenuParent? get parent => _parent;
}

class MenuPopover extends StatelessWidget {
  final List<Widget> items;
  final MenuParent? parent;
  final MenuParent current;
  final int? focusedChild;

  const MenuPopover(
      {super.key,
      required this.items,
      this.parent,
      required this.current,
      required this.focusedChild});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<MenuParent>(
      data: current,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: parent is _MenuBarState
            ? const EdgeInsets.only(top: 8)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(
            color: theme.colorScheme.muted,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < items.length; i++)
                Data<MenuChild>(
                  data: MenuChild(
                      index: i, parent: current, focused: i == focusedChild),
                  child: items[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
