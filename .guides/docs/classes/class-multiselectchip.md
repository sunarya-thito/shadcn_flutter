---
title: "Class: MultiSelectChip"
description: "Chip widget designed for multi-select contexts with automatic removal functionality."
---

```dart
/// Chip widget designed for multi-select contexts with automatic removal functionality.
///
/// A specialized chip widget that integrates with multi-select components to display
/// selected items with built-in removal capabilities. Automatically detects its
/// multi-select context and provides appropriate removal behavior.
///
/// ## Features
///
/// - **Context-aware removal**: Automatically integrates with parent multi-select state
/// - **Visual feedback**: Clear visual indication of selected state
/// - **Interactive deletion**: Built-in X button for removing selections
/// - **Consistent styling**: Matches multi-select component design patterns
/// - **Accessibility**: Full screen reader support for selection management
///
/// This widget is typically used within multi-select components to represent
/// individual selected items with the ability to remove them from the selection.
///
/// Example:
/// ```dart
/// MultiSelectChip(
///   value: 'apple',
///   child: Text('Apple'),
///   style: ButtonStyle.secondary(),
/// );
/// ```
class MultiSelectChip extends StatelessWidget {
  /// The value this chip represents in the selection.
  final Object? value;
  /// The content displayed inside the chip.
  final Widget child;
  /// The chip styling.
  final AbstractButtonStyle style;
  /// Creates a [MultiSelectChip].
  ///
  /// Designed to be used within multi-select components where it automatically
  /// integrates with the parent selection state for removal functionality.
  ///
  /// Parameters:
  /// - [value] (Object?, required): the value this chip represents in the selection
  /// - [child] (Widget, required): content displayed inside the chip
  /// - [style] (AbstractButtonStyle, default: primary): chip styling
  ///
  /// Example:
  /// ```dart
  /// MultiSelectChip(
  ///   value: user.id,
  ///   child: Row(
  ///     children: [
  ///       Avatar(user: user),
  ///       Text(user.name),
  ///     ],
  ///   ),
  ///   style: ButtonStyle.secondary(),
  /// )
  /// ```
  const MultiSelectChip({super.key, this.style = const ButtonStyle.primary(), required this.value, required this.child});
  Widget build(BuildContext context);
}
```
