import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for [MultipleChoice] and [MultipleAnswer].
class MultipleChoiceTheme {
  /// Whether selections can be unselected.
  final bool? allowUnselect;

  /// Creates a [MultipleChoiceTheme].
  const MultipleChoiceTheme({this.allowUnselect});

  /// Returns a copy of this theme with the given fields replaced by the
  /// non-null parameters.
  MultipleChoiceTheme copyWith({ValueGetter<bool?>? allowUnselect}) {
    return MultipleChoiceTheme(
      allowUnselect:
          allowUnselect == null ? this.allowUnselect : allowUnselect(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MultipleChoiceTheme && other.allowUnselect == allowUnselect;

  @override
  int get hashCode => allowUnselect.hashCode;

  @override
  String toString() => 'MultipleChoiceTheme(allowUnselect: $allowUnselect)';
}

/// A mixin that provides choice selection functionality.
///
/// [Choice] defines the interface for widgets that support item selection,
/// typically used in multiple choice or single choice scenarios. It provides
/// static methods to interact with choice widgets in the widget tree.
mixin Choice<T> {
  /// Selects an item in the nearest [Choice] ancestor.
  ///
  /// Parameters:
  /// - [context]: The build context to search for Choice widget.
  /// - [item]: The item to select.
  static void choose<T>(BuildContext context, T item) {
    Data.of<Choice<T>>(context).selectItem(item);
  }

  /// Gets the current selected value(s) from the nearest [Choice] ancestor.
  ///
  /// Returns: The currently selected items, or null if none selected.
  static Iterable<T>? getValue<T>(BuildContext context) {
    return Data.of<Choice<T>>(context).value;
  }

  /// Selects the specified item.
  void selectItem(T item);

  /// Gets the currently selected items.
  Iterable<T>? get value;
}

/// A controller for managing [ControlledMultipleAnswer] selections programmatically.
///
/// This controller extends `ValueNotifier<Iterable<T>?>` to provide reactive
/// state management for multiple selection components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to selection changes.
///
/// Example:
/// ```dart
/// final controller = MultipleAnswerController<String>(['option1', 'option2']);
/// controller.addListener(() {
///   print('Selected items: ${controller.value}');
/// });
/// ```
class MultipleAnswerController<T> extends ValueNotifier<Iterable<T>?>
    with ComponentController<Iterable<T>?> {
  /// Creates a [MultipleAnswerController] with an optional initial selection.
  ///
  /// Parameters:
  /// - [value] (`Iterable<T>?`, optional): Initial selection of items
  MultipleAnswerController([super.value]);
}

/// A controller for managing [ControlledMultipleChoice] selection programmatically.
///
/// This controller extends `ValueNotifier<T?>` to provide reactive state
/// management for single-choice components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to selection changes.
///
/// Example:
/// ```dart
/// final controller = MultipleChoiceController<String>('option1');
/// controller.addListener(() {
///   print('Selected item: ${controller.value}');
/// });
/// ```
class MultipleChoiceController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  /// Creates a [MultipleChoiceController] with an optional initial selection.
  ///
  /// Parameters:
  /// - [value] (T?, optional): Initial selected item
  MultipleChoiceController([super.value]);
}

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
class ControlledMultipleAnswer<T> extends StatelessWidget
    with ControlledComponent<Iterable<T>?> {
  @override
  final MultipleAnswerController<T>? controller;
  @override
  final Iterable<T>? initialValue;
  @override
  final ValueChanged<Iterable<T>?>? onChanged;
  @override
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
  const ControlledMultipleAnswer({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.allowUnselect,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<Iterable<T>?>(
      builder: (context, data) {
        return MultipleAnswer<T>(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          allowUnselect: allowUnselect,
          child: child,
        );
      },
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

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
class ControlledMultipleChoice<T> extends StatelessWidget
    with ControlledComponent<T?> {
  @override
  final MultipleChoiceController<T>? controller;
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  @override
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
  const ControlledMultipleChoice({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.allowUnselect,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<T?>(
      builder: (context, data) {
        return MultipleChoice<T>(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          allowUnselect: allowUnselect,
          child: child,
        );
      },
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

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
  const MultipleChoice({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
    this.allowUnselect,
  });

  @override
  State<MultipleChoice<T>> createState() => _MultipleChoiceState<T>();
}

class _MultipleChoiceState<T> extends State<MultipleChoice<T>>
    with Choice<T>, FormValueSupplier<T?, MultipleChoice<T>> {
  @override
  void didReplaceFormValue(T? value) {
    widget.onChanged?.call(value);
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<Choice<T>>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void selectItem(T item) {
    if (widget.enabled == false) {
      return;
    }
    if (widget.value != null && widget.value != item) {
      return;
    }
    if (widget.onChanged != null) {
      if (widget.value == item) {
        if (_allowUnselect) {
          widget.onChanged?.call(null);
        }
      } else {
        widget.onChanged?.call(item);
      }
    }
  }

  @override
  Iterable<T>? get value {
    T? value = widget.value;
    if (value == null) {
      return null;
    }
    return [value];
  }

  bool get _allowUnselect {
    final theme = ComponentTheme.maybeOf<MultipleChoiceTheme>(context);
    return widget.allowUnselect ?? theme?.allowUnselect ?? false;
  }
}

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
  const MultipleAnswer({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
    this.allowUnselect,
  });

  @override
  State<MultipleAnswer<T>> createState() => _MultipleAnswerState<T>();
}

class _MultipleAnswerState<T> extends State<MultipleAnswer<T>>
    with Choice<T>, FormValueSupplier<Iterable<T>, MultipleAnswer<T>> {
  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleAnswer<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<Choice<T>>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void selectItem(T item) {
    if (widget.enabled == false) {
      return;
    }
    var value = widget.value;
    if (value == null) {
      widget.onChanged?.call([item]);
    } else if (value.contains(item)) {
      if (_allowUnselect) {
        widget.onChanged?.call(value.where((e) => e != item));
      }
    } else {
      widget.onChanged?.call(value.followedBy([item]));
    }
  }

  @override
  Iterable<T>? get value {
    return widget.value;
  }

  @override
  void didReplaceFormValue(Iterable<T>? value) {
    widget.onChanged?.call(value);
  }

  bool get _allowUnselect {
    final theme = ComponentTheme.maybeOf<MultipleChoiceTheme>(context);
    return widget.allowUnselect ?? theme?.allowUnselect ?? true;
  }
}
