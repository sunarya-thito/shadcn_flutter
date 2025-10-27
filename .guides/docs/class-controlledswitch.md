---
title: "Class: ControlledSwitch"
description: "Reference for ControlledSwitch"
---

```dart
class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final SwitchController? controller;
  final Widget? leading;
  final Widget? trailing;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final BorderRadiusGeometry? borderRadius;
  const ControlledSwitch({super.key, this.controller, this.initialValue = false, this.onChanged, this.enabled = true, this.leading, this.trailing, this.gap, this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.borderRadius});
  Widget build(BuildContext context);
}
```
