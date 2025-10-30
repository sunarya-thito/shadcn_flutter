---
title: "Class: ChipButton"
description: "Specialized button component designed for use within chips."
---

```dart
/// Specialized button component designed for use within chips.
///
/// A compact button widget optimized for use as leading or trailing elements
/// within [Chip] widgets. Provides consistent styling and behavior for
/// interactive chip elements like close buttons or action triggers.
///
/// Example:
/// ```dart
/// ChipButton(
///   onPressed: () => removeItem(item),
///   child: Icon(Icons.close, size: 14),
/// );
/// ```
class ChipButton extends StatelessWidget {
  /// The widget to display as the button content.
  final Widget child;
  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;
  /// Creates a chip button with the specified child and callback.
  const ChipButton({super.key, required this.child, this.onPressed});
  Widget build(BuildContext context);
}
```
