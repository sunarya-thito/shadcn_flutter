import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/src/components/focus_outline.dart';

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
  const TextField({
    Key? key,
    this.controller,
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
  }) : super(key: key);

  @override
  cupertino.State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> with FormValueSupplier {
  late FocusNode _focusNode;
  final GlobalKey _key = GlobalKey();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
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
    print('rebuild TextField');
    final theme = Theme.of(context);
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    return AnimatedBuilder(
      animation: _focusNode,
      builder: (context, child) {
        return FocusOutline(
          focused: _focusNode.hasFocus && widget.border,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          child: child!,
        );
      },
      child: material.Localizations(
        delegates: const [
          material.DefaultMaterialLocalizations.delegate,
          cupertino.DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        locale: Localizations.localeOf(context),
        child: material.Material(
          color: Colors.transparent,
          child: material.TextField(
            key: _key,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            focusNode: _focusNode,
            onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            controller: _controller,
            style: defaultTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.foreground,
            ),
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
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide(
                            color: theme.colorScheme.border,
                          ),
                        ),
              hoverColor: Colors.transparent,
              focusedBorder: !widget.border
                  ? material.InputBorder.none
                  : widget.filled
                      ? material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide(
                            color: theme.colorScheme.border,
                          ),
                        ),
              enabledBorder: !widget.border
                  ? material.InputBorder.none
                  : widget.filled
                      ? material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide(
                            color: theme.colorScheme.border,
                          ),
                        ),
              disabledBorder: !widget.border
                  ? material.InputBorder.none
                  : widget.filled
                      ? material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide(
                            color: theme.colorScheme.border,
                          ),
                        ),
              errorBorder: !widget.border
                  ? material.InputBorder.none
                  : widget.filled
                      ? material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide(
                            color: theme.colorScheme.destructive,
                          ),
                        ),
              focusedErrorBorder: !widget.border
                  ? material.InputBorder.none
                  : widget.filled
                      ? material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          borderSide: BorderSide.none,
                        )
                      : material.OutlineInputBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
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
        ),
      ),
    );
  }
}
