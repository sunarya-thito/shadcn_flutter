---
title: "Class: MultipleChoice"
description: "A widget for single-selection choice scenarios."
---

```dart
/// A widget for single-selection choice scenarios.
///
/// [MultipleChoice] manages a single selected value from multiple options.
/// It prevents multiple selections and optionally allows deselecting the
/// current choice by clicking it again.
///
/// This widget is typically used with choice items like [ChoiceChip] or
/// [ChoiceButton] which integrate with the inherited [Choice] data.
///
/// Example:
/// ```dart
/// MultipleChoice<String>(
///   value: selectedOption,
///   onChanged: (value) => setState(() => selectedOption = value),
///   child: Wrap(
///     children: [
///       ChoiceChip(value: 'A', child: Text('Option A')),
///       ChoiceChip(value: 'B', child: Text('Option B')),
///     ],
///   ),
/// )
/// ```
class MultipleChoice<T> extends StatefulWidget {
  /// The child widget tree containing choice items.
  final Widget child;
  /// The currently selected value.
  final T? value;
  /// Callback when the selection changes.
  final ValueChanged<T?>? onChanged;
  /// Whether choices are enabled.
  final bool? enabled;
  /// Whether the current selection can be unselected.
  final bool? allowUnselect;
  /// Creates a [MultipleChoice].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget tree with choice items.
  /// - [value] (`T?`, optional): Currently selected value.
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Selection callback.
  /// - [enabled] (`bool?`, optional): Whether choices are enabled.
  /// - [allowUnselect] (`bool?`, optional): Allow deselecting the current choice.
  const MultipleChoice({super.key, required this.child, this.value, this.onChanged, this.enabled, this.allowUnselect});
  State<MultipleChoice<T>> createState();
}
```
