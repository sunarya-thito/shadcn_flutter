---
title: "Class: VerticalDivider"
description: "Reference for VerticalDivider"
---

```dart
class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const VerticalDivider({super.key, this.color, this.width, this.thickness, this.indent, this.endIndent, this.child, this.padding = const EdgeInsets.symmetric(vertical: 8)});
  Size get preferredSize;
  Widget build(BuildContext context);
}
```
