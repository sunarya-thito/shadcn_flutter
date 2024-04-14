import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/src/components/focus_outline.dart';

import '../../shadcn_flutter.dart';

// just wrap around the material.TextField widget lmfaoo
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
  }) : super(key: key);

  @override
  cupertino.State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends cupertino.State<TextField> {
  late FocusNode _focusNode;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('updating');
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      widget.onEditingComplete?.call();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    return FocusOutline(
      focused: _focusNode.hasFocus && widget.border,
      borderRadius: BorderRadius.circular(theme.radiusMd),
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
            focusNode: _focusNode,
            onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            controller: widget.controller,
            style: defaultTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.foreground,
            ),
            decoration: material.InputDecoration(
              prefix: widget.leading,
              suffix: widget.trailing,
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
              // focusedBorder: material.OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(theme.radiusMd),
              //   borderSide: BorderSide(
              //     color: theme.colorScheme.ring,
              //   ),
              // ),
              // focusedBorder: !widget.border
              //     ? material.InputBorder.none
              //     : material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide(
              //           color: theme.colorScheme.ring,
              //         ),
              //       ),
              // enabledBorder: filled
              //     ? material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide.none,
              //       )
              //     : material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide(
              //           color: theme.colorScheme.border,
              //         ),
              //       ),
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
              // disabledBorder: filled
              //     ? material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide.none,
              //       )
              //     : material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide(
              //           color: theme.colorScheme.border,
              //         ),
              //       ),
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
              // errorBorder: filled
              //     ? material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide.none,
              //       )
              //     : material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide(
              //           color: theme.colorScheme.destructive,
              //         ),
              //       ),
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
              // focusedErrorBorder: filled
              //     ? material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide.none,
              //       )
              //     : material.OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(theme.radiusMd),
              //         borderSide: BorderSide(
              //           color: theme.colorScheme.ring,
              //         ),
              //       ),
              // focusedErrorBorder: !widget.border
              //     ? material.InputBorder.none
              //     : widget.filled
              //         ? material.OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(theme.radiusMd),
              //             borderSide: BorderSide.none,
              //           )
              //         : material.OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(theme.radiusMd),
              //             borderSide: BorderSide(
              //               color: theme.colorScheme.
              //             ),
              //           ),
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
