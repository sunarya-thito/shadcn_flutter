import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuShortcut extends StatelessWidget {
  final ShortcutActivator activator;

  const MenuShortcut({required this.activator});

  @override
  Widget build(BuildContext context) {
    if (activator is CharacterActivator) {
      final characterActivator = activator as CharacterActivator;
      String display = characterActivator.character;
      if (characterActivator.meta) {
        display = 'Meta + $display';
      }
      if (characterActivator.alt) {
        display = 'Alt + $display';
      }
      if (characterActivator.control) {
        display = 'Ctrl + $display';
      }
      return Text(display).xSmall().muted();
    }
    if (activator is SingleActivator) {
      final singleActivator = activator as SingleActivator;
      String display = singleActivator.trigger.keyLabel;
      if (singleActivator.shift) {
        display = 'Shift + $display';
      }
      if (singleActivator.meta) {
        display = 'Meta + $display';
      }
      if (singleActivator.alt) {
        display = 'Alt + $display';
      }
      if (singleActivator.control) {
        display = 'Ctrl + $display';
      }
      return Text(display).xSmall().muted();
    }
    return Text(activator.toString()).xSmall().muted();
  }
}

abstract class MenuItem extends Widget {
  bool get hasLeading;
  PopoverController? get popoverController;
}

class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  final T? value;
  final ContextedValueChanged<T>? onChanged;
  final List<Widget> children;

  MenuRadioGroup({
    required this.value,
    required this.onChanged,
    required this.children,
  });

  @override
  bool get hasLeading => children.isNotEmpty;

  @override
  PopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    return Data<MenuRadioGroup<T>>(
      data: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class MenuRadio<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final Widget? trailing;
  final FocusNode? focusNode;
  final bool enabled;
  final bool autoClose;

  MenuRadio({
    required this.value,
    required this.child,
    this.trailing,
    this.focusNode,
    this.enabled = true,
    this.autoClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final radioGroup = Data.maybeOf<MenuRadioGroup<T>>(context);
    assert(radioGroup != null, 'MenuRadio must be a child of MenuRadioGroup');
    return Data<MenuRadioGroup<T>>.boundary(
      child: MenuButton(
        leading: radioGroup!.value == value
            ? const SizedBox(
                width: 16,
                height: 16,
                child: Icon(
                  RadixIcons.dotFilled,
                  size: 6,
                ),
              )
            : const SizedBox(width: 16),
        onPressed: (context) {
          radioGroup.onChanged?.call(context, value);
        },
        enabled: enabled,
        focusNode: focusNode,
        autoClose: autoClose,
        trailing: trailing,
        child: child,
      ),
    );
  }
}

class MenuDivider extends StatelessWidget implements MenuItem {
  const MenuDivider({super.key});
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

  @override
  bool get hasLeading => false;

  @override
  PopoverController? get popoverController => null;
}

class MenuButton extends StatefulWidget implements MenuItem {
  final Widget child;
  final List<MenuItem>? subMenu;
  final ContextedCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autoClose;
  @override
  final PopoverController? popoverController;
  MenuButton({
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
    this.focusNode,
    this.autoClose = true,
    this.popoverController,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();

  @override
  bool get hasLeading => leading != null;
}

class MenuLabel extends StatelessWidget implements MenuItem {
  final Widget child;
  final Widget? trailing;
  final Widget? leading;

  MenuLabel({
    required this.child,
    this.trailing,
    this.leading,
  });

  @override
  bool get hasLeading => leading != null;

  @override
  PopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(menuGroupData != null, 'MenuLabel must be a child of MenuGroup');
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6),
      child: Basic(
        contentSpacing: 8,
        leading: leading == null && menuGroupData!.hasLeading
            ? const SizedBox(width: 16)
            : leading == null
                ? null
                : SizedBox(
                    width: 16,
                    height: 16,
                    child: IconTheme.merge(
                      data: const IconThemeData(
                        size: 16,
                      ),
                      child: leading!,
                    ),
                  ),
        trailing: trailing,
        content: UnderlineInterceptor(child: child.medium()),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: Alignment.centerLeft,
      ),
    );
  }
}

