---
title: "Class: Switch"
description: "Reference for Switch"
---

```dart
class Switch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool? enabled;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final BorderRadiusGeometry? borderRadius;
  const Switch({super.key, required this.value, required this.onChanged, this.leading, this.trailing, this.enabled = true, this.gap, this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.borderRadius});
  State<Switch> createState();
}
```
