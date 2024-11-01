import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pixel_snap/material.dart' as material;

import '../../../shadcn_flutter.dart';

// just wrap around the material.TextField widget
class TextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool filled;
  final Widget? placeholder;
  final AlignmentGeometry placeholderAlignment;
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
  final BorderRadiusGeometry? borderRadius;
  final TextAlign textAlign;
  final bool expands;
  final TextAlignVertical? textAlignVertical;
  final UndoHistoryController? undoController;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final void Function(PointerDownEvent event)? onTapOutside;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool useNativeContextMenu;
  final bool? isCollapsed;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Clip clipBehavior;
  final bool autofocus;

  const TextField({
    super.key,
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
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.expands = false,
    this.textAlignVertical = TextAlignVertical.center,
    this.autofillHints,
    this.undoController,
    this.onChanged,
    this.onTapOutside,
    this.inputFormatters,
    this.style,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.useNativeContextMenu = false,
    this.isCollapsed,
    this.textInputAction,
    this.clipBehavior = Clip.hardEdge,
    this.autofocus = false,
    this.placeholderAlignment = AlignmentDirectional.topStart,
  });

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return buildEditableTextContextMenu(context, editableTextState);
  }

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
    final scaling = theme.scaling;
    TextStyle defaultTextStyle;
    if (widget.style != null) {
      defaultTextStyle = DefaultTextStyle.of(context)
          .style
          .merge(theme.typography.small)
          .merge(theme.typography.normal)
          .copyWith(
            color: theme.colorScheme.foreground,
          )
          .merge(widget.style);
    } else {
      defaultTextStyle = DefaultTextStyle.of(context)
          .style
          .merge(theme.typography.small)
          .merge(theme.typography.normal)
          .copyWith(
            color: theme.colorScheme.foreground,
          );
    }
    var maxLines = widget.maxLines;
    maxLines ??= widget.obscureText ? 1 : null;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        material.TextField(
          key: _key,
          contextMenuBuilder: widget.contextMenuBuilder == null
              ? null
              : widget.useNativeContextMenu && !kIsWeb
                  ? (context, editableTextState) {
                      return material.AdaptiveTextSelectionToolbar.editableText(
                        editableTextState: editableTextState,
                      );
                    }
                  : widget.contextMenuBuilder,
          clipBehavior: widget.clipBehavior,
          inputFormatters: widget.inputFormatters,
          onTapOutside: widget.onTapOutside,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign,
          obscureText: widget.obscureText,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          maxLines: maxLines,
          onTap: widget.onTap,
          focusNode: _focusNode,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          undoController: _undoHistoryController,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          minLines: widget.minLines,
          buildCounter: (context,
              {required currentLength,
              required isFocused,
              required maxLength}) {
            return null;
          },
          controller: _controller,
          style: defaultTextStyle,
          expands: widget.expands,
          textAlignVertical: widget.textAlignVertical,
          decoration: material.InputDecoration(
            isCollapsed: widget.isCollapsed,
            prefixIcon: widget.leading,
            suffixIcon: widget.trailing,
            filled: widget.filled,
            isDense: true,
            fillColor: theme.colorScheme.muted,
            // hintText: widget.placeholder,
            // hintStyle: defaultTextStyle
            //     .merge(theme.typography.normal)
            //     .merge(theme.typography.small)
            //     .copyWith(
            //       color: theme.colorScheme.mutedForeground,
            //     ),
            border: !widget.border
                ? material.InputBorder.none
                : widget.filled
                    ? material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
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
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.ring,
                        ),
                      ),
            enabledBorder: !widget.border
                ? material.InputBorder.none
                : widget.filled
                    ? material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.border,
                        ),
                      ),
            disabledBorder: !widget.border
                ? material.InputBorder.none
                : widget.filled
                    ? material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.border,
                        ),
                      ),
            errorBorder: !widget.border
                ? material.InputBorder.none
                : widget.filled
                    ? material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.destructive,
                        ),
                      ),
            focusedErrorBorder: !widget.border
                ? material.InputBorder.none
                : widget.filled
                    ? material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: optionallyResolveBorderRadius(
                                context, widget.borderRadius) ??
                            BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.destructive,
                        ),
                      ),
            contentPadding: widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: 12 * scaling,
                  vertical: (4 + 8) * scaling,
                ),
          ),
          cursorColor: theme.colorScheme.primary,
          cursorWidth: 1,
        ),
        if (widget.placeholder != null)
          Positioned.fill(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return IgnorePointer(
                  child: Visibility(
                    visible: _controller.text.isEmpty,
                    child: Container(
                      padding: widget.padding ??
                          EdgeInsets.symmetric(
                            horizontal: 12 * scaling,
                            vertical: (8 + 1) * scaling,
                          ),
                      alignment: widget.placeholderAlignment,
                      child: DefaultTextStyle(
                        style: defaultTextStyle
                            .merge(theme.typography.normal)
                            .merge(theme.typography.small)
                            .copyWith(
                              color: theme.colorScheme.mutedForeground,
                            ),
                        child: widget.placeholder!,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