class MenuCheckbox extends StatelessWidget implements MenuItem {
  final bool value;
  final ContextedValueChanged<bool>? onChanged;
  final Widget child;
  final Widget? trailing;
  final FocusNode? focusNode;
  final bool enabled;
  final bool autoClose;

  MenuCheckbox({
    this.value = false,
    this.onChanged,
    required this.child,
    this.trailing,
    this.focusNode,
    this.enabled = true,
    this.autoClose = true,
  });

  @override
  bool get hasLeading => true;
  @override
  PopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    return MenuButton(
      leading: value
          ? const SizedBox(
              width: 16,
              height: 16,
              child: Icon(
                RadixIcons.check,
                size: 11,
              ),
            )
          : const SizedBox(width: 16),
      onPressed: (context) {
        onChanged?.call(context, !value);
      },
      enabled: enabled,
      focusNode: focusNode,
      autoClose: autoClose,
      trailing: trailing,
      child: child,
    );
  }
}

class _MenuButtonState extends State<MenuButton> {
  late FocusNode _focusNode;
  final ValueNotifier<List<MenuItem>> _children = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _children.value = widget.subMenu ?? [];
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (!listEquals(widget.subMenu, oldWidget.subMenu)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _children.value = widget.subMenu ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarState>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    void openSubMenu() {
      menuGroupData!.closeOthers();
      menuData!.popoverController.show(
        regionGroupId: menuGroupData.root ?? menuGroupData,
        builder: (context) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 192, // 12rem
            ),
            child: AnimatedBuilder(
                animation: _children,
                builder: (context, child) {
                  return MenuGroup(
                      parent: menuGroupData,
                      children: _children.value,
                      onDismissed: menuGroupData.onDismissed,
                      subMenuOffset: const Offset(8, -4 + -1),
                      builder: (context, children) {
                        return MenuPopup(
                          children: children,
                        );
                      });
                }),
          );
        },
        alignment: Alignment.topLeft,
        anchorAlignment:
            menuBarData != null ? Alignment.bottomLeft : Alignment.topRight,
        // offset: menuBarData != null
        //     ? menuBarData.widget.border
        //         ? const Offset(-4, 8)
        //         : const Offset(0, 4)
        //     : const Offset(8, -4 + -1),
        offset: menuGroupData.subMenuOffset,
      );
    }

    return Data<MenuGroupData>.boundary(
      child: Data<MenuData>.boundary(
        child: Data<MenubarState>.boundary(
          child: TapRegion(
            groupId: menuGroupData!.root ?? menuGroupData,
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
                                if (widget.subMenu != null &&
                                    menuBarData == null)
                                  const Icon(
                                    RadixIcons.chevronRight,
                                    size: 16,
                                  ),
                              ],
                            ).gap(8),
                      leading: widget.leading == null &&
                              menuGroupData.hasLeading &&
                              menuBarData == null
                          ? const SizedBox(width: 16)
                          : widget.leading == null
                              ? null
                              : SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: IconTheme.merge(
                                    data: const IconThemeData(
                                      size: 16,
                                    ),
                                    child: widget.leading!,
                                  ),
                                ),
                      disableTransition: true,
                      enabled: widget.enabled,
                      focusNode: _focusNode,
                      onHover: (value) {
                        if (value) {
                          if ((menuBarData == null ||
                                  menuGroupData.hasOpenPopovers) &&
                              widget.subMenu != null) {
                            if (!menuData.popoverController.hasOpenPopovers) {
                              openSubMenu();
                            }
                          } else {
                            menuGroupData.closeOthers();
                          }
                        }
                      },
                      onFocus: (value) {
                        if (value) {
                          if (widget.subMenu != null) {
                            if (!menuData.popoverController.hasOpenPopovers) {
                              openSubMenu();
                            }
                          } else {
                            menuGroupData.closeOthers();
                          }
                        }
                      },
                      onPressed: () {
                        widget.onPressed?.call(context);
                        if (widget.subMenu != null &&
                            widget.subMenu!.isNotEmpty) {
                          if (!menuData.popoverController.hasOpenPopovers) {
                            openSubMenu();
                          }
                        } else {
                          if (widget.autoClose) {
                            menuGroupData.closeAll();
                          }
                        }
                      },
                      child: widget.child,
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuGroupData {
  final MenuGroupData? parent;
  final List<MenuData> children;
  final bool hasLeading;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;

  MenuGroupData(this.parent, this.children, this.hasLeading, this.subMenuOffset,
      this.onDismissed);

  bool get hasOpenPopovers {
    for (final child in children) {
      if (child.popoverController.hasOpenPopovers) {
        const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6);
        return true;
      }
    }
    return false;
  }

  void closeOthers() {
    for (final child in children) {
      child.popoverController.close();
    }
  }

  void closeAll() {
    var menuGroupData = parent;
    if (menuGroupData == null) {
      onDismissed?.call();
      return;
    }
    menuGroupData.closeOthers();
    menuGroupData.closeAll();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is MenuGroupData) {
      return listEquals(children, other.children) &&
          parent == other.parent &&
          hasLeading == other.hasLeading &&
          subMenuOffset == other.subMenuOffset &&
          onDismissed == other.onDismissed;
    }
    return false;
  }

  MenuGroupData get root {
    var menuGroupData = parent;
    if (menuGroupData == null) {
      return this;
    }
    return menuGroupData.root;
  }

  @override
  int get hashCode => Object.hash(
        children,
        parent,
        hasLeading,
        subMenuOffset,
        onDismissed,
      );
}

