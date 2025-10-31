import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [ContextMenuPopup] and context menu widgets.
class ContextMenuTheme {
  /// Surface opacity for the popup container.
  final double? surfaceOpacity;

  /// Surface blur for the popup container.
  final double? surfaceBlur;

  /// Creates a [ContextMenuTheme].
  const ContextMenuTheme({this.surfaceOpacity, this.surfaceBlur});

  /// Returns a copy of this theme with the given fields replaced.
  ContextMenuTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
  }) {
    return ContextMenuTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContextMenuTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(surfaceOpacity, surfaceBlur);
}

/// Context menu for editable text fields on desktop platforms.
///
/// Provides standard text editing actions like cut, copy, paste, select all,
/// and undo/redo. Automatically integrates with EditableText state.
///
/// Typically used internally by text input widgets.
class DesktopEditableTextContextMenu extends StatelessWidget {
  /// Build context for positioning the menu.
  final BuildContext anchorContext;

  /// State of the editable text field.
  final EditableTextState editableTextState;

  /// Optional controller for undo/redo functionality.
  final UndoHistoryController? undoHistoryController;

  /// Creates a [DesktopEditableTextContextMenu].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [editableTextState] (`EditableTextState`, required): Text field state.
  /// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
  const DesktopEditableTextContextMenu({
    super.key,
    required this.anchorContext,
    required this.editableTextState,
    this.undoHistoryController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final localizations = ShadcnLocalizations.of(context);
    var undoHistoryController = this.undoHistoryController;
    var contextMenuButtonItems =
        List.of(editableTextState.contextMenuButtonItems);

    ContextMenuButtonItem? take(ContextMenuButtonType type) {
      var item = contextMenuButtonItems
          .where((element) => element.type == type)
          .firstOrNull;
      if (item != null) {
        contextMenuButtonItems.remove(item);
      }
      return item;
    }

    var cutButton = take(ContextMenuButtonType.cut);
    var copyButton = take(ContextMenuButtonType.copy);
    var pasteButton = take(ContextMenuButtonType.paste);
    var selectAllButton = take(ContextMenuButtonType.selectAll);
    var shareButton = take(ContextMenuButtonType.share);
    var searchWebButton = take(ContextMenuButtonType.searchWeb);
    var liveTextInput = take(ContextMenuButtonType.liveTextInput);
    var cutButtonWidget = MenuButton(
      enabled: cutButton != null,
      onPressed: (context) {
        cutButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(
          LogicalKeyboardKey.keyX,
          control: true,
        ),
      ),
      child: Text(localizations.menuCut),
    );
    var copyButtonWidget = MenuButton(
      enabled: copyButton != null,
      onPressed: (context) {
        copyButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(
          LogicalKeyboardKey.keyC,
          control: true,
        ),
      ),
      child: Text(localizations.menuCopy),
    );
    var pasteButtonWidget = MenuButton(
      enabled: pasteButton != null,
      onPressed: (context) {
        pasteButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(
          LogicalKeyboardKey.keyV,
          control: true,
        ),
      ),
      child: Text(localizations.menuPaste),
    );
    var selectAllButtonWidget = MenuButton(
      enabled: selectAllButton != null,
      onPressed: (context) {
        // somehow, we lost focus upon context menu open
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          selectAllButton?.onPressed?.call();
        });
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(
          LogicalKeyboardKey.keyA,
          control: true,
        ),
      ),
      child: Text(localizations.menuSelectAll),
    );
    List<MenuItem> extras = [];
    if (shareButton != null) {
      extras.add(MenuButton(
        onPressed: (context) {
          shareButton.onPressed?.call();
        },
        child: Text(localizations.menuShare),
      ));
    }
    if (searchWebButton != null) {
      extras.add(MenuButton(
        onPressed: (context) {
          searchWebButton.onPressed?.call();
        },
        child: Text(localizations.menuSearchWeb),
      ));
    }
    if (liveTextInput != null) {
      extras.add(MenuButton(
        onPressed: (context) {
          liveTextInput.onPressed?.call();
        },
        child: Text(localizations.menuLiveTextInput),
      ));
    }
    if (undoHistoryController == null) {
      return TextFieldTapRegion(
        child: ShadcnUI(
          child: ContextMenuPopup(
            anchorSize: Size.zero,
            anchorContext: anchorContext,
            position: editableTextState.contextMenuAnchors.primaryAnchor +
                const Offset(8, -8) * scaling,
            children: [
              cutButtonWidget,
              copyButtonWidget,
              pasteButtonWidget,
              selectAllButtonWidget,
              if (extras.isNotEmpty) const MenuDivider(),
              ...extras,
            ],
          ),
        ),
      );
    }
    return TextFieldTapRegion(
      child: ShadcnUI(
        child: AnimatedBuilder(
            animation: undoHistoryController,
            builder: (context, child) {
              return ContextMenuPopup(
                anchorContext: anchorContext,
                position: editableTextState.contextMenuAnchors.primaryAnchor +
                    const Offset(8, -8) * scaling,
                children: [
                  MenuButton(
                    enabled: undoHistoryController.value.canUndo,
                    onPressed: (context) {
                      undoHistoryController.undo();
                    },
                    trailing: const MenuShortcut(
                      activator: SingleActivator(
                        LogicalKeyboardKey.keyZ,
                        control: true,
                      ),
                    ),
                    child: const Text('Undo'),
                  ),
                  MenuButton(
                    enabled: undoHistoryController.value.canRedo,
                    onPressed: (context) {
                      undoHistoryController.redo();
                    },
                    trailing: const MenuShortcut(
                      activator: SingleActivator(
                        LogicalKeyboardKey.keyZ,
                        control: true,
                        shift: true,
                      ),
                    ),
                    child: const Text('Redo'),
                  ),
                  const MenuDivider(),
                  cutButtonWidget,
                  copyButtonWidget,
                  pasteButtonWidget,
                  selectAllButtonWidget,
                  if (extras.isNotEmpty) const MenuDivider(),
                  ...extras,
                ],
              );
            }),
      ),
    );
  }
}

