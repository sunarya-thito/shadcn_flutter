import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

// just wrap around the material.TextField widget lmfaoo
class TextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool filled;
  final String? placeholder;
  final bool border;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  const TextField({
    Key? key,
    this.controller,
    this.filled = false,
    this.placeholder,
    this.border = true,
    this.leading,
    this.trailing,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    return material.Localizations(
      delegates: const [
        material.DefaultMaterialLocalizations.delegate,
        cupertino.DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      locale: Localizations.localeOf(context),
      child: material.Material(
        color: Colors.transparent,
        child: material.TextField(
          controller: controller,
          style: defaultTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.foreground,
          ),
          decoration: material.InputDecoration(
            prefix: leading,
            suffix: trailing,
            filled: filled,
            isDense: true,
            fillColor: theme.colorScheme.muted,
            hintText: placeholder,
            hintStyle: defaultTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.mutedForeground,
            ),
            border: !border
                ? material.InputBorder.none
                : filled
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
            // focusedBorder: material.OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(theme.radiusMd),
            //   borderSide: BorderSide(
            //     color: theme.colorScheme.ring,
            //   ),
            // ),
            focusedBorder: !border
                ? material.InputBorder.none
                : material.OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    borderSide: BorderSide(
                      color: theme.colorScheme.ring,
                    ),
                  ),
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
            enabledBorder: !border
                ? material.InputBorder.none
                : filled
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
            disabledBorder: !border
                ? material.InputBorder.none
                : filled
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
            errorBorder: !border
                ? material.InputBorder.none
                : filled
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
            focusedErrorBorder: !border
                ? material.InputBorder.none
                : filled
                    ? material.OutlineInputBorder(
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide.none,
                      )
                    : material.OutlineInputBorder(
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.ring,
                        ),
                      ),
            contentPadding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4 + 8,
                ),
          ),
          cursorColor: theme.colorScheme.primary,
          cursorWidth: 1,
        ),
      ),
    );
  }
}
