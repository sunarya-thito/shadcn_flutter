import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for menu components including items, groups, and submenus.
///
/// [MenuTheme] provides styling options for menu-related widgets such as
/// [MenuGroup] and [MenuButton], controlling spacing, positioning, and visual
/// presentation. Used with [ComponentTheme] to apply consistent menu styling
/// throughout an application.
///
/// Example:
/// ```dart
/// ComponentTheme<MenuTheme>(
///   data: MenuTheme(
///     itemPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
///     subMenuOffset: Offset(4, 0),
///   ),
///   child: MyMenuWidget(),
/// );
/// ```
class MenuTheme {
  /// Padding applied to individual menu items for consistent spacing.
  ///
  /// Controls the internal spacing within each menu item, affecting both
  /// text content and any icons or shortcuts. When null, uses framework
  /// default padding based on the current theme scaling.
  final EdgeInsets? itemPadding;

  /// Positional offset for submenu placement relative to parent menu items.
  ///
  /// Determines where submenus appear when triggered by hovering or clicking
  /// on parent menu items. Typically a small horizontal offset to avoid
  /// overlap. When null, uses framework default submenu positioning.
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

/// Widget for displaying keyboard shortcuts in menus with customizable appearance.
///
/// [MenuShortcut] renders keyboard shortcut combinations using visual representations
/// of individual keys, connected by a customizable combiner widget. It integrates
/// with the keyboard shortcut display system to provide consistent visual styling
/// across the application.
///
/// The widget automatically maps keyboard activators to their visual representations
/// and arranges them in a horizontal layout with separators. This is commonly used
/// in context menus, menu bars, and tooltips to show available shortcuts.
///
/// Example:
/// ```dart
/// MenuShortcut(
///   activator: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS),
///   combiner: Text(' + '), // Custom separator between keys
/// )
/// ```
class MenuShortcut extends StatelessWidget {
  /// The keyboard shortcut activator to display.
  ///
  /// Defines the key combination that triggers the associated action.
  /// Can be a single key or a combination using LogicalKeySet.
  final ShortcutActivator activator;
  
  /// Widget used to separate individual keys in the display.
  ///
  /// When null, defaults to `Text(' + ')`. Used between each key
  /// in multi-key combinations to show the relationship.
  final Widget? combiner;

  /// Creates a [MenuShortcut] with keyboard activator and optional combiner.
  ///
  /// Parameters:
  /// - [activator] (ShortcutActivator, required): The keyboard shortcut to display
  /// - [combiner] (Widget?, optional): Separator between keys (defaults to ' + ')
  ///
  /// Example:
  /// ```dart
  /// MenuShortcut(
  ///   activator: SingleActivator(LogicalKeyboardKey.enter),
  ///   combiner: Icon(Icons.add, size: 12),
  /// )
  /// ```
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

/// Abstract base class for all menu item widgets.
///
/// [MenuItem] defines the essential contract that all menu items must implement
/// to participate in menu layouts and behavior. It provides properties for
/// determining layout requirements and popover management.
///
/// Concrete implementations include [MenuButton], [MenuRadioGroup], [MenuDivider],
/// and other specialized menu components that extend this base class.
///
/// The abstract properties allow menu containers to make informed decisions
/// about layout, spacing, and interaction management across different item types.
abstract class MenuItem extends Widget {
  /// Creates a [MenuItem].
  ///
  /// Parameters:
  /// - [key] (Key?, optional): Widget identifier for efficient updates
  const MenuItem({super.key});

  /// Whether this menu item has leading content that affects layout.
  ///
  /// When true, indicates that the item has leading elements (like icons,
  /// checkboxes, or radio buttons) that require space allocation in the
  /// menu layout. Used for consistent alignment across menu items.
  bool get hasLeading;

  /// Optional popover controller for managing submenu or popup behavior.
  ///
  /// When not null, indicates that this menu item can show additional
  /// content in a popover. Used for submenus, tooltips, or other
  /// secondary content displays. Returns null for simple menu items.
  PopoverController? get popoverController;
}

/// Radio button group container for exclusive selection within menus.
///
/// [MenuRadioGroup] provides a radio button selection interface within menu
/// contexts, allowing users to choose one option from a group of mutually
/// exclusive choices. It manages selection state and provides callbacks
/// for selection changes.
///
/// The component integrates with the menu theming system and provides
/// consistent styling and behavior patterns for radio button groups
/// within menu layouts.
///
/// Example:
/// ```dart
/// MenuRadioGroup<String>(
///   value: selectedOption,
///   onChanged: (context, value) => setState(() => selectedOption = value),
///   children: [
///     MenuRadioItem(value: 'option1', child: Text('Option 1')),
///     MenuRadioItem(value: 'option2', child: Text('Option 2')),
///     MenuRadioItem(value: 'option3', child: Text('Option 3')),
///   ],
/// )
/// ```
/// A radio button group widget for menu contexts with mutual exclusion selection.
///
/// [MenuRadioGroup] manages a collection of radio button options within a menu,
/// ensuring that only one option can be selected at a time. It provides the
/// selection state and change handling logic while delegating visual representation
/// to its child widgets.
///
/// The group automatically manages selection state, ensuring mutual exclusion
/// across all radio items within the group. When one item is selected, all others
/// are automatically deselected.
///
/// Key features:
/// - **Mutual exclusion**: Only one option can be selected at a time
/// - **Type safety**: Generic type parameter ensures type consistency
/// - **Contextual callbacks**: Selection callbacks receive build context
/// - **Flexible content**: Supports radio items mixed with other menu widgets
/// - **Theme integration**: Inherits styling from parent menu components
///
/// Typically used with [MenuRadio] widgets, but can include other menu
/// elements like dividers, labels, or subgroups for complex menu hierarchies.
///
/// Example:
/// ```dart
/// MenuRadioGroup<SortOrder>(
///   value: currentSortOrder,
///   onChanged: (context, order) {
///     setState(() => currentSortOrder = order);
///   },
///   children: [
///     MenuRadio(value: SortOrder.name, child: Text('Sort by Name')),
///     MenuRadio(value: SortOrder.date, child: Text('Sort by Date')),
///     MenuDivider(),
///     MenuRadio(value: SortOrder.size, child: Text('Sort by Size')),
///   ],
/// )
/// ```
class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  /// The currently selected value within the radio group.
  ///
  /// When null, no option is selected. When set to a value, that option
  /// will be marked as selected and others will be deselected.
  final T? value;
  
