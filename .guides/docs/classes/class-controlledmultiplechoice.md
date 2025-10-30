---
title: "Class: ControlledMultipleChoice"
description: "A controlled widget for managing single item selection with external state management."
---

```dart
/// A controlled widget for managing single item selection with external state management.
///
/// This widget provides a container for single-choice selection interfaces where
/// users can select one item from a set of choices. It integrates with the controlled
/// component system to provide external state management, form integration, and
/// programmatic control of the selection.
///
/// The component maintains a single selected item and provides callbacks for
/// selection changes. Child widgets can use the [Choice.choose] method to
/// register item selections and [Choice.getValue] to access the current selection.
///
/// Example:
/// ```dart
/// ControlledMultipleChoice<String>(
///   initialValue: 'medium',
///   onChanged: (selection) {
///     print('Selected size: $selection');
///   },
///   child: Column(
///     children: [
///       ChoiceItem(value: 'small', child: Text('Small')),
///       ChoiceItem(value: 'medium', child: Text('Medium')),
///       ChoiceItem(value: 'large', child: Text('Large')),
///     ],
///   ),
/// );
/// ```
class ControlledMultipleChoice<T> extends StatelessWidget with ControlledComponent<T?> {
  final MultipleChoiceController<T>? controller;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  /// Whether the selected item can be deselected by selecting it again.
  ///
  /// When true, users can deselect the current selection by clicking it again,
  /// setting the value to null. When false, once an item is selected, it
  /// remains selected until another item is chosen.
  final bool? allowUnselect;
  /// The widget subtree containing selectable choice items.
  ///
  /// Child widgets should provide choice items that use [Choice.choose]
  /// to register selections and [Choice.getValue] to access current state.
  final Widget child;
  /// Creates a [ControlledMultipleChoice].
  ///
  /// Either [controller] or [initialValue] should be provided to establish
  /// the initial selection state. The [child] should contain choice items
  /// that integrate with the single selection system.
  ///
  /// Parameters:
  /// - [controller] (`MultipleChoiceController<T>?`, optional): External controller for programmatic control
  /// - [initialValue] (T?, optional): Initial selection when no controller provided
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Callback for selection changes
  /// - [enabled] (bool, default: true): Whether selection can be modified
  /// - [allowUnselect] (bool?, optional): Whether selection can be cleared by re-selection
  /// - [child] (Widget, required): Container with selectable choice items
  ///
  /// Example:
  /// ```dart
  /// ControlledMultipleChoice<Theme>(
  ///   initialValue: Theme.dark,
  ///   allowUnselect: false,
  ///   onChanged: (theme) => setAppTheme(theme),
  ///   child: ThemeSelector(),
  /// );
  /// ```
  const ControlledMultipleChoice({super.key, this.controller, this.onChanged, this.initialValue, this.enabled = true, this.allowUnselect, required this.child});
  Widget build(BuildContext context);
}
```
