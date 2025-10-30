---
title: "Class: ControlledMultipleAnswer"
description: "A controlled widget for managing multiple item selections with external state management."
---

```dart
/// A controlled widget for managing multiple item selections with external state management.
///
/// This widget provides a container for multiple selection interfaces where users
/// can select multiple items from a set of choices. It integrates with the controlled
/// component system to provide external state management, form integration, and
/// programmatic control of selections.
///
/// The component maintains a collection of selected items and provides callbacks
/// for selection changes. Child widgets can use the [Choice.choose] method to
/// register item selections and [Choice.getValue] to access current selections.
///
/// Example:
/// ```dart
/// ControlledMultipleAnswer<String>(
///   initialValue: ['apple', 'banana'],
///   onChanged: (selections) {
///     print('Selected: ${selections?.join(', ')}');
///   },
///   child: Column(
///     children: [
///       ChoiceItem(value: 'apple', child: Text('Apple')),
///       ChoiceItem(value: 'banana', child: Text('Banana')),
///       ChoiceItem(value: 'orange', child: Text('Orange')),
///     ],
///   ),
/// );
/// ```
class ControlledMultipleAnswer<T> extends StatelessWidget with ControlledComponent<Iterable<T>?> {
  final MultipleAnswerController<T>? controller;
  final Iterable<T>? initialValue;
  final ValueChanged<Iterable<T>?>? onChanged;
  final bool enabled;
  /// Whether selected items can be deselected by selecting them again.
  ///
  /// When true, users can toggle selections by clicking selected items to
  /// deselect them. When false, items remain selected once chosen.
  final bool? allowUnselect;
  /// The widget subtree containing selectable choice items.
  ///
  /// Child widgets should provide choice items that use [Choice.choose]
  /// to register selections and [Choice.getValue] to access current state.
  final Widget child;
  /// Creates a [ControlledMultipleAnswer].
  ///
  /// Either [controller] or [initialValue] should be provided to establish
  /// the initial selection state. The [child] should contain choice items
  /// that integrate with the multiple selection system.
  ///
  /// Parameters:
  /// - [controller] (`MultipleAnswerController<T>?`, optional): External controller for programmatic control
  /// - [initialValue] (`Iterable<T>?`, optional): Initial selection when no controller provided
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`, optional): Callback for selection changes
  /// - [enabled] (bool, default: true): Whether selections can be modified
  /// - [allowUnselect] (bool?, optional): Whether items can be deselected by re-selection
  /// - [child] (Widget, required): Container with selectable choice items
  ///
  /// Example:
  /// ```dart
  /// ControlledMultipleAnswer<int>(
  ///   initialValue: [1, 3],
  ///   allowUnselect: true,
  ///   onChanged: (values) => print('Selected: $values'),
  ///   child: ChoiceList(items: [1, 2, 3, 4, 5]),
  /// );
  /// ```
  const ControlledMultipleAnswer({super.key, this.controller, this.onChanged, this.initialValue, this.enabled = true, this.allowUnselect, required this.child});
  Widget build(BuildContext context);
}
```