/// Context menu for editable text fields on mobile platforms.
///
/// Similar to [DesktopEditableTextContextMenu] but optimized for mobile
/// with horizontal layout and no keyboard shortcuts displayed.
///
/// Typically used internally by text input widgets on mobile platforms.
class MobileEditableTextContextMenu extends StatelessWidget {
  /// Build context for positioning the menu.
  final BuildContext anchorContext;

  /// State of the editable text field.
  final EditableTextState editableTextState;

  /// Optional controller for undo/redo functionality.
  final UndoHistoryController? undoHistoryController;

  /// Creates a [MobileEditableTextContextMenu].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [editableTextState] (`EditableTextState`, required): Text field state.
  /// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
  const MobileEditableTextContextMenu({
    super.key,
    required this.anchorContext,
    required this.editableTextState,
    this.undoHistoryController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final localizations = ShadcnLocalizations.of(context);
    var undoHistoryController = this.undoHistoryController;
    var contextMenuButtonItems =
        List.of(editableTextState.contextMenuButtonItems);

    ContextMenuButtonItem? take(ContextMenuButtonType type) {
      var item = contextMenuButtonItems
          .where((element) => element.type == type)
          .firstOrNull;
      if (item != null) {
        contextMenuButtonItems.remove(item);
      }
      return item;
    }

    var deleteButton = take(ContextMenuButtonType.delete);
    var cutButton = take(ContextMenuButtonType.cut);
    var copyButton = take(ContextMenuButtonType.copy);
    var pasteButton = take(ContextMenuButtonType.paste);
    var selectAllButton = take(ContextMenuButtonType.selectAll);
    var shareButton = take(ContextMenuButtonType.share);
    var searchWebButton = take(ContextMenuButtonType.searchWeb);
    var liveTextInput = take(ContextMenuButtonType.liveTextInput);

    List<MenuItem> modificationCategory = [];
    if (cutButton != null) {
      modificationCategory.add(MenuButton(
        onPressed: (context) {
          cutButton.onPressed?.call();
        },
        child: Text(localizations.menuCut),
      ));
    }
    if (copyButton != null) {
      modificationCategory.add(MenuButton(
        onPressed: (context) {
          copyButton.onPressed?.call();
        },
        child: Text(localizations.menuCopy),
      ));
    }
    if (pasteButton != null) {
      modificationCategory.add(MenuButton(
        onPressed: (context) {
          pasteButton.onPressed?.call();
        },
        child: Text(localizations.menuPaste),
      ));
    }
    if (selectAllButton != null) {
      modificationCategory.add(MenuButton(
        onPressed: (context) {
          selectAllButton.onPressed?.call();
        },
        child: Text(localizations.menuSelectAll),
      ));
    }

    List<MenuItem> destructiveCategory = [];
    if (deleteButton != null) {
      destructiveCategory.add(MenuButton(
        onPressed: (context) {
          deleteButton.onPressed?.call();
        },
        child: Text(localizations.menuDelete),
      ));
    }

    if (shareButton != null) {
      destructiveCategory.add(MenuButton(
        onPressed: (context) {
          shareButton.onPressed?.call();
        },
        child: Text(localizations.menuShare),
      ));
    }

    if (searchWebButton != null) {
      destructiveCategory.add(MenuButton(
        onPressed: (context) {
          searchWebButton.onPressed?.call();
        },
        child: Text(localizations.menuSearchWeb),
      ));
    }

    if (liveTextInput != null) {
      destructiveCategory.add(MenuButton(
        onPressed: (context) {
          liveTextInput.onPressed?.call();
        },
        child: Text(localizations.menuLiveTextInput),
      ));
    }

    var primaryAnchor = (editableTextState.contextMenuAnchors.secondaryAnchor ??
            editableTextState.contextMenuAnchors.primaryAnchor) +
        const Offset(-8, 8) * scaling;
    if (undoHistoryController == null) {
      List<List<MenuItem>> categories = [
        if (modificationCategory.isNotEmpty) modificationCategory,
        if (destructiveCategory.isNotEmpty) destructiveCategory,
      ];
      return TextFieldTapRegion(
        child: ShadcnUI(
          child: ContextMenuPopup(
            anchorSize: Size.zero,
            anchorContext: anchorContext,
            position: primaryAnchor,
            direction: Axis.horizontal,
            children: categories
                .expand((element) => [
                      ...element,
                    ])
                .toList()
                .joinSeparator(const MenuDivider()),
          ),
        ),
      );
    }

    return TextFieldTapRegion(
      child: ShadcnUI(
        child: AnimatedBuilder(
            animation: undoHistoryController,
            builder: (context, child) {
              List<MenuItem> historyCategory = [];
              if (undoHistoryController.value.canUndo) {
                historyCategory.add(MenuButton(
                  enabled: undoHistoryController.value.canUndo,
                  onPressed: (context) {
                    undoHistoryController.undo();
                  },
                  child: Text(localizations.menuUndo),
                ));
              }
              if (undoHistoryController.value.canRedo) {
                historyCategory.add(MenuButton(
                  enabled: undoHistoryController.value.canRedo,
                  onPressed: (context) {
                    undoHistoryController.redo();
                  },
                  child: Text(localizations.menuRedo),
                ));
              }
              List<List<MenuItem>> categories = [
                if (historyCategory.isNotEmpty) historyCategory,
                if (modificationCategory.isNotEmpty) modificationCategory,
                if (destructiveCategory.isNotEmpty) destructiveCategory,
              ];

              return ContextMenuPopup(
                direction: Axis.horizontal,
                anchorContext: anchorContext,
                position: primaryAnchor,
                anchorSize: Size.zero,
                children: categories
                    .expand((element) => [
                          ...element,
                        ])
                    .toList()
                    .joinSeparator(const MenuDivider()),
              );
            }),
      ),
    );
  }
}

/// Builds an appropriate context menu for editable text based on platform.
///
/// Automatically selects between desktop and mobile context menu implementations
/// based on the current platform.
///
/// Parameters:
/// - [innerContext] (`BuildContext`, required): Build context.
/// - [editableTextState] (`EditableTextState`, required): Text field state.
/// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
/// - [platform] (`TargetPlatform?`, optional): Override platform detection.
///
/// Note: If [platform] is not provided, it will be inferred from the theme, and
/// on web, it may be treated as mobile on small screens (width < height * 0.8).
///
/// Returns: Platform-appropriate context menu widget.
Widget buildEditableTextContextMenu(
    BuildContext innerContext, EditableTextState editableTextState,
    {UndoHistoryController? undoHistoryController, TargetPlatform? platform}) {
  if (platform == null) {
    // First we check if the user specified a platform via the theme.
    // When set, this one is favored.
    platform ??= Theme.of(innerContext).specifiedPlatform;

    // If the user did not specify a platform, we do some heuristics for web.
    // On web, we may treat it as mobile on small screens.
    if (kIsWeb && platform == null) {
      final size = MediaQuery.of(innerContext).size;
      // that is, if the width is significantly smaller than height
      if (size.width < size.height * 0.8) {
        // Treat as mobile on small web screens
        platform = TargetPlatform.iOS;
      }
    }

    // Finally, if still null, fall back to default platform.
    platform ??= defaultTargetPlatform;
  }

  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return MobileEditableTextContextMenu(
        anchorContext: innerContext,
        editableTextState: editableTextState,
        undoHistoryController: undoHistoryController,
      );
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    case TargetPlatform.linux:
    case TargetPlatform.fuchsia:
      return DesktopEditableTextContextMenu(
        anchorContext: innerContext,
        editableTextState: editableTextState,
        undoHistoryController: undoHistoryController,
      );
    // flutter forks might have some additional platforms
    // (e.g. flutter ohos has ohos platforms in TargetPlatform enum)
    // ignore: unreachable_switch_default
    default:
      return DesktopEditableTextContextMenu(
        anchorContext: innerContext,
        editableTextState: editableTextState,
        undoHistoryController: undoHistoryController,
      );
  }
}

