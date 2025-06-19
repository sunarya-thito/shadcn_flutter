import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertDialog extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final Color? barrierColor;
  final EdgeInsetsGeometry? padding;

  const AlertDialog({
    super.key,
    this.leading,
    this.title,
    this.content,
    this.actions,
    this.trailing,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.barrierColor,
    this.padding,
  });

  @override
  _AlertDialogState createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final scaling = themeData.scaling;

    return ModalBackdrop(
      borderRadius: themeData.borderRadiusXxl,

      barrierColor: widget.barrierColor ?? Colors.black.withOpacity(0.8),

      surfaceClip: ModalBackdrop.shouldClipSurface(
        widget.surfaceOpacity ?? themeData.surfaceOpacity,
      ),

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),

        child: ModalContainer(
          fillColor: themeData.colorScheme.popover,

          filled: true,

          borderRadius: themeData.borderRadiusXxl,

          borderWidth: 1 * scaling,

          borderColor: themeData.colorScheme.muted,

          padding: widget.padding ?? EdgeInsets.all(24 * scaling),

          surfaceBlur: widget.surfaceBlur ?? themeData.surfaceOpacity,

          surfaceOpacity: widget.surfaceOpacity ?? themeData.surfaceOpacity,

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              // HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  if (widget.leading != null)
                    Padding(
                      padding: EdgeInsets.only(right: 16 * scaling),

                      child: widget.leading!.iconXLarge().iconMutedForeground(),
                    ),

                  if (widget.title != null)
                    // Flexible is still needed for text wrapping in case the title is long
                    Flexible(child: widget.title!.large().semiBold()),

                  if (widget.trailing != null)
                    Padding(
                      padding: EdgeInsets.only(left: 16 * scaling),

                      child:
                          widget.trailing!.iconXLarge().iconMutedForeground(),
                    ),
                ],
              ),

              if (widget.content != null) SizedBox(height: 16 * scaling),

              // CONTENT (Scrollable area)
              if (widget.content != null) widget.content!,

              if (widget.actions != null && widget.actions!.isNotEmpty)
                SizedBox(height: 24 * scaling),

              // FOOTER
              if (widget.actions != null && widget.actions!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children:
                      join(
                        widget.actions!,
                        SizedBox(width: 8 * scaling),
                      ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