  /// Callback invoked when the selection changes.
  ///
  /// Receives both the build context and the newly selected value.
  /// The context parameter provides access to theme and localization data.
  final ContextedValueChanged<T>? onChanged;
  
  /// List of radio items or other menu widgets within the group.
  ///
  /// Typically contains [MenuRadioItem] widgets, but can include
  /// other menu items like dividers or labels for organization.
  final List<Widget> children;

  /// Creates a [MenuRadioGroup] with selection state and options.
  ///
  /// Parameters:
  /// - [value] (T?, required): Currently selected value
  /// - [onChanged] (ContextedValueChanged<T>?, required): Selection change callback
  /// - [children] (List<Widget>, required): Radio items and other menu widgets
  ///
  /// Example:
  /// ```dart
  /// MenuRadioGroup<Theme>(
  ///   value: currentTheme,
  ///   onChanged: (context, theme) => _updateTheme(theme),
  ///   children: [
  ///     MenuRadioItem(value: Theme.light, child: Text('Light')),
  ///     MenuRadioItem(value: Theme.dark, child: Text('Dark')),
  ///     MenuRadioItem(value: Theme.auto, child: Text('Auto')),
  ///   ],
  /// )
  /// ```
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

/// A checkbox menu item that can be toggled between checked and unchecked states.
///
/// [MenuCheckbox] provides a standard checkbox interaction within menu contexts,
/// displaying a checkmark when selected and allowing users to toggle the state
/// through interaction. It integrates with the menu system to provide consistent
/// styling and behavior.
///
/// The checkbox automatically displays a checkmark icon when the value is true
/// and shows an empty space when false. It supports all standard menu features
/// including enabled/disabled states, trailing content, and auto-close behavior.
///
/// Key features:
/// - **Toggle interaction**: Click or keyboard activation toggles the checkbox state
/// - **Visual feedback**: Checkmark icon appears when selected
/// - **Menu integration**: Consistent styling with other menu items
/// - **Accessibility**: Full keyboard navigation and screen reader support
/// - **Contextual callbacks**: Change callbacks receive build context
///
/// Example:
/// ```dart
/// MenuCheckbox(
///   value: showLineNumbers,
///   onChanged: (context, checked) {
///     setState(() => showLineNumbers = checked);
///   },
///   child: Text('Show Line Numbers'),
///   trailing: Text('Ctrl+L'),
/// )
/// ```
class MenuCheckbox extends StatelessWidget implements MenuItem {
  /// Whether the checkbox is currently checked.
  ///
  /// When true, displays a checkmark icon. When false, shows empty space.
  final bool value;
  
  /// Callback invoked when the checkbox state changes.
  ///
  /// Receives the build context and the new boolean state. If null,
  /// the checkbox is read-only and cannot be toggled by user interaction.
  final ContextedValueChanged<bool>? onChanged;
  
  /// The primary content displayed for the checkbox menu item.
  ///
  /// Typically a [Text] widget describing the option, but can be any
  /// widget including icons, rich text, or complex layouts.
  final Widget child;
  
  /// Optional widget displayed at the trailing edge of the checkbox item.
  ///
  /// Commonly used for keyboard shortcuts, additional info, or secondary
  /// actions. Positioned at the right side of the menu item.
  final Widget? trailing;
  
  /// Whether the checkbox can be interacted with.
  ///
  /// When false, the checkbox appears dimmed and does not respond to
  /// user interaction. The [onChanged] callback will not be invoked.
  final bool enabled;
  
  /// Whether the menu should automatically close when the checkbox is toggled.
  ///
  /// When true, selecting the checkbox closes the containing menu. When false,
  /// the menu remains open for additional selections.
  final bool autoClose;

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

class MenuGroupData {
  final MenuGroupData? parent;
  final List<MenuData> children;
  final bool hasLeading;
  final Offset? subMenuOffset;
  final VoidCallback? onDismissed;
  final Object? regionGroupId;
  final Axis direction;
  final EdgeInsets itemPadding;
  final SubFocusScopeState focusScope;

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
  final EdgeInsets? itemPadding;
  final bool autofocus;
  final FocusNode? focusNode;

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

class CloseMenuIntent extends Intent {
  const CloseMenuIntent();
}

class OpenSubMenuIntent extends Intent {
  const OpenSubMenuIntent();
}

class NextMenuFocusIntent extends Intent {
  final bool forward;

  const NextMenuFocusIntent(this.forward);
}

class MenuOverlayHandler extends OverlayHandler {
  final OverlayManager manager;

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

class DirectionalMenuFocusIntent extends Intent {
  final TraversalDirection direction;

  const DirectionalMenuFocusIntent(this.direction);
}
