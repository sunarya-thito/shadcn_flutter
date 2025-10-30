import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template menu_theme}
/// Styling options for menu widgets such as [MenuGroup] and [MenuButton].
/// {@endtemplate}
class MenuTheme {
  /// Default padding applied to each menu item.
  final EdgeInsets? itemPadding;

  /// Offset applied when showing a submenu.
  final Offset? subMenuOffset;

  /// {@macro menu_theme}
  const MenuTheme({
    this.itemPadding,
    this.subMenuOffset,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  MenuTheme copyWith({
    ValueGetter<EdgeInsets?>? itemPadding,
    ValueGetter<Offset?>? subMenuOffset,
  }) {
    return MenuTheme(
      itemPadding: itemPadding == null ? this.itemPadding : itemPadding(),
      subMenuOffset:
          subMenuOffset == null ? this.subMenuOffset : subMenuOffset(),
    );
  }

  @override
  int get hashCode => Object.hash(itemPadding, subMenuOffset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuTheme &&
        other.itemPadding == itemPadding &&
        other.subMenuOffset == subMenuOffset;
  }

  @override
  String toString() {
    return 'MenuTheme(itemPadding: $itemPadding, subMenuOffset: $subMenuOffset)';
  }
}

/// Displays a keyboard shortcut in a menu.
///
/// Renders the visual representation of a keyboard shortcut, typically
/// displayed on the right side of menu items.
///
/// Example:
/// ```dart
/// MenuShortcut(
///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
/// )
/// ```
class MenuShortcut extends StatelessWidget {
  /// The keyboard shortcut to display.
  final ShortcutActivator activator;

  /// Widget to display between multiple keys.
  final Widget? combiner;

  /// Creates a [MenuShortcut].
  ///
  /// Parameters:
  /// - [activator] (`ShortcutActivator`, required): The shortcut to display.
  /// - [combiner] (`Widget?`, optional): Separator between keys (default: " + ").
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

/// Abstract base class for menu item widgets.
///
/// All menu items (buttons, checkboxes, radio buttons, dividers, etc.) must
/// implement this interface. Menu items can be placed within menu groups and
/// support features like leading icons and popover controllers.
///
/// See also:
/// - [MenuButton], clickable menu item
/// - [MenuCheckbox], checkbox menu item
/// - [MenuRadio], radio button menu item
/// - [MenuDivider], divider between menu items
abstract class MenuItem extends Widget {
  /// Creates a menu item.
  const MenuItem({super.key});

  /// Whether this menu item has a leading widget (icon, checkbox indicator, etc.).
  bool get hasLeading;

  /// Optional popover controller for submenu functionality.
  PopoverController? get popoverController;
}

/// Radio button group container for menu items.
///
/// Groups multiple [MenuRadio] items together with shared selection state.
/// Only one radio button in the group can be selected at a time.
///
/// Example:
/// ```dart
/// MenuRadioGroup<String>(
///   value: selectedOption,
///   onChanged: (context, value) => setState(() => selectedOption = value),
///   children: [
///     MenuRadio(value: 'option1', child: Text('Option 1')),
///     MenuRadio(value: 'option2', child: Text('Option 2')),
///   ],
/// )
/// ```
class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  /// Currently selected value.
  final T? value;

  /// Callback when selection changes.
  final ContextedValueChanged<T>? onChanged;

  /// List of [MenuRadio] children.
  final List<Widget> children;

  /// Creates a radio group for menu items.
  ///
  /// Parameters:
  /// - [value] (T?): Currently selected value
  /// - [onChanged] (`ContextedValueChanged<T>?`): Selection change callback
  /// - [children] (`List<Widget>`): Radio button children
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

/// Individual radio button item within a [MenuRadioGroup].
///
/// Displays a radio button indicator when selected and integrates with
/// the parent radio group for selection management.
class MenuRadio<T> extends StatelessWidget {
  /// The value this radio button represents.
  final T value;

  /// Content widget displayed for this option.
  final Widget child;

  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this radio button is enabled.
  final bool enabled;

  /// Whether selecting this radio closes the menu automatically.
  final bool autoClose;

  /// Creates a radio button menu item.
  ///
  /// Must be a child of [MenuRadioGroup].
  ///
  /// Parameters:
  /// - [value] (T, required): Value for this option
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [focusNode] (FocusNode?): Focus node for navigation
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
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

/// Visual divider between menu items.
///
/// Renders a horizontal or vertical line to separate groups of menu items.
/// Automatically adapts direction based on the parent menu's orientation.
///
/// Example:
/// ```dart
/// MenuGroup(
///   children: [
///     MenuButton(child: Text('Cut')),
///     MenuButton(child: Text('Copy')),
///     MenuDivider(), // Separator
///     MenuButton(child: Text('Paste')),
///   ],
/// )
/// ```
class MenuDivider extends StatelessWidget implements MenuItem {
  /// Creates a menu divider.
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

/// Spacing gap between menu items.
///
/// Creates empty vertical or horizontal space within a menu, based on
/// the menu's direction. Useful for visually grouping related items.
class MenuGap extends StatelessWidget implements MenuItem {
  /// Size of the gap in logical pixels.
  final double size;

  /// Creates a menu gap.
  ///
  /// Parameters:
  /// - [size] (double, required): Gap size in logical pixels
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

/// Clickable button menu item with optional submenu support.
///
/// Primary menu item type that responds to user interaction. Can display
/// leading icons, trailing widgets (shortcuts), and nested submenus.
///
/// Example:
/// ```dart
/// MenuButton(
///   leading: Icon(Icons.cut),
///   trailing: Text('Ctrl+X').textSmall().muted(),
///   onPressed: (context) => _handleCut(),
///   child: Text('Cut'),
/// )
/// ```
class MenuButton extends StatefulWidget implements MenuItem {
  /// Content widget displayed in the button.
  final Widget child;

  /// Optional submenu items shown on hover or click.
  final List<MenuItem>? subMenu;

  /// Callback when button is pressed.
  final ContextedCallback? onPressed;

  /// Optional trailing widget (e.g., keyboard shortcut indicator).
  final Widget? trailing;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Whether the button is enabled for interaction.
  final bool enabled;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether selecting this button closes the menu automatically.
  final bool autoClose;

  @override
  final PopoverController? popoverController;

  /// Creates a menu button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [subMenu] (`List<MenuItem>?`): Optional nested submenu
  /// - [onPressed] (ContextedCallback?): Click handler
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [focusNode] (FocusNode?): Focus node
  /// - [autoClose] (bool): Auto-close behavior, defaults to true
  /// - [popoverController] (PopoverController?): Optional popover controller
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

/// Non-interactive label menu item.
///
/// Displays text or content without click handlers. Useful for section
/// headers or informational text within menus.
///
/// Example:
/// ```dart
/// MenuLabel(
///   leading: Icon(Icons.settings),
///   child: Text('Settings').semiBold(),
/// )
/// ```
class MenuLabel extends StatelessWidget implements MenuItem {
  /// Content widget displayed in the label.
  final Widget child;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Creates a menu label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
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
        content: child.semiBold(),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: menuGroupData.direction == Axis.vertical
            ? AlignmentDirectional.centerStart
            : Alignment.center,
      ),
    );
  }
}

/// Checkbox menu item with checked/unchecked state.
///
/// Displays a checkmark when selected. Used for togglable menu options.
///
/// Example:
/// ```dart
/// MenuCheckbox(
///   value: showToolbar,
///   onChanged: (context, value) => setState(() => showToolbar = value),
///   child: Text('Show Toolbar'),
/// )
/// ```
class MenuCheckbox extends StatelessWidget implements MenuItem {
  /// Current checked state.
  final bool value;

  /// Callback when checkbox state changes.
  final ContextedValueChanged<bool>? onChanged;

  /// Content widget displayed for this option.
  final Widget child;

  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;

  /// Whether this checkbox is enabled.
  final bool enabled;

  /// Whether checking this box closes the menu automatically.
  final bool autoClose;

  /// Creates a checkbox menu item.
  ///
  /// Parameters:
  /// - [value] (bool): Current checked state, defaults to false
  /// - [onChanged] (`ContextedValueChanged<bool>?`): State change callback
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
  const MenuCheckbox({
    super.key,
    this.value = false,
    this.onChanged,
    required this.child,
    this.trailing,
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
      autoClose: autoClose,
      trailing: trailing,
      child: child,
    );
  }
}

class _MenuButtonState extends State<MenuButton> {
  final ValueNotifier<List<MenuItem>> _children = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _children.value = widget.subMenu ?? [];
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<MenuTheme>(context);
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = DialogOverlayHandler.isDialogOverlay(context);
    final isIndependentOverlay = isSheetOverlay || isDialogOverlay;
    void openSubMenu(BuildContext context, bool autofocus) {
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
                      subMenuOffset: compTheme?.subMenuOffset ??
                          const Offset(8, -4 + -1) * scaling,
                      itemPadding: itemPadding,
                      autofocus: autofocus,
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
        offset: menuGroupData.subMenuOffset ?? compTheme?.subMenuOffset,
      );
    }

    return Actions(
      actions: {
        OpenSubMenuIntent: ContextCallbackAction<OpenSubMenuIntent>(
          onInvoke: (intent, [context]) {
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(this.context, true);
              return true;
            }
            return false;
          },
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            widget.onPressed?.call(context);
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(context, true);
            }
            if (widget.autoClose) {
              menuGroupData!.closeAll();
            }
            return;
          },
        ),
      },
      child: SubFocus(
          enabled: widget.enabled,
          builder: (context, subFocusState) {
            bool hasFocus = subFocusState.isFocused && menuBarData == null;
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
                                color:
                                    menuData.popoverController.hasOpenPopover ||
                                            hasFocus
                                        ? theme.colorScheme.accent
                                        : null,
                                borderRadius:
                                    BorderRadius.circular(theme.radiusMd),
                              );
                            },
                          ),
                          trailing: menuBarData != null
                              ? widget.trailing
                              : widget.trailing != null ||
                                      (widget.subMenu != null &&
                                          menuBarData == null)
                                  ? Row(
                                      children: [
                                        if (widget.trailing != null)
                                          widget.trailing!,
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
                          focusNode: widget.focusNode,
                          onHover: (value) {
                            if (value) {
                              subFocusState.requestFocus();
                              if ((menuBarData == null ||
                                      menuGroupData.hasOpenPopovers) &&
                                  widget.subMenu != null &&
                                  widget.subMenu!.isNotEmpty) {
                                if (!menuData
                                        .popoverController.hasOpenPopover &&
                                    !isIndependentOverlay) {
                                  openSubMenu(context, false);
                                }
                              } else {
                                menuGroupData.closeOthers();
                              }
                            } else {
                              subFocusState.unfocus();
                            }
                          },
                          onPressed: () {
                            widget.onPressed?.call(context);
                            if (widget.subMenu != null &&
                                widget.subMenu!.isNotEmpty) {
                              if (!menuData.popoverController.hasOpenPopover) {
                                openSubMenu(context, false);
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
          }),
    );
  }
}

/// Data class containing menu group state and configuration.
///
/// Manages the hierarchical structure of menu groups, tracking parent-child
/// relationships, popover state, and layout properties. Used internally by
/// the menu system to coordinate behavior across nested menus.
class MenuGroupData {
  /// Parent menu group, null for root menus.
  final MenuGroupData? parent;

