---
title: "Class: InputFeature"
description: "Reference for InputFeature"
---

```dart
abstract class InputFeature {
  factory InputFeature.hint({InputFeatureVisibility visibility, required WidgetBuilder popupBuilder, Widget? icon, InputFeaturePosition position, bool enableShortcuts, bool skipFocusTraversal});
  factory InputFeature.passwordToggle({InputFeatureVisibility visibility, PasswordPeekMode mode, InputFeaturePosition position, Widget? icon, Widget? iconShow, bool skipFocusTraversal});
  factory InputFeature.clear({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  factory InputFeature.revalidate({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  factory InputFeature.autoComplete({InputFeatureVisibility visibility, required SuggestionBuilder querySuggestions, required Widget child, BoxConstraints? popoverConstraints, PopoverConstraint? popoverWidthConstraint, AlignmentDirectional? popoverAnchorAlignment, AlignmentDirectional? popoverAlignment, AutoCompleteMode mode, bool skipFocusTraversal});
  factory InputFeature.spinner({InputFeatureVisibility visibility, double step, bool enableGesture, double? invalidValue, bool skipFocusTraversal});
  factory InputFeature.copy({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  factory InputFeature.paste({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  factory InputFeature.leading(Widget child, {InputFeatureVisibility visibility, bool skipFocusTraversal});
  factory InputFeature.trailing(Widget child, {InputFeatureVisibility visibility, bool skipFocusTraversal});
  final InputFeatureVisibility visibility;
  final bool skipFocusTraversal;
  const InputFeature({this.visibility = InputFeatureVisibility.always, this.skipFocusTraversal = true});
  InputFeatureState createState();
  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature);
}
```
