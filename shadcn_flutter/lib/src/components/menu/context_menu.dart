import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DesktopEditableTextContextMenu extends StatelessWidget {
  final BuildContext anchorContext;
  final EditableTextState editableTextState;
  final UndoHistoryController? undoHistoryController;

  const DesktopEditableTextContextMenu({
    Key? key,
    required this.anchorContext,
    required this.editableTextState,
    this.undoHistoryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    if (undoHistoryController == null) {
      return ShadcnUI(
        child: ContextMenuPopup(
          anchorContext: anchorContext,
          position: editableTextState.contextMenuAnchors.primaryAnchor +
              const Offset(8, -8),
          children: [
            cutButtonWidget,
            copyButtonWidget,
            pasteButtonWidget,
            selectAllButtonWidget,
          ],
        ),
      );
    }
    return ShadcnUI(
      child: AnimatedBuilder(
          animation: undoHistoryController,
          builder: (context, child) {
            return ContextMenuPopup(
              anchorContext: anchorContext,
              position: editableTextState.contextMenuAnchors.primaryAnchor +
                  const Offset(8, -8),
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
              ],
            );
          }),
    );
  }
}

// mostly same as desktop, but direction is horizontal, and shows no menu shortcuts
class MobileEditableTextContextMenu extends StatelessWidget {
  final BuildContext anchorContext;
  final EditableTextState editableTextState;
  final UndoHistoryController? undoHistoryController;

  const MobileEditableTextContextMenu({
    Key? key,
    required this.anchorContext,
    required this.editableTextState,
    this.undoHistoryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    if (undoHistoryController == null) {
      List<List<MenuItem>> categories = [
        if (modificationCategory.isNotEmpty) modificationCategory,
        if (destructiveCategory.isNotEmpty) destructiveCategory,
      ];
      return ShadcnUI(
        child: ContextMenuPopup(
          anchorContext: anchorContext,
          position: editableTextState.contextMenuAnchors.primaryAnchor +
              const Offset(8, -8),
          children: categories
              .expand((element) => [
                    ...element,
                  ])
              .toList()
              .joinSeparator(const MenuDivider()),
        ),
      );
    }

    return ShadcnUI(
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
              position: editableTextState.contextMenuAnchors.primaryAnchor +
                  const Offset(8, -8),
              children: categories
                  .expand((element) => [
                        ...element,
                      ])
                  .toList()
                  .joinSeparator(const MenuDivider()),
            );
          }),
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
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    case TargetPlatform.macOS:
    case TargetPlatform.iOS:
    case TargetPlatform.android:
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
    Key? key,
    required this.child,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
    this.direction = Axis.vertical,
  }) : super(key: key);

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
  final key = GlobalKey<PopoverAnchorState>();
  return showPopover(
    key: key,
    context: context,
    position: position + const Offset(8, 0),
    alignment: Alignment.topLeft,
    anchorAlignment: Alignment.topRight,
    regionGroupId: key,
    modal: false,
    follow: false,
    consumeOutsideTaps: false,
    dismissBackdropFocus: false,
    builder: (context) {
      return AnimatedBuilder(
          animation: children,
          builder: (context, child) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 192,
              ),
              child: MenuGroup(
                direction: direction,
                regionGroupId: key,
                subMenuOffset: const Offset(8, -4),
                onDismissed: () {
                  closePopover(context);
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
  );
}

class ContextMenuPopup extends StatelessWidget {
  final BuildContext anchorContext;
  final Offset position;
  final List<MenuItem> children;
  final CapturedThemes? themes;
  final Axis direction;
  const ContextMenuPopup({
    Key? key,
    required this.anchorContext,
    required this.position,
    required this.children,
    this.themes,
    this.direction = Axis.vertical,
  }) : super(key: key);

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
        return PopoverAnchor(
          anchorContext: anchorContext,
          position: position,
          alignment: Alignment.topLeft,
          themes: themes,
          follow: false,
          builder: (context) {
            final theme = Theme.of(context);
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 192 * theme.scaling,
              ),
              child: MenuGroup(
                direction: direction,
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