  /// Child menu items' data.
  final List<MenuData> children;

  /// Whether any child items have leading widgets.
  final bool hasLeading;

  /// Offset for positioning submenus relative to parent.
  final Offset? subMenuOffset;

  /// Callback when menu is dismissed.
  final VoidCallback? onDismissed;

  /// Region group ID for tap region management.
  final Object? regionGroupId;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Padding around menu items.
  final EdgeInsets itemPadding;

  /// Focus scope state for keyboard navigation.
  final SubFocusScopeState focusScope;

  /// Creates menu group data.
  ///
  /// Parameters:
  /// - [parent] (MenuGroupData?): Parent group
  /// - [children] (`List<MenuData>`): Child items
  /// - [hasLeading] (bool): Whether items have leading widgets
  /// - [subMenuOffset] (Offset?): Submenu offset
  /// - [onDismissed] (VoidCallback?): Dismissal callback
  /// - [regionGroupId] (Object?): Region group ID
  /// - [direction] (Axis): Layout direction
  /// - [itemPadding] (EdgeInsets): Item padding
  /// - [focusScope] (SubFocusScopeState): Focus scope
  MenuGroupData(
    this.parent,
    this.children,
    this.hasLeading,
    this.subMenuOffset,
    this.onDismissed,
    this.regionGroupId,
    this.direction,
    this.itemPadding,
    this.focusScope,
  );

