---
title: "Class: InputHintFeature"
description: "Reference for InputHintFeature"
---

```dart
class InputHintFeature extends InputFeature {
  final WidgetBuilder popupBuilder;
  final Widget? icon;
  final InputFeaturePosition position;
  final bool enableShortcuts;
  const InputHintFeature({super.visibility, super.skipFocusTraversal, required this.popupBuilder, this.position = InputFeaturePosition.trailing, this.icon, this.enableShortcuts = true});
  InputFeatureState createState();
}
```
