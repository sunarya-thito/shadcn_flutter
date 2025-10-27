---
title: "Class: InputAutoCompleteFeature"
description: "Reference for InputAutoCompleteFeature"
---

```dart
class InputAutoCompleteFeature extends InputFeature {
  final SuggestionBuilder querySuggestions;
  final Widget child;
  final BoxConstraints? popoverConstraints;
  final PopoverConstraint? popoverWidthConstraint;
  final AlignmentDirectional? popoverAnchorAlignment;
  final AlignmentDirectional? popoverAlignment;
  final AutoCompleteMode mode;
  const InputAutoCompleteFeature({super.visibility, super.skipFocusTraversal, required this.querySuggestions, required this.child, this.popoverConstraints, this.popoverWidthConstraint, this.popoverAnchorAlignment, this.popoverAlignment, this.mode = AutoCompleteMode.replaceWord});
  InputFeatureState createState();
}
```