  /// Checks if any child menu items have open popovers.
  ///
  /// Returns true if at least one child has an open submenu popover.
  bool get hasOpenPopovers {
    for (final child in children) {
      if (child.popoverController.hasOpenPopover) {
        return true;
      }
    }
    return false;
  }

  /// Closes all open popovers in child menu items.
  ///
  /// Iterates through children and closes any open submenu popovers.
  void closeOthers() {
    for (final child in children) {
      child.popoverController.close();
    }
  }

  /// Closes all menus in the hierarchy by bubbling up to root.
  ///
  /// Recursively closes popovers in parent groups and invokes the
  /// dismissal callback at the root level.
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

  /// Gets the root menu group in the hierarchy.
  ///
  /// Traverses up the parent chain to find the topmost menu group.
  ///
  /// Returns the root [MenuGroupData].
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

/// Data container for individual menu item state.
///
/// Wraps a popover controller for each menu item, managing submenu
/// display and interaction state.
class MenuData {
  /// Controller for this item's submenu popover.
  final PopoverController popoverController;

  /// Creates menu item data.
  ///
  /// Parameters:
  /// - [popoverController] (PopoverController?): Optional controller, creates default if null
  MenuData({PopoverController? popoverController})
      : popoverController = popoverController ?? PopoverController();
}

/// Container widget for organizing menu items into a group.
///
/// Provides layout, focus management, and keyboard navigation for a collection
/// of menu items. Supports both horizontal and vertical orientations, nested
/// submenus, and customizable actions.
///
/// Example:
/// ```dart
/// MenuGroup(
///   direction: Axis.vertical,
///   builder: (context, children) => Column(children: children),
///   children: [
///     MenuButton(child: Text('Cut')),
///     MenuButton(child: Text('Copy')),
///     MenuDivider(),
///     MenuButton(child: Text('Paste')),
///   ],
/// )
/// ```
class MenuGroup extends StatefulWidget {
  /// List of menu item widgets.
  final List<MenuItem> children;

