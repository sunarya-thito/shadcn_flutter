---
title: "Class: BasicLayout"
description: "Same as basic, but without forcing the text style"
---

```dart
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
  const BasicLayout({super.key, this.leading, this.title, this.subtitle, this.content, this.trailing, this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.constraints});
  Widget build(BuildContext context);
}
```
