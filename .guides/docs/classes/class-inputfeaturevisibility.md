---
title: "Class: InputFeatureVisibility"
description: "Reference for InputFeatureVisibility"
---

```dart
abstract class InputFeatureVisibility {
  factory InputFeatureVisibility.and(Iterable<InputFeatureVisibility> features);
  factory InputFeatureVisibility.or(Iterable<InputFeatureVisibility> features);
  factory InputFeatureVisibility.not(InputFeatureVisibility feature);
  static const InputFeatureVisibility textNotEmpty = _TextNotEmptyInputFeatureVisibility();
  static const InputFeatureVisibility textEmpty = _TextEmptyInputFeatureVisibility();
  static const InputFeatureVisibility focused = _FocusedInputFeatureVisibility();
  static const InputFeatureVisibility hovered = _HoveredInputFeatureVisibility();
  static const InputFeatureVisibility never = _NeverVisibleInputFeatureVisibility();
  static const InputFeatureVisibility always = _AlwaysVisibleInputFeatureVisibility();
  static const InputFeatureVisibility hasSelection = _HasSelectionInputFeatureVisibility();
  const InputFeatureVisibility();
  Iterable<Listenable> getDependencies(TextFieldState state);
  bool canShow(TextFieldState state);
  InputFeatureVisibility and(InputFeatureVisibility other);
  InputFeatureVisibility operator &(InputFeatureVisibility other);
  InputFeatureVisibility or(InputFeatureVisibility other);
  InputFeatureVisibility operator |(InputFeatureVisibility other);
  InputFeatureVisibility operator ~();
}
```
