import '../../shadcn_flutter.dart';

class Basic extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? trailing;
  final Alignment? leadingAlignment;
  final Alignment? trailingAlignment;
  final Alignment? titleAlignment;
  final Alignment? subtitleAlignment;
  final Alignment? contentAlignment;

  const Basic({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.content,
    this.trailing,
    this.leadingAlignment,
    this.trailingAlignment,
    this.titleAlignment,
    this.subtitleAlignment,
    this.contentAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null)
              Align(
                alignment: leadingAlignment ?? Alignment.topCenter,
                child: leading!,
              ),
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
                          child: Align(
                            alignment: titleAlignment ?? Alignment.topLeft,
                            child: title!,
                          )),
                    if (title != null && subtitle != null)
                      const SizedBox(height: 2),
                    if (subtitle != null)
                      DefaultTextStyle.merge(
                          style: TextStyle(
                            fontSize: 12,
                            color: themeData.colorScheme.mutedForeground,
                          ),
                          child: Align(
                            alignment: subtitleAlignment ?? Alignment.topLeft,
                            child: subtitle!,
                          )),
                    if ((title != null || subtitle != null) && content != null)
                      const SizedBox(height: 4),
                    if (content != null)
                      DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          // child: content!),
                          child: Align(
                            alignment: contentAlignment ?? Alignment.topLeft,
                            child: content!,
                          )),
                  ],
                ),
              ),
            if (trailing != null &&
                (title != null ||
                    content != null ||
                    leading != null ||
                    subtitle != null))
              const SizedBox(width: 16),
            // if (trailing != null) trailing!,
            if (trailing != null)
              Align(
                alignment: trailingAlignment ?? Alignment.topCenter,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
