---
title: "Class: InputCopyFeature"
description: "Reference for InputCopyFeature"
---

```dart
class InputCopyFeature extends InputFeature {
  final InputFeaturePosition position;
  final Widget? icon;
  const InputCopyFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
