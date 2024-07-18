import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';

import '../../shadcn_flutter.dart';

// just wrap around the material.TextField widget
class TextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool filled;
  final String? placeholder;
  final bool border;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final String obscuringCharacter;
  final String? initialValue;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final BorderRadius? borderRadius;
  final TextAlign textAlign;
  final bool expands;
  final TextAlignVertical? textAlignVertical;
  final UndoHistoryController? undoController;
  const TextField({
    Key? key,
    this.controller,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.filled = false,
    this.placeholder,
    this.border = true,
    this.leading,
    this.trailing,
    this.padding,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.initialValue,
    this.borderRadius,
    this.textAlign = TextAlign.start,
    this.expands = false,
    this.textAlignVertical = TextAlignVertical.center,
    this.undoController,
  }) : super(key: key);

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> with FormValueSupplier {
  late FocusNode _focusNode;
  final GlobalKey _key = GlobalKey();
  late TextEditingController _controller;
  late UndoHistoryController _undoHistoryController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _undoHistoryController = widget.undoController ?? UndoHistoryController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onValueChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      _controller.text,
      (value) {
        _controller.text = value;
      },
    );
  }

  @override
  void didUpdateWidget(covariant TextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onValueChanged);
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_onValueChanged);
    }
    if (widget.undoController != oldWidget.undoController) {
      _undoHistoryController = widget.undoController ?? UndoHistoryController();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      widget.onEditingComplete?.call();
    }
  }

  void _onValueChanged() {
    reportNewFormValue(
      _controller.text,
      (value) {
        _controller.text = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    return material.Theme(
      data: material.ThemeData(
        textSelectionTheme: material.TextSelectionThemeData(
          cursorColor: theme.colorScheme.primary,
          selectionColor: theme.colorScheme.primary.withOpacity(0.3),
          selectionHandleColor: theme.colorScheme.primary,
        ),
      ),
      child: material.TextField(
        key: _key,
        contextMenuBuilder: (innerContext, editableTextState) {
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
          return AnimatedBuilder(
              animation: _undoHistoryController,
              builder: (context, child) {
                return ContextMenuPopup(
                  anchorContext: this.context,
                  position: editableTextState.contextMenuAnchors.primaryAnchor +
                      const Offset(8, -8),
                  children: [
                    MenuButton(
                      enabled: _undoHistoryController.value.canUndo,
                      onPressed: (context) {
                        _undoHistoryController.undo();
                      },
                      trailing: const MenuShortcut(
                        activator: SingleActivator(
                          LogicalKeyboardKey.keyZ,
                          control: true,
                        ),
                      ),
                      child: Text('Undo'),
                    ),
                    MenuButton(
                      enabled: _undoHistoryController.value.canRedo,
                      onPressed: (context) {
                        _undoHistoryController.redo();
                      },
                      trailing: const MenuShortcut(
                        activator: SingleActivator(
                          LogicalKeyboardKey.keyZ,
                          control: true,
                          shift: true,
                        ),
                      ),
                      child: Text('Redo'),
                    ),
                    MenuDivider(),
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
                      child: Text('Cut'),
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
                      child: Text('Copy'),
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
                      child: Text('Paste'),
                    ),
                    MenuButton(
                      enabled: selectAllButton != null,
                      onPressed: (context) {
                        // somehow, we lost focus upon context menu open
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          selectAllButton?.onPressed?.call();
                        });
                      },
                      trailing: const MenuShortcut(
                        activator: SingleActivator(
                          LogicalKeyboardKey.keyA,
                          control: true,
                        ),
                      ),
                      child: Text('Select All'),
                    ),
                    if (contextMenuButtonItems.isNotEmpty) ...[
                      // add the rest
                      MenuDivider(),
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
              });
        },
        textAlign: widget.textAlign,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        onTap: widget.onTap,
        focusNode: _focusNode,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        undoController: _undoHistoryController,
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          return null;
        },
        controller: _controller,
        style: defaultTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: theme.colorScheme.foreground,
        ),
        expands: widget.expands,
        textAlignVertical: widget.textAlignVertical,
        decoration: material.InputDecoration(
          isCollapsed: true,
          prefixIcon: widget.leading,
          suffixIcon: widget.trailing,
          filled: widget.filled,
          isDense: true,
          fillColor: theme.colorScheme.muted,
          hintText: widget.placeholder,
          hintStyle: defaultTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.mutedForeground,
          ),
          border: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.border,
                      ),
                    ),
          hoverColor: Colors.transparent,
          focusedBorder: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.ring,
                      ),
                    ),
          enabledBorder: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.border,
                      ),
                    ),
          disabledBorder: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.border,
                      ),
                    ),
          errorBorder: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.destructive,
                      ),
                    ),
          focusedErrorBorder: !widget.border
              ? material.InputBorder.none
              : widget.filled
                  ? material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide.none,
                    )
                  : material.OutlineInputBorder(
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(theme.radiusMd),
                      borderSide: BorderSide(
                        color: theme.colorScheme.destructive,
                      ),
                    ),
          contentPadding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4 + 8,
              ),
        ),
        cursorColor: theme.colorScheme.primary,
        cursorWidth: 1,
      ),
    );
  }
}
