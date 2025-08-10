import '../../../shadcn_flutter.dart';

class BasicTheme {
  final AlignmentGeometry? leadingAlignment;
  final AlignmentGeometry? trailingAlignment;
  final AlignmentGeometry? titleAlignment;
  final AlignmentGeometry? subtitleAlignment;
  final AlignmentGeometry? contentAlignment;
  final double? contentSpacing;
  final double? titleSpacing;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;

  const BasicTheme({
    this.leadingAlignment,
    this.trailingAlignment,
    this.titleAlignment,
    this.subtitleAlignment,
    this.contentAlignment,
    this.contentSpacing,
    this.titleSpacing,
    this.mainAxisAlignment,
    this.padding,
  });

  BasicTheme copyWith({
    ValueGetter<AlignmentGeometry?>? leadingAlignment,
    ValueGetter<AlignmentGeometry?>? trailingAlignment,
    ValueGetter<AlignmentGeometry?>? titleAlignment,
    ValueGetter<AlignmentGeometry?>? subtitleAlignment,
    ValueGetter<AlignmentGeometry?>? contentAlignment,
    ValueGetter<double?>? contentSpacing,
    ValueGetter<double?>? titleSpacing,
    ValueGetter<MainAxisAlignment?>? mainAxisAlignment,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return BasicTheme(
      leadingAlignment:
          leadingAlignment == null ? this.leadingAlignment : leadingAlignment(),
      trailingAlignment:
          trailingAlignment == null ? this.trailingAlignment : trailingAlignment(),
      titleAlignment:
          titleAlignment == null ? this.titleAlignment : titleAlignment(),
      subtitleAlignment: subtitleAlignment == null
          ? this.subtitleAlignment
          : subtitleAlignment(),
      contentAlignment: contentAlignment == null
          ? this.contentAlignment
          : contentAlignment(),
      contentSpacing:
          contentSpacing == null ? this.contentSpacing : contentSpacing(),
      titleSpacing: titleSpacing == null ? this.titleSpacing : titleSpacing(),
      mainAxisAlignment: mainAxisAlignment == null
          ? this.mainAxisAlignment
          : mainAxisAlignment(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BasicTheme &&
        other.leadingAlignment == leadingAlignment &&
        other.trailingAlignment == trailingAlignment &&
        other.titleAlignment == titleAlignment &&
        other.subtitleAlignment == subtitleAlignment &&
        other.contentAlignment == contentAlignment &&
        other.contentSpacing == contentSpacing &&
        other.titleSpacing == titleSpacing &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        leadingAlignment,
        trailingAlignment,
        titleAlignment,
        subtitleAlignment,
        contentAlignment,
        contentSpacing,
        titleSpacing,
        mainAxisAlignment,
        padding,
      );
}

class Basic extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? trailing;
  final AlignmentGeometry? leadingAlignment;
  final AlignmentGeometry? trailingAlignment;
  final AlignmentGeometry? titleAlignment;
  final AlignmentGeometry? subtitleAlignment;
  final AlignmentGeometry? contentAlignment;
  final double? contentSpacing;
  final double? titleSpacing;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;

  const Basic({
    super.key,
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
    this.contentSpacing, // 16
    this.titleSpacing, //4
    this.mainAxisAlignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<BasicTheme>(context);
    final padding = styleValue(
        widgetValue: this.padding,
        themeValue: compTheme?.padding,
        defaultValue: EdgeInsets.zero);
    final contentSpacing = styleValue(
        widgetValue: this.contentSpacing,
        themeValue: compTheme?.contentSpacing,
        defaultValue: 16 * scaling);
    final titleSpacing = styleValue(
        widgetValue: this.titleSpacing,
        themeValue: compTheme?.titleSpacing,
        defaultValue: 4 * scaling);
    final leadingAlignment = styleValue(
        widgetValue: this.leadingAlignment,
        themeValue: compTheme?.leadingAlignment,
        defaultValue: Alignment.topCenter);
    final trailingAlignment = styleValue(
        widgetValue: this.trailingAlignment,
        themeValue: compTheme?.trailingAlignment,
        defaultValue: Alignment.topCenter);
    final titleAlignment = styleValue(
        widgetValue: this.titleAlignment,
        themeValue: compTheme?.titleAlignment,
        defaultValue: Alignment.topLeft);
    final subtitleAlignment = styleValue(
        widgetValue: this.subtitleAlignment,
        themeValue: compTheme?.subtitleAlignment,
        defaultValue: Alignment.topLeft);
    final contentAlignment = styleValue(
        widgetValue: this.contentAlignment,
        themeValue: compTheme?.contentAlignment,
        defaultValue: Alignment.topLeft);
    final mainAxisAlignment = styleValue(
        widgetValue: this.mainAxisAlignment,
        themeValue: compTheme?.mainAxisAlignment,
        defaultValue: MainAxisAlignment.center);
    return Padding(
      padding: padding,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (leading != null)
                Align(
                  alignment: leadingAlignment,
                  child: leading!,
                ),
              if (leading != null &&
                  (title != null || content != null || subtitle != null))
                SizedBox(width: contentSpacing),
              if (title != null || content != null || subtitle != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      if (title != null)
                        Align(
                          alignment: titleAlignment,
                          child: title!,
                        ).small().medium(),
                      if (title != null && subtitle != null)
                        SizedBox(height: 2 * scaling),
                      if (subtitle != null)
                        Align(
                          alignment: subtitleAlignment,
                          child: subtitle!,
                        ).xSmall().muted(),
                      if ((title != null || subtitle != null) &&
                          content != null)
                        SizedBox(height: titleSpacing),
                      if (content != null)
                        Align(
                          alignment: contentAlignment,
                          child: content!,
                        ).small(),
                    ],
                  ),
                ),
              if (trailing != null &&
                  (title != null ||
                      content != null ||
                      leading != null ||
                      subtitle != null))
                SizedBox(width: contentSpacing),
              // if (trailing != null) trailing!,
              if (trailing != null)
                Align(
                  alignment: trailingAlignment,
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Same as basic, but without forcing the text style
class BasicLayout extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? trailing;
  final AlignmentGeometry? leadingAlignment;
  final AlignmentGeometry? trailingAlignment;
  final AlignmentGeometry? titleAlignment;
  final AlignmentGeometry? subtitleAlignment;
  final AlignmentGeometry? contentAlignment;
  final double? contentSpacing;
  final double? titleSpacing;
  final BoxConstraints? constraints;

  const BasicLayout({
    super.key,
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
    this.contentSpacing,
    this.titleSpacing,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<BasicTheme>(context);
    final contentSpacing = styleValue(
        widgetValue: this.contentSpacing,
        themeValue: compTheme?.contentSpacing,
        defaultValue: 16 * scaling);
    final titleSpacing = styleValue(
        widgetValue: this.titleSpacing,
        themeValue: compTheme?.titleSpacing,
        defaultValue: 4 * scaling);
    final leadingAlignment = styleValue(
        widgetValue: this.leadingAlignment,
        themeValue: compTheme?.leadingAlignment,
        defaultValue: Alignment.topCenter);
    final trailingAlignment = styleValue(
        widgetValue: this.trailingAlignment,
        themeValue: compTheme?.trailingAlignment,
        defaultValue: Alignment.topCenter);
    final titleAlignment = styleValue(
        widgetValue: this.titleAlignment,
        themeValue: compTheme?.titleAlignment,
        defaultValue: Alignment.topLeft);
    final subtitleAlignment = styleValue(
        widgetValue: this.subtitleAlignment,
        themeValue: compTheme?.subtitleAlignment,
        defaultValue: Alignment.topLeft);
    final contentAlignment = styleValue(
        widgetValue: this.contentAlignment,
        themeValue: compTheme?.contentAlignment,
        defaultValue: Alignment.topLeft);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null)
          Align(
            alignment: leadingAlignment,
            child: leading!,
          ),
        if (leading != null &&
            (title != null || content != null || subtitle != null))
          SizedBox(width: contentSpacing),
        if (title != null || content != null || subtitle != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Align(
                    alignment: titleAlignment,
                    child: title!,
                  ),
                if (title != null && subtitle != null)
                  SizedBox(height: 2 * scaling),
                if (subtitle != null)
                  Align(
                    alignment: subtitleAlignment,
                    child: subtitle!,
                  ),
                if ((title != null || subtitle != null) && content != null)
                  SizedBox(height: titleSpacing),
                if (content != null)
                  Align(
                    alignment: contentAlignment,
                    child: content!,
                  ),
              ],
            ),
          ),
        if (trailing != null &&
            (title != null ||
                content != null ||
                leading != null ||
                subtitle != null))
          SizedBox(width: contentSpacing),
        if (trailing != null)
          Align(
            alignment: trailingAlignment,
            child: trailing!,
          ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  final Widget? leading;
  final Widget child;
  final Widget? trailing;

  const Label({
    super.key,
    this.leading,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          if (leading != null) SizedBox(width: 8 * scaling),
          Expanded(child: child),
          if (trailing != null) SizedBox(width: 8 * scaling),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
