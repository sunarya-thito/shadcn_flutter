import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for context menu appearance and visual effects.
///
/// [ContextMenuTheme] provides styling options for context menu popups including
/// surface opacity and blur effects. These settings control the visual presentation
/// of context menus to ensure they stand out from background content while maintaining
/// visual coherence with the design system.
///
/// Context menus benefit from subtle surface effects that help establish visual
/// hierarchy and focus attention on available actions. The opacity and blur effects
/// create depth while ensuring content remains readable.
///
/// Example:
/// ```dart
/// ComponentTheme<ContextMenuTheme>(
///   data: ContextMenuTheme(
///     surfaceOpacity: 0.95,
///     surfaceBlur: 8.0,
///   ),
///   child: MyContextMenuWidget(),
/// )
/// ```
class ContextMenuTheme {
  /// Opacity level for the context menu popup surface.
  ///
  /// Controls the transparency of the context menu background. Values range
  /// from 0.0 (fully transparent) to 1.0 (fully opaque). When null, uses
  /// the theme's default surface opacity.
  ///
  /// Typical values:
  /// - 0.9-1.0: High opacity for better readability
  /// - 0.8-0.9: Moderate transparency showing content below
  /// - 0.6-0.8: High transparency for subtle overlay effect
  final double? surfaceOpacity;

  /// Blur amount applied to the context menu popup surface.
  ///
  /// Creates a frosted glass effect by blurring content behind the menu.
  /// Higher values create more pronounced blur effects. When null, uses
  /// the theme's default surface blur amount.
  ///
  /// Typical values:
  /// - 0.0: No blur effect
  /// - 4.0-8.0: Subtle blur for depth
  /// - 12.0-20.0: Strong blur for prominent separation
  final double? surfaceBlur;

  /// Creates a [ContextMenuTheme] with optional visual effect settings.
  ///
  /// Both parameters are optional and fall back to theme defaults when null.
  /// Use these settings to create context menus that match your application's
  /// visual style and hierarchy requirements.
  ///
  /// Parameters:
  /// - [surfaceOpacity]: Opacity level for the popup surface (0.0-1.0)
  /// - [surfaceBlur]: Blur amount for the popup surface (0.0+)
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

/// Desktop-specific context menu for editable text widgets.
///
/// [DesktopEditableTextContextMenu] provides standard text editing actions
/// (cut, copy, paste, select all, undo, redo) in a context menu format optimized
/// for desktop platforms. It integrates with Flutter's text editing system and
/// respects platform conventions for text interaction.
///
/// This widget is typically used internally by text input widgets but can be
/// customized or extended for specialized text editing interfaces. It automatically
/// enables/disables menu items based on current text selection and clipboard state.
///
/// The menu respects system accessibility settings and provides keyboard shortcuts
/// where appropriate, making it suitable for production desktop applications.
///
/// Example usage in custom text widgets:
/// ```dart
/// DesktopEditableTextContextMenu(
///   anchorContext: context,
///   editableTextState: textFieldState,
///   undoHistoryController: undoController,
/// )
/// ```
class DesktopEditableTextContextMenu extends StatelessWidget {
  /// Build context of the widget that anchors the context menu.
  ///
  /// Used for positioning the context menu relative to the text widget
  /// and accessing theme and localization data. Should be the context
  /// of the editable text widget that triggered the menu.
  final BuildContext anchorContext;

  /// State of the editable text widget that owns the text being edited.
  ///
  /// Provides access to current text content, selection state, and text
  /// editing operations. Used to determine which menu items are available
  /// and to execute text operations when items are selected.
  final EditableTextState editableTextState;

  /// Controller for managing undo/redo operations.
  ///
  /// When provided, enables undo and redo menu items that operate on the
  /// text editing history. When null, undo/redo operations are not available
  /// in the context menu.
  final UndoHistoryController? undoHistoryController;

  /// Creates a [DesktopEditableTextContextMenu] for text editing operations.
  ///
  /// Parameters:
  /// - [anchorContext] (BuildContext, required): Context for menu positioning
  /// - [editableTextState] (EditableTextState, required): Text widget state
  /// - [undoHistoryController] (UndoHistoryController?, optional): Undo/redo controller
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

// mostly same as desktop, but direction is horizontal, and shows no menu shortcuts
class MobileEditableTextContextMenu extends StatelessWidget {
  final BuildContext anchorContext;
  final EditableTextState editableTextState;
  final UndoHistoryController? undoHistoryController;

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

Widget buildEditableTextContextMenu(
    BuildContext innerContext, EditableTextState editableTextState,
    [UndoHistoryController? undoHistoryController]) {
  TargetPlatform platform = Theme.of(innerContext).platform;

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
  }
}

class ContextMenu extends StatefulWidget {
  final Widget child;
  final List<MenuItem> items;
  final HitTestBehavior behavior;
  final Axis direction;
  final bool enabled;

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
        if(mounted) _children.value = widget.items;
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

class ContextMenuPopup extends StatelessWidget {
  final BuildContext anchorContext;
  final Offset position;
  final List<MenuItem> children;
  final CapturedThemes? themes;
  final Axis direction;
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;
  final Size? anchorSize;
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