  /// Builder function that layouts the menu items.
  final Widget Function(BuildContext context, List<Widget> children) builder;

  /// Parent menu group for nested submenus.
  final MenuGroupData? parent;

  /// Offset for positioning submenus.
  final Offset? subMenuOffset;

  /// Callback when menu is dismissed.
  final VoidCallback? onDismissed;

  /// Region group ID for tap region management.
  final Object? regionGroupId;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Custom keyboard actions.
  final Map<Type, Action> actions;

  /// Padding around menu items.
  final EdgeInsets? itemPadding;

  /// Whether to autofocus on mount.
  final bool autofocus;

  /// Optional focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Creates a menu group.
  ///
  /// Parameters:
  /// - [children] (`List<MenuItem>`, required): Menu items
  /// - [builder] (Function, required): Layout builder
  /// - [direction] (Axis, required): Layout direction
  /// - [parent] (MenuGroupData?): Parent group for nesting
  /// - [subMenuOffset] (Offset?): Submenu positioning offset
  /// - [onDismissed] (VoidCallback?): Dismissal callback
  /// - [regionGroupId] (Object?): Tap region group ID
  /// - [actions] (`Map<Type, Action>`): Custom actions, defaults to empty
  /// - [itemPadding] (EdgeInsets?): Item padding
  /// - [autofocus] (bool): Auto-focus behavior, defaults to true
  /// - [focusNode] (FocusNode?): Focus node
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
    this.itemPadding,
    this.autofocus = true,
    this.focusNode,
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
    final parentGroupData = Data.maybeOf<MenuGroupData>(context);
    final menubarData = Data.maybeOf<MenubarState>(context);
    final compTheme = ComponentTheme.maybeOf<MenuTheme>(context);
    final itemPadding =
        widget.itemPadding ?? compTheme?.itemPadding ?? EdgeInsets.zero;
    final subMenuOffset = widget.subMenuOffset ?? compTheme?.subMenuOffset;
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
    final direction = Directionality.of(context);
    return SubFocusScope(
        autofocus: widget.autofocus,
        builder: (context, scope) {
          return Actions(
            actions: {
              NextMenuFocusIntent: CallbackAction<NextMenuFocusIntent>(
                onInvoke: (intent) {
                  scope.nextFocus(intent.forward
                      ? widget.direction == Axis.horizontal
                          ? TraversalDirection.left
                          : TraversalDirection.up
                      : widget.direction == Axis.horizontal
                          ? TraversalDirection.right
                          : TraversalDirection.down);
                  return;
                },
              ),
              DirectionalMenuFocusIntent:
                  CallbackAction<DirectionalMenuFocusIntent>(
                onInvoke: (intent) {
                  if (widget.direction == Axis.vertical) {
                    if (intent.direction == TraversalDirection.left) {
                      if (direction == TextDirection.ltr) {
                        for (final menu in parentGroupData?.children ?? []) {
                          menu.popoverController.close();
                        }
                        return;
                      } else {}
                    } else if (intent.direction == TraversalDirection.right) {
                      if (direction == TextDirection.ltr) {
                        bool? result = scope.invokeActionOnFocused(
                            const OpenSubMenuIntent()) as bool?;
                        if (result != true) {
                          parentGroupData?.root.focusScope
                              .nextFocus(TraversalDirection.right);
                        }
                        return;
                      } else {}
                    }
                  }
                  if (!scope.nextFocus(intent.direction)) {
                    for (final menu in parentGroupData?.children ?? []) {
                      menu.popoverController.close();
                    }
                    parentGroupData?.focusScope.nextFocus(
                      intent.direction,
                    );
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
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (intent) {
                  scope.invokeActionOnFocused(const ActivateIntent());
                  return;
                },
              ),
              ...widget.actions,
            },
            child: Shortcuts(
              shortcuts: {
                const SingleActivator(LogicalKeyboardKey.arrowUp):
                    const DirectionalMenuFocusIntent(TraversalDirection.up),
                const SingleActivator(LogicalKeyboardKey.arrowDown):
                    const DirectionalMenuFocusIntent(TraversalDirection.down),
                const SingleActivator(LogicalKeyboardKey.arrowLeft):
                    const DirectionalMenuFocusIntent(TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.arrowRight):
                    const DirectionalMenuFocusIntent(TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab):
                    DirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.down
                        : TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab, shift: true):
                    DirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.up
                        : TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.escape):
                    const CloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.enter):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.space):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.backspace):
                    const CloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.numpadEnter):
                    const ActivateIntent(),
              },
              child: Focus(
                autofocus: menubarData == null,
                focusNode: widget.focusNode,
                child: Data.inherit(
                  data: MenuGroupData(
                    widget.parent,
                    _data,
                    hasLeading,
                    subMenuOffset,
                    widget.onDismissed,
                    widget.regionGroupId,
                    widget.direction,
                    itemPadding,
                    scope,
                  ),
                  child: Builder(builder: (context) {
                    return widget.builder(context, children);
                  }),
                ),
              ),
            ),
          );
        });
  }
}

