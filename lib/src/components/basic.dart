import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Basic extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? trailing;

  const Basic({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.content,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) leading!,
            if (leading != null &&
                (title != null || content != null || subtitle != null))
              const SizedBox(width: 16),
            if (title != null || content != null || subtitle != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null)
                      DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          child: title!),
                    if (title != null && subtitle != null)
                      const SizedBox(height: 2),
                    if (subtitle != null)
                      DefaultTextStyle.merge(
                          style: TextStyle(
                            fontSize: 12,
                            color: themeData.colorScheme.mutedForeground,
                          ),
                          child: subtitle!),
                    if ((title != null || subtitle != null) && content != null)
                      const SizedBox(height: 4),
                    if (content != null)
                      DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          child: content!),
                  ],
                ),
              ),
            if (trailing != null &&
                (title != null ||
                    content != null ||
                    leading != null ||
                    subtitle != null))
              const SizedBox(width: 16),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
