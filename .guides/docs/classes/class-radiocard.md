---
title: "Class: RadioCard"
description: "A card-style radio button with custom content.   Provides a larger, card-like selection area within a [RadioGroup]."
---

```dart
/// A card-style radio button with custom content.
///
/// Provides a larger, card-like selection area within a [RadioGroup].
class RadioCard<T> extends StatefulWidget {
  /// The child widget displayed in the card.
  final Widget child;
  /// The value represented by this radio card.
  final T value;
  /// Whether this radio card is enabled.
  final bool enabled;
  /// Whether the selected card uses a filled background.
  ///
  /// When true, the selected card fills with 50% opacity of the primary color.
  final bool filled;
  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;
  /// Creates a radio card.
  const RadioCard({super.key, required this.child, required this.value, this.enabled = true, this.filled = false, this.focusNode});
  State<RadioCard<T>> createState();
}
```