/// Intent for closing the current menu via keyboard action.
///
/// Used with keyboard shortcuts to dismiss open menus.
class CloseMenuIntent extends Intent {
  /// Creates a close menu intent.
  const CloseMenuIntent();
}

/// Intent for opening a submenu via keyboard action.
///
/// Triggers submenu expansion when navigating with keyboard.
class OpenSubMenuIntent extends Intent {
  /// Creates an open submenu intent.
  const OpenSubMenuIntent();
}

/// Intent for moving focus to next/previous menu item.
///
/// Used for keyboard navigation within menus (Tab/Shift+Tab).
class NextMenuFocusIntent extends Intent {
  /// Whether to move focus forward (true) or backward (false).
  final bool forward;

  /// Creates a next menu focus intent.
  ///
  /// Parameters:
  /// - [forward] (bool, required): Direction of focus movement
  const NextMenuFocusIntent(this.forward);
}

/// Overlay handler specialized for menu popover display.
///
/// Delegates to an [OverlayManager] to show menu popovers with
/// appropriate positioning, transitions, and dismissal behavior.
class MenuOverlayHandler extends OverlayHandler {
  /// The overlay manager handling menu display.
  final OverlayManager manager;

  /// Creates a menu overlay handler.
  ///
  /// Parameters:
  /// - [manager] (OverlayManager, required): Overlay manager for menu display
  const MenuOverlayHandler(this.manager);

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
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
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
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
      layerLink: layerLink,
    );
  }
}

/// Intent for directional focus traversal within menus.
///
/// Used for arrow key navigation (up, down, left, right) within menu structures.
class DirectionalMenuFocusIntent extends Intent {
  /// Direction of focus traversal.
  final TraversalDirection direction;

  /// Creates a directional menu focus intent.
  ///
  /// Parameters:
  /// - [direction] (TraversalDirection, required): Traversal direction
  const DirectionalMenuFocusIntent(this.direction);
}