/// A widget that shows a context menu when right-clicked or long-pressed.
///
/// Wraps a child widget and displays a customizable menu on context menu triggers.
///
/// Example:
/// ```dart
/// ContextMenu(
///   items: [
///     MenuButton(onPressed: (_) => print('Edit'), child: Text('Edit')),
///     MenuButton(onPressed: (_) => print('Delete'), child: Text('Delete')),
///   ],
///   child: Container(child: Text('Right-click me')),
/// )
/// ```
class ContextMenu extends StatefulWidget {
  /// The child widget that triggers the context menu.
  final Widget child;

  /// Menu items to display in the context menu.
  final List<MenuItem> items;

  /// How hit testing behaves for the child.
  final HitTestBehavior behavior;

  /// Direction to lay out menu items.
  final Axis direction;

  /// Whether the context menu is enabled.
  final bool enabled;

  /// Creates a [ContextMenu].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers menu.
  /// - [items] (`List<MenuItem>`, required): Menu items.
  /// - [behavior] (`HitTestBehavior`, optional): Hit test behavior.
  /// - [direction] (`Axis`, optional): Menu layout direction.
  /// - [enabled] (`bool`, optional): Whether menu is enabled.
  const ContextMenu(
      {super.key,
      required this.child,
      required this.items,
      this.behavior = HitTestBehavior.translucent,
      this.direction = Axis.vertical,
      this.enabled = true});

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  late ValueNotifier<List<MenuItem>> _children;

