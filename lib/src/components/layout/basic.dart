import '../../../shadcn_flutter.dart';

/// Theme configuration for [Basic] layout widgets.
///
/// Defines default alignment, spacing, and padding properties for Basic
/// layout components. These properties control how leading, trailing, title,
/// subtitle, and content elements are positioned and spaced.
class BasicTheme {
  /// Alignment for the leading widget.
  final AlignmentGeometry? leadingAlignment;

  /// Alignment for the trailing widget.
  final AlignmentGeometry? trailingAlignment;

  /// Alignment for the title widget.
  final AlignmentGeometry? titleAlignment;

  /// Alignment for the subtitle widget.
  final AlignmentGeometry? subtitleAlignment;

  /// Alignment for the content widget.
  final AlignmentGeometry? contentAlignment;

  /// Spacing between content elements.
  final double? contentSpacing;

  /// Spacing between title and subtitle.
  final double? titleSpacing;

  /// Main axis alignment for the overall layout.
  final MainAxisAlignment? mainAxisAlignment;

  /// Padding around the entire Basic widget.
  final EdgeInsetsGeometry? padding;

  /// Creates a [BasicTheme].
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

  /// Creates a copy of this theme with the given fields replaced.
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
      trailingAlignment: trailingAlignment == null
          ? this.trailingAlignment
          : trailingAlignment(),
      titleAlignment:
          titleAlignment == null ? this.titleAlignment : titleAlignment(),
      subtitleAlignment: subtitleAlignment == null
          ? this.subtitleAlignment
          : subtitleAlignment(),
      contentAlignment:
          contentAlignment == null ? this.contentAlignment : contentAlignment(),
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

/// A versatile layout widget for arranging leading, title, subtitle, content, and trailing elements.
///
/// Provides a flexible row-based layout commonly used for list items, cards, or
/// any UI requiring a structured arrangement of multiple content sections. Each
/// section can be independently aligned and spaced.
///
/// Example:
/// ```dart
/// Basic(
///   leading: Icon(Icons.person),
///   title: Text('John Doe'),
///   subtitle: Text('john@example.com'),
///   trailing: Icon(Icons.chevron_right),
/// )
/// ```
class Basic extends StatelessWidget {
  /// Leading widget, typically an icon or avatar.
  final Widget? leading;

  /// Primary title widget.
  final Widget? title;

  /// Secondary subtitle widget, displayed below title.
  final Widget? subtitle;

  /// Main content widget, displayed below title/subtitle.
  final Widget? content;

  /// Trailing widget, typically an icon or action button.
  final Widget? trailing;

  /// Alignment for the [leading] widget.
  final AlignmentGeometry? leadingAlignment;

  /// Alignment for the [trailing] widget.
  final AlignmentGeometry? trailingAlignment;

  /// Alignment for the [title] widget.
  final AlignmentGeometry? titleAlignment;

  /// Alignment for the [subtitle] widget.
  final AlignmentGeometry? subtitleAlignment;

  /// Alignment for the [content] widget.
  final AlignmentGeometry? contentAlignment;

  /// Spacing between content elements (default: 16).
  final double? contentSpacing;

  /// Spacing between title and subtitle (default: 4).
  final double? titleSpacing;

  /// Main axis alignment for the overall layout.
  final MainAxisAlignment? mainAxisAlignment;

  /// Padding around the entire widget.
  final EdgeInsetsGeometry? padding;

  /// Creates a [Basic] layout widget.
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

/// Same as [Basic], but without forcing text styles.
///
/// Provides the same layout structure as [Basic] but doesn't apply default
/// text styling to title and subtitle elements. Use this when you need full
/// control over text appearance.
///
/// Example:
/// ```dart
/// BasicLayout(
///   leading: Icon(Icons.star),
///   title: Text('Custom styled title', style: myStyle),
///   subtitle: Text('Custom styled subtitle', style: myStyle),
/// )
/// ```
class BasicLayout extends StatelessWidget {
  /// Leading widget, typically an icon or avatar.
  final Widget? leading;

  /// Primary title widget.
  final Widget? title;

  /// Secondary subtitle widget, displayed below title.
  final Widget? subtitle;

  /// Main content widget, displayed below title/subtitle.
  final Widget? content;

  /// Trailing widget, typically an icon or action button.
  final Widget? trailing;

  /// Alignment for the [leading] widget.
  final AlignmentGeometry? leadingAlignment;

  /// Alignment for the [trailing] widget.
  final AlignmentGeometry? trailingAlignment;

  /// Alignment for the [title] widget.
  final AlignmentGeometry? titleAlignment;

  /// Alignment for the [subtitle] widget.
  final AlignmentGeometry? subtitleAlignment;

  /// Alignment for the [content] widget.
  final AlignmentGeometry? contentAlignment;

  /// Spacing between content elements.
  final double? contentSpacing;

  /// Spacing between title and subtitle.
  final double? titleSpacing;

  /// Size constraints for the layout.
  final BoxConstraints? constraints;

  /// Creates a [BasicLayout] widget.
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

/// A layout widget for labels with optional leading and trailing elements.
///
/// Arranges a main label with optional leading and trailing widgets in a
/// horizontal layout with consistent spacing.
///
/// Example:
/// ```dart
/// Label(
///   leading: Icon(Icons.person),
///   child: Text('Name'),
///   trailing: Icon(Icons.edit),
/// )
/// ```
class Label extends StatelessWidget {
  /// Optional leading widget displayed before the label.
  final Widget? leading;

  /// The main label content.
  final Widget child;

  /// Optional trailing widget displayed after the label.
  final Widget? trailing;

  /// Creates a [Label].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Main label content.
  /// - [leading] (`Widget?`, optional): Leading widget.
  /// - [trailing] (`Widget?`, optional): Trailing widget.
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
