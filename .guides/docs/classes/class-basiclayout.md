---
title: "Class: BasicLayout"
description: "Same as [Basic], but without forcing text styles."
---

```dart
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
  const BasicLayout({super.key, this.leading, this.title, this.subtitle, this.content, this.trailing, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.constraints});
  Widget build(BuildContext context);
}
```