  @override
  void initState() {
    super.initState();
    _children = ValueNotifier(widget.items);
  }

  @override
  void didUpdateWidget(covariant ContextMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.items, oldWidget.items)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) _children.value = widget.items;
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
    final platform = Theme.of(context).platform;
    final bool enableLongPress = platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return GestureDetector(
      behavior: widget.behavior,
      onSecondaryTapDown: !widget.enabled
          ? null
          : (details) {
              _showContextMenu(
                  context, details.globalPosition, _children, widget.direction);
            },
      onLongPressStart: enableLongPress && widget.enabled
          ? (details) {
              _showContextMenu(
                  context, details.globalPosition, _children, widget.direction);
            }
          : null,
      child: widget.child,
    );
  }
}

Future<void> _showContextMenu(
  BuildContext context,
  Offset position,
  ValueListenable<List<MenuItem>> children,
  Axis direction,
) async {
  final key = GlobalKey<OverlayHandlerStateMixin>();
  final theme = Theme.of(context);
  final overlayManager = OverlayManager.of(context);
  return overlayManager
      .showMenu(
        key: key,
        context: context,
        position: position + const Offset(8, 0),
        alignment: Alignment.topLeft,
        anchorAlignment: Alignment.topRight,
        regionGroupId: key,
        modal: true,
        follow: false,
        consumeOutsideTaps: false,
        dismissBackdropFocus: false,
        overlayBarrier: OverlayBarrier(
          borderRadius: BorderRadius.circular(theme.radiusMd),
          barrierColor: const Color(0xB2000000),
        ),
        builder: (context) {
          return AnimatedBuilder(
              animation: children,
              builder: (context, child) {
                bool isSheetOverlay =
                    SheetOverlayHandler.isSheetOverlay(context);
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 192,
                  ),
                  child: MenuGroup(
                    itemPadding: isSheetOverlay
                        ? const EdgeInsets.symmetric(horizontal: 8) *
                            theme.scaling
                        : EdgeInsets.zero,
                    direction: direction,
                    regionGroupId: key,
                    subMenuOffset: const Offset(8, -4),
                    onDismissed: () {
                      closeOverlay(context);
                    },
                    builder: (context, children) {
                      final compTheme =
                          ComponentTheme.maybeOf<ContextMenuTheme>(context);
                      return MenuPopup(
                        surfaceOpacity: compTheme?.surfaceOpacity,
                        surfaceBlur: compTheme?.surfaceBlur,
                        children: children,
                      );
                    },
                    children: children.value,
                  ),
                );
              });
        },
      )
      .future;
}