class MenuData {
  final PopoverController popoverController;

  MenuData({PopoverController? popoverController})
      : popoverController = popoverController ?? PopoverController();
}

class MenuGroup extends StatefulWidget {
  final List<MenuItem> children;
  final Widget Function(BuildContext context, List<Widget> children) builder;
  final MenuGroupData? parent;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;

  MenuGroup({
    super.key,
    required this.children,
    required this.builder,
    this.parent,
    this.subMenuOffset,
    this.onDismissed,
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
      Map<Key, MenuData> oldKeyedData = {};
      for (int i = 0; i < oldWidget.children.length; i++) {
        oldKeyedData[oldWidget.children[i].key ?? ValueKey(i)] = _data[i];
      }
      _data = List.generate(widget.children.length, (i) {
        var child = widget.children[i];
        var key = child.key ?? ValueKey(i);
        var oldData = oldKeyedData[key];
        if (oldData != null) {
          if (child.popoverController != null &&
              oldData.popoverController != child.popoverController) {
            oldData.popoverController.dispose();
            oldData = MenuData(popoverController: child.popoverController);
          }
        } else {
          oldData = MenuData(popoverController: child.popoverController);
        }
        return oldData;
      });
      // dispose unused data
      for (var data in oldKeyedData.values) {
        if (!_data.contains(data)) {
          data.popoverController.dispose();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var data in _data) {
      data.popoverController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    bool hasLeading = false;
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final data = _data[i];
      if (child.hasLeading) {
        hasLeading = true;
      }
      children.add(
        Data<MenuData>(
          data: data,
          child: child,
        ),
      );
    }
    return FocusTraversalGroup(
      child: FocusableActionDetector(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.arrowUp): PreviousFocusIntent(),
          SingleActivator(LogicalKeyboardKey.arrowDown): NextFocusIntent(),
          SingleActivator(LogicalKeyboardKey.arrowLeft):
              DirectionalFocusIntent(TraversalDirection.left),
          SingleActivator(LogicalKeyboardKey.arrowRight):
              DirectionalFocusIntent(TraversalDirection.right),
        },
        child: Data(
          data: MenuGroupData(
            widget.parent,
            _data,
            hasLeading,
            widget.subMenuOffset,
            widget.onDismissed,
          ),
          child: widget.builder(context, children),
        ),
      ),
    );
  }
}
