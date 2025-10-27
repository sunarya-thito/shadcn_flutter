---
title: "Class: InputSpinnerFeature"
description: "Reference for InputSpinnerFeature"
---

```dart
class InputSpinnerFeature extends InputFeature {
  final double step;
  final bool enableGesture;
  final double? invalidValue;
  const InputSpinnerFeature({super.visibility, super.skipFocusTraversal, this.step = 1.0, this.enableGesture = true, this.invalidValue = 0.0});
  InputFeatureState createState();
}
```
