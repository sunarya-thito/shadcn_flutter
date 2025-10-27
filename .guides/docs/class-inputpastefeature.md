---
title: "Class: InputPasteFeature"
description: "Reference for InputPasteFeature"
---

```dart
class InputPasteFeature extends InputFeature {
  final InputFeaturePosition position;
  final Widget? icon;
  const InputPasteFeature({super.visibility, super.skipFocusTraversal, this.position = InputFeaturePosition.trailing, this.icon});
  InputFeatureState createState();
}
```