/// Internal widget for rendering a context menu popup.
///
/// Displays the actual menu content in an overlay with positioning and theming.
/// Typically used internally by [ContextMenu].
class ContextMenuPopup extends StatelessWidget {
  /// Build context for anchoring the popup.
  final BuildContext anchorContext;

  /// Position to display the popup.
  final Offset position;

  /// Menu items to display.
  final List<MenuItem> children;

  /// Captured themes for consistent styling.
  final CapturedThemes? themes;

  /// Direction to lay out menu items.
  final Axis direction;

  /// Callback when popup follows the anchor.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Creates a [ContextMenuPopup].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [position] (`Offset`, required): Popup position.
  /// - [children] (`List<MenuItem>`, required): Menu items.
  /// - [themes] (`CapturedThemes?`, optional): Captured themes.
  /// - [direction] (`Axis`, default: `Axis.vertical`): Layout direction.
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`, optional): Follow callback.
  /// - [anchorSize] (`Size?`, optional): Anchor size.
  const ContextMenuPopup({
    super.key,
    required this.anchorContext,
    required this.position,
    required this.children,
    this.themes,
    this.direction = Axis.vertical,
    this.onTickFollow,
    this.anchorSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedValueBuilder.animation(
      value: 1.0,
      initialValue: 0.0,
      duration: const Duration(milliseconds: 100),
      builder: (context, animation) {
        final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
        return PopoverOverlayWidget(
          anchorContext: anchorContext,
          position: position,
          anchorSize: anchorSize,
          alignment: Alignment.topLeft,
          themes: themes,
          follow: onTickFollow != null,
          onTickFollow: onTickFollow,
          builder: (context) {
            final theme = Theme.of(context);
            return LimitedBox(
              maxWidth: 192 * theme.scaling,
              child: MenuGroup(
                direction: direction,
                itemPadding: isSheetOverlay
                    ? const EdgeInsets.symmetric(horizontal: 8) * theme.scaling
                    : EdgeInsets.zero,
                builder: (context, children) {
                  final compTheme =
                      ComponentTheme.maybeOf<ContextMenuTheme>(context);
                  return MenuPopup(
                    surfaceOpacity: compTheme?.surfaceOpacity,
                    surfaceBlur: compTheme?.surfaceBlur,
                    children: children,
                  );
                },
                children: children,
              ),
            );
          },
          animation: animation,
          anchorAlignment: Alignment.topRight,
        );
      },
    );
  }
}
