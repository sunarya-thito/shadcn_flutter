import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DesktopEditableTextContextMenu extends StatelessWidget {
  final BuildContext anchorContext;
  final EditableTextState editableTextState;
  final UndoHistoryController? undoHistoryController;

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

  const ContextMenu({
    super.key,
    required this.child,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
    this.direction = Axis.vertical,
  });

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
        _children.value = widget.items;
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
      onSecondaryTapDown: (details) {
        _showContextMenu(
            context, details.globalPosition, _children, widget.direction);
      },
      onLongPressStart: enableLongPress
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
                      return MenuPopup(
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
  final ValueChanged<PopoverAnchorState>? onTickFollow;
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
      durationBuilder: (a, b) {
        if (a < b) {
          // forward duration
          return const Duration(milliseconds: 100);
        } else {
          // reverse duration
          return kDefaultDuration;
        }
      },
      builder: (context, animation) {
        final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
        return PopoverAnchor(
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
                  return MenuPopup(
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
