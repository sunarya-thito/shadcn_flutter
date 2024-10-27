import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuShortcut extends StatelessWidget {
  final ShortcutActivator activator;
  final Widget? combiner;

  const MenuShortcut({super.key, required this.activator, this.combiner});

  @override
  Widget build(BuildContext context) {
    var activator = this.activator;
    var combiner = this.combiner ?? const Text(' + ');
    final displayMapper = Data.maybeOf<KeyboardShortcutDisplayHandle>(context);
    assert(displayMapper != null, 'Cannot find KeyboardShortcutDisplayMapper');
    List<LogicalKeyboardKey> keys = shortcutActivatorToKeySet(activator);
    List<Widget> children = [];
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) {
        children.add(combiner);
      }
      children.add(displayMapper!.buildKeyboardDisplay(context, keys[i]));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ).xSmall().muted();
  }
}

abstract class MenuItem extends Widget {
  const MenuItem({super.key});

  bool get hasLeading;
  PopoverController? get popoverController;
}

class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  final T? value;
  final ContextedValueChanged<T>? onChanged;
  final List<Widget> children;

  const MenuRadioGroup({
    super.key,
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
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(
        menuGroupData != null, 'MenuRadioGroup must be a child of MenuGroup');
    return Data<MenuRadioGroup<T>>.inherit(
      data: this,
      child: Flex(
        direction: menuGroupData!.direction,
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

  const MenuRadio({
    super.key,
    required this.value,
    required this.child,
    this.trailing,
    this.focusNode,
    this.enabled = true,
    this.autoClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final radioGroup = Data.maybeOf<MenuRadioGroup<T>>(context);
    assert(radioGroup != null, 'MenuRadio must be a child of MenuRadioGroup');
    return Data<MenuRadioGroup<T>>.boundary(
      child: MenuButton(
        leading: radioGroup!.value == value
            ? SizedBox(
                width: 16 * scaling,
                height: 16 * scaling,
                child: const Icon(
                  RadixIcons.dotFilled,
                ).iconSmall(),
              )
            : SizedBox(width: 16 * scaling),
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
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return AnimatedPadding(
      duration: kDefaultDuration,
      padding:
          (menuGroupData == null || menuGroupData.direction == Axis.vertical
                  ? const EdgeInsets.symmetric(vertical: 4)
                  : const EdgeInsets.symmetric(horizontal: 4)) *
              scaling,
      child: menuGroupData == null || menuGroupData.direction == Axis.vertical
          ? Divider(
              height: 1 * scaling,
              thickness: 1 * scaling,
              indent: -4 * scaling,
              endIndent: -4 * scaling,
              color: theme.colorScheme.border,
            )
          : VerticalDivider(
              width: 1 * scaling,
              thickness: 1 * scaling,
              color: theme.colorScheme.border,
              indent: -4 * scaling,
              endIndent: -4 * scaling,
            ),
    );
  }

  @override
  bool get hasLeading => false;

  @override
  PopoverController? get popoverController => null;
}

class MenuGap extends StatelessWidget implements MenuItem {
  final double size;

  const MenuGap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Gap(size);
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
  const MenuButton({
    super.key,
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

  const MenuLabel({
    super.key,
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
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(menuGroupData != null, 'MenuLabel must be a child of MenuGroup');
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6) *
              scaling +
          menuGroupData!.itemPadding,
      child: Basic(
        contentSpacing: 8 * scaling,
        leading: leading == null && menuGroupData.hasLeading
            ? SizedBox(width: 16 * scaling)
            : leading == null
                ? null
                : SizedBox(
                    width: 16 * scaling,
                    height: 16 * scaling,
                    child: leading!.iconSmall(),
                  ),
        trailing: trailing,
        content: UnderlineInterceptor(child: child.semiBold()),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: menuGroupData.direction == Axis.vertical
            ? AlignmentDirectional.centerStart
            : Alignment.center,
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

  const MenuCheckbox({
    super.key,
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
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return MenuButton(
      leading: value
          ? SizedBox(
              width: 16 * scaling,
              height: 16 * scaling,
              child: const Icon(
                RadixIcons.check,
              ).iconSmall(),
            )
          : SizedBox(width: 16 * scaling),
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
        if (mounted) {
          _children.value = widget.subMenu ?? [];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarState>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(menuGroupData != null, 'MenuButton must be a child of MenuGroup');
    // final dialogOverlayHandler = Data.maybeOf<DialogOverlayHandler>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = DialogOverlayHandler.isDialogOverlay(context);
    final isIndependentOverlay = isSheetOverlay || isDialogOverlay;
    void openSubMenu(BuildContext context) {
      menuGroupData!.closeOthers();
      final overlayManager = OverlayManager.of(context);
      menuData!.popoverController.show(
        context: context,
        regionGroupId: menuGroupData.regionGroupId,
        consumeOutsideTaps: false,
        dismissBackdropFocus: false,
        modal: true,
        handler: MenuOverlayHandler(overlayManager),
        overlayBarrier: OverlayBarrier(
          borderRadius: BorderRadius.circular(theme.radiusMd),
        ),
        builder: (context) {
          final theme = Theme.of(context);
          final scaling = theme.scaling;
          var itemPadding = menuGroupData.itemPadding;
          final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
          if (isSheetOverlay) {
            itemPadding = const EdgeInsets.symmetric(horizontal: 8) * scaling;
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(
                  minWidth: 192, // 12rem
                ) *
                scaling,
            child: AnimatedBuilder(
                animation: _children,
                builder: (context, child) {
                  return MenuGroup(
                      direction: menuGroupData.direction,
                      parent: menuGroupData,
                      onDismissed: menuGroupData.onDismissed,
                      regionGroupId: menuGroupData.regionGroupId,
                      subMenuOffset: const Offset(8, -4 + -1) * scaling,
                      itemPadding: itemPadding,
                      builder: (context, children) {
                        return MenuPopup(
                          children: children,
                        );
                      },
                      children: _children.value);
                }),
          );
        },
        alignment: Alignment.topLeft,
        anchorAlignment:
            menuBarData != null ? Alignment.bottomLeft : Alignment.topRight,
        offset: menuGroupData.subMenuOffset,
      );
    }

    return Data<MenuData>.boundary(
      child: Data<MenubarState>.boundary(
        child: TapRegion(
          groupId: menuGroupData!.root,
          child: AnimatedBuilder(
              animation: menuData!.popoverController,
              builder: (context, child) {
                return Button(
                  disableFocusOutline: true,
                  alignment: menuGroupData.direction == Axis.vertical
                      ? AlignmentDirectional.centerStart
                      : Alignment.center,
                  style: (menuBarData == null
                          ? ButtonVariance.menu
                          : ButtonVariance.menubar)
                      .copyWith(
                    padding: (context, states, value) {
                      return value.optionallyResolve(context) +
                          menuGroupData.itemPadding;
                    },
                    decoration: (context, states, value) {
                      final theme = Theme.of(context);
                      return (value as BoxDecoration).copyWith(
                        color: menuData.popoverController.hasOpenPopover
                            ? theme.colorScheme.accent
                            : null,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                      );
                    },
                  ),
                  trailing: menuBarData != null
                      ? widget.trailing
                      : widget.trailing != null ||
                              (widget.subMenu != null && menuBarData == null)
                          ? Row(
                              children: [
                                if (widget.trailing != null) widget.trailing!,
                                if (widget.subMenu != null &&
                                    menuBarData == null)
                                  const Icon(
                                    RadixIcons.chevronRight,
                                  ).iconSmall(),
                              ],
                            ).gap(8 * scaling)
                          : null,
                  leading: widget.leading == null &&
                          menuGroupData.hasLeading &&
                          menuBarData == null
                      ? SizedBox(width: 16 * scaling)
                      : widget.leading == null
                          ? null
                          : SizedBox(
                              width: 16 * scaling,
                              height: 16 * scaling,
                              child: widget.leading!.iconSmall(),
                            ),
                  disableTransition: true,
                  enabled: widget.enabled,
                  focusNode: _focusNode,
                  onHover: (value) {
                    if (value) {
                      if ((menuBarData == null ||
                              menuGroupData.hasOpenPopovers) &&
                          widget.subMenu != null &&
                          widget.subMenu!.isNotEmpty) {
                        if (!menuData.popoverController.hasOpenPopover &&
                            !isIndependentOverlay) {
                          openSubMenu(context);
                        }
                      } else {
                        menuGroupData.closeOthers();
                      }
                    }
                  },
                  onFocus: (value) {
                    if (value) {
                      if (widget.subMenu != null &&
                          widget.subMenu!.isNotEmpty) {
                        if (!menuData.popoverController.hasOpenPopover &&
                            !isIndependentOverlay) {
                          openSubMenu(context);
                        }
                      } else {
                        menuGroupData.closeOthers();
                      }
                    }
                  },
                  onPressed: () {
                    widget.onPressed?.call(context);
                    if (widget.subMenu != null && widget.subMenu!.isNotEmpty) {
                      if (!menuData.popoverController.hasOpenPopover) {
                        openSubMenu(context);
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
    );
  }
}

class MenuGroupData {
  final MenuGroupData? parent;
  final List<MenuData> children;
  final bool hasLeading;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;
  final Object? regionGroupId;
  final Axis direction;
  final EdgeInsets itemPadding;

  MenuGroupData(this.parent, this.children, this.hasLeading, this.subMenuOffset,
      this.onDismissed, this.regionGroupId, this.direction, this.itemPadding);

  bool get hasOpenPopovers {
    for (final child in children) {
      if (child.popoverController.hasOpenPopover) {
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

  @override
  String toString() {
    return 'MenuGroupData{parent: $parent, children: $children, hasLeading: $hasLeading, subMenuOffset: $subMenuOffset, onDismissed: $onDismissed, regionGroupId: $regionGroupId, direction: $direction}';
  }
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
  final Object? regionGroupId;
  final Axis direction;
  final Map<Type, Action> actions;
  final EdgeInsets itemPadding;

  const MenuGroup({
    super.key,
    required this.children,
    required this.builder,
    this.parent,
    this.subMenuOffset,
    this.onDismissed,
    this.regionGroupId,
    this.actions = const {},
    required this.direction,
    required this.itemPadding,
  });

  @override
  State<MenuGroup> createState() => _MenuGroupState();
}

class _MenuGroupState extends State<MenuGroup> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
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

  void closeAll() {
    MenuGroupData? data = widget.parent;
    if (data == null) {
      widget.onDismissed?.call();
      return;
    }
    data.closeOthers();
    data.closeAll();
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
        Data<MenuData>.inherit(
          data: data,
          child: child,
        ),
      );
    }
    return Shortcuts(
      shortcuts: {
        if (widget.direction == Axis.vertical)
          const SingleActivator(LogicalKeyboardKey.arrowUp):
              const PreviousFocusIntent(),
        if (widget.direction == Axis.vertical)
          const SingleActivator(LogicalKeyboardKey.arrowDown):
              const NextFocusIntent(),
        if (widget.direction == Axis.vertical)
          const SingleActivator(LogicalKeyboardKey.arrowLeft):
              const PreviousSiblingFocusIntent(),
        if (widget.direction == Axis.vertical)
          const SingleActivator(LogicalKeyboardKey.arrowRight):
              const NextSiblingFocusIntent(),
        if (widget.direction == Axis.horizontal)
          const SingleActivator(LogicalKeyboardKey.arrowLeft):
              const PreviousFocusIntent(),
        if (widget.direction == Axis.horizontal)
          const SingleActivator(LogicalKeyboardKey.arrowRight):
              const NextFocusIntent(),
        if (widget.direction == Axis.horizontal)
          const SingleActivator(LogicalKeyboardKey.arrowUp):
              const PreviousSiblingFocusIntent(),
        if (widget.direction == Axis.horizontal)
          const SingleActivator(LogicalKeyboardKey.arrowDown):
              const NextSiblingFocusIntent(),
        const SingleActivator(LogicalKeyboardKey.escape):
            const CloseMenuIntent(),
      },
      child: Actions(
        actions: {
          PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(
            onInvoke: (intent) {
              if (widget.direction == Axis.vertical) {
                _focusScopeNode.focusInDirection(TraversalDirection.up);
              } else {
                _focusScopeNode.focusInDirection(TraversalDirection.left);
              }
              return;
            },
          ),
          NextFocusIntent: CallbackAction<NextFocusIntent>(
            onInvoke: (intent) {
              if (widget.direction == Axis.vertical) {
                _focusScopeNode.focusInDirection(TraversalDirection.down);
              } else {
                _focusScopeNode.focusInDirection(TraversalDirection.right);
              }
              return;
            },
          ),
          CloseMenuIntent: CallbackAction<CloseMenuIntent>(
            onInvoke: (intent) {
              closeAll();
              return;
            },
          ),
          ...widget.actions,
        },
        child: FocusScope(
          autofocus: true,
          node: _focusScopeNode,
          child: Data.inherit(
            data: MenuGroupData(
              widget.parent,
              _data,
              hasLeading,
              widget.subMenuOffset,
              widget.onDismissed,
              widget.regionGroupId,
              widget.direction,
              widget.itemPadding,
            ),
            child: widget.builder(context, children),
          ),
        ),
      ),
    );
  }
}

class CloseMenuIntent extends Intent {
  const CloseMenuIntent();
}

class PreviousSiblingFocusIntent extends Intent {
  const PreviousSiblingFocusIntent();
}

class NextSiblingFocusIntent extends Intent {
  const NextSiblingFocusIntent();
}

class MenuOverlayHandler extends OverlayHandler {
  final OverlayManager manager;

  const MenuOverlayHandler(this.manager);

  @override
  OverlayCompleter<T?> show<T>(
      {required BuildContext context,
      required AlignmentGeometry alignment,
      required WidgetBuilder builder,
      Offset? position,
      AlignmentGeometry? anchorAlignment,
      PopoverConstraint widthConstraint = PopoverConstraint.flexible,
      PopoverConstraint heightConstraint = PopoverConstraint.flexible,
      Key? key,
      bool rootOverlay = true,
      bool modal = true,
      bool barrierDismissable = true,
      Clip clipBehavior = Clip.none,
      Object? regionGroupId,
      Offset? offset,
      Alignment? transitionAlignment,
      EdgeInsets? margin,
      bool follow = true,
      bool consumeOutsideTaps = true,
      ValueChanged<PopoverAnchorState>? onTickFollow,
      bool allowInvertHorizontal = true,
      bool allowInvertVertical = true,
      bool dismissBackdropFocus = true,
      Duration? showDuration,
      Duration? dismissDuration,
      OverlayBarrier? overlayBarrier}) {
    return manager.showMenu(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
    );
  }
}
