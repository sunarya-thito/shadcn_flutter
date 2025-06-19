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
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: ModalContainer(
          fillColor: themeData.colorScheme.popover,
          filled: true,
          borderRadius: themeData.borderRadiusXxl,
          borderWidth: 1 * scaling,
          borderColor: themeData.colorScheme.muted,
          padding: widget.padding ?? EdgeInsets.all(24 * scaling),
          surfaceBlur: widget.surfaceBlur ?? themeData.surfaceBlur,
          surfaceOpacity: widget.surfaceOpacity ?? themeData.surfaceOpacity,
          // 1. The main layout is a Column.
          // It will expand to the height of the ModalContainer.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2. The HEADER is a non-flexible child. It will always be visible at the top.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.leading != null)
                    Padding(
                      padding: EdgeInsets.only(right: 16 * scaling),
                      child: widget.leading!.iconXLarge().iconMutedForeground(),
                    ),
                  if (widget.title != null)
                    Flexible(
                      child: widget.title!.large().semiBold(),
                    ),
                  if (widget.trailing != null)
                    Padding(
                      padding: EdgeInsets.only(left: 16 * scaling),
                      child: widget.trailing!.iconXLarge().iconMutedForeground(),
                    ),
                ],
              ),

              if (widget.content != null)
                SizedBox(height: 16 * scaling),

              // 3. The CONTENT is wrapped in Expanded.
              // This makes it take up all the remaining space between the header and footer.
              // If the content is a scrollable widget (like ListView), it will now scroll correctly.
              if (widget.content != null)
                Expanded(
                  child: widget.content!,
                ),

              if (widget.actions != null && widget.actions!.isNotEmpty)
                SizedBox(height: 24 * scaling),

              // 4. The ACTIONS are a non-flexible child. They will always be visible at the bottom.
              if (widget.actions != null && widget.actions!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:
                      join(widget.actions!, SizedBox(width: 8 * scaling))
                          .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}