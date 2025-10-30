---
title: "Class: MultipleAnswer"
description: "A widget for multiple-selection choice scenarios."
---

```dart
/// A widget for multiple-selection choice scenarios.
///
/// [MultipleAnswer] manages multiple selected values from a set of options.
/// It allows users to select and deselect multiple items independently.
///
/// This widget is typically used with choice items like [ChoiceChip] or
/// [ChoiceButton] which integrate with the inherited [Choice] data.
///
/// Example:
/// ```dart
/// MultipleAnswer<String>(
///   value: selectedOptions,
///   onChanged: (values) => setState(() => selectedOptions = values),
///   child: Wrap(
///     children: [
///       ChoiceChip(value: 'A', child: Text('Option A')),
///       ChoiceChip(value: 'B', child: Text('Option B')),
///       ChoiceChip(value: 'C', child: Text('Option C')),
///     ],
///   ),
/// )
/// ```
class MultipleAnswer<T> extends StatefulWidget {
  /// The child widget tree containing choice items.
  final Widget child;
  /// The currently selected values.
  final Iterable<T>? value;
  /// Callback when the selection changes.
  final ValueChanged<Iterable<T>?>? onChanged;
  /// Whether choices are enabled.
  final bool? enabled;
  /// Whether all selections can be unselected.
  final bool? allowUnselect;
  /// Creates a [MultipleAnswer].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget tree with choice items.
  /// - [value] (`Iterable<T>?`, optional): Currently selected values.
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`, optional): Selection callback.
  /// - [enabled] (`bool?`, optional): Whether choices are enabled.
  /// - [allowUnselect] (`bool?`, optional): Allow deselecting all choices.
  const MultipleAnswer({super.key, required this.child, this.value, this.onChanged, this.enabled, this.allowUnselect});
  State<MultipleAnswer<T>> createState();
}
```
