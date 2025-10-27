---
title: "Class: InputPasswordToggleFeature"
description: "Reference for InputPasswordToggleFeature"
---

```dart
class InputPasswordToggleFeature extends InputFeature {
  final PasswordPeekMode mode;
  final InputFeaturePosition position;
  final Widget? icon;
  final Widget? iconShow;
  const InputPasswordToggleFeature({super.visibility, this.icon, this.iconShow, this.mode = PasswordPeekMode.toggle, this.position = InputFeaturePosition.trailing, super.skipFocusTraversal});
  InputFeatureState createState();
}
```
