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
  final Widget child;
  final VoidCallback? onPressed;
  const ChipButton({super.key, required this.child, this.onPressed});
  Widget build(BuildContext context);
}
```
