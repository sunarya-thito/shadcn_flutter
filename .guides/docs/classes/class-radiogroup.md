---
title: "Class: RadioGroup"
description: "A group of radio buttons for single-selection input."
---

```dart
/// A group of radio buttons for single-selection input.
///
/// Manages the selection state and provides context for child radio items.
class RadioGroup<T> extends StatefulWidget {
  /// The child widget containing radio items.
  final Widget child;
  /// The currently selected value.
  final T? value;
  /// Callback invoked when the selection changes.
  final ValueChanged<T>? onChanged;
  /// Whether the radio group is enabled.
  final bool? enabled;
  /// Creates a radio group.
  const RadioGroup({super.key, required this.child, this.value, this.onChanged, this.enabled});
  RadioGroupState<T> createState();
}
```
