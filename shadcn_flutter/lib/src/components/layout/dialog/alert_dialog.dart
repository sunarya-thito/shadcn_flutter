import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertDialog extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const AlertDialog({
    Key? key,
    this.leading,
    this.title,
    this.content,
    this.actions,
    this.trailing,
  }) : super(key: key);

  @override
  _AlertDialogState createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: themeData.colorScheme.popover,
            borderRadius: BorderRadius.circular(themeData.radiusXl),
            border: Border.all(
              color: themeData.colorScheme.muted,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.leading != null)
                      AnimatedIconTheme(
                          data: IconThemeData(
                            color: themeData.colorScheme.mutedForeground,
                            size: 32,
                          ),
                          duration: kDefaultDuration,
                          child: widget.leading!),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title != null || widget.content != null)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.title != null)
                                    widget.title!.large().semiBold(),
                                  if (widget.content != null)
                                    widget.content!.small().muted(),
                                ],
                              ).gap(8),
                            ),
                        ],
                      ),
                    ),
                    if (widget.trailing != null)
                      AnimatedIconTheme(
                          data: IconThemeData(
                            color: themeData.colorScheme.mutedForeground,
                            size: 32,
                          ),
                          duration: kDefaultDuration,
                          child: widget.trailing!),
                  ],
                ).gap(16),
              ),
              if (widget.actions != null && widget.actions!.isNotEmpty)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // children: widget.actions!,
                    children: join(widget.actions!, const SizedBox(width: 8))
                        .toList(),
                  ),
                ),
            ],
          ).gap(16),
        ),
      ),
    );
  }
}
