import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget buildEditableTextContextMenu(
    BuildContext innerContext, EditableTextState editableTextState,
    [UndoHistoryController? undoHistoryController]) {
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
  if (undoHistoryController == null) {
    return ShadcnUI(
      child: ContextMenuPopup(
        anchorContext: innerContext,
        position: editableTextState.contextMenuAnchors.primaryAnchor +
            const Offset(8, -8),
        children: [
          MenuButton(
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
            child: const Text('Cut'),
          ),
          MenuButton(
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
            child: const Text('Copy'),
          ),
          MenuButton(
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
            child: const Text('Paste'),
          ),
          MenuButton(
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
            child: const Text('Select All'),
          ),
          if (contextMenuButtonItems.isNotEmpty) ...[
            // add the rest
            const MenuDivider(),
            ...contextMenuButtonItems
                .map<MenuButton?>((e) {
                  if (e.label == null) {
                    return null;
                  }
                  return MenuButton(
                    onPressed: (context) {
                      e.onPressed?.call();
                    },
                    child: Text(e.label!),
                  );
                })
                .where((element) => element != null)
                .cast<MenuButton>(),
          ]
        ],
      ),
    );
  }
  return ShadcnUI(
    child: AnimatedBuilder(
        animation: undoHistoryController,
        builder: (context, child) {
          return ContextMenuPopup(
            anchorContext: innerContext,
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
              MenuButton(
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
                child: const Text('Cut'),
              ),
              MenuButton(
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
                child: const Text('Copy'),
              ),
              MenuButton(
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
                child: const Text('Paste'),
              ),
              MenuButton(
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
                child: const Text('Select All'),
              ),
              if (contextMenuButtonItems.isNotEmpty) ...[
                // add the rest
                const MenuDivider(),
                ...contextMenuButtonItems
                    .map<MenuButton?>((e) {
                      if (e.label == null) {
                        return null;
                      }
                      return MenuButton(
                        onPressed: (context) {
                          e.onPressed?.call();
                        },
                        child: Text(e.label!),
                      );
                    })
                    .where((element) => element != null)
                    .cast<MenuButton>(),
              ]
            ],
          );
        }),
  );
}

class ContextMenu extends StatefulWidget {
  final Widget child;
  final List<MenuItem> items;
  final HitTestBehavior behavior;

  const ContextMenu({
    Key? key,
    required this.child,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
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
    return GestureDetector(
      behavior: widget.behavior,
      onSecondaryTapDown: (details) {
        _showContextMenu(context, details.globalPosition, _children);
      },
      child: widget.child,
    );
  }
}

Future<void> _showContextMenu(
  BuildContext context,
  Offset position,
  ValueListenable<List<MenuItem>> children,
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
  const ContextMenuPopup({
    Key? key,
    required this.anchorContext,
    required this.position,
    required this.children,
    this.themes,
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
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 192,
              ),
              child: MenuGroup(
                children: children,
                builder: (context, children) {
                  return MenuPopup(
                    children: children,
                  );
                },
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
