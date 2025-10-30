---
title: "Class: Basic"
description: "A versatile layout widget for arranging leading, title, subtitle, content, and trailing elements."
---

```dart
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
  const Basic({super.key, this.leading, this.title, this.subtitle, this.content, this.trailing, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.mainAxisAlignment, this.padding});
  Widget build(BuildContext context);
}
```
