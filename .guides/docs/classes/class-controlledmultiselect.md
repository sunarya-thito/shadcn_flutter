---
title: "Class: ControlledMultiSelect"
description: "Reactive multi-selection dropdown with automatic state management."
---

```dart
/// Reactive multi-selection dropdown with automatic state management.
///
/// A high-level multi-select widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for item presentation,
/// selection behavior, and popup management.
///
/// ## Features
///
/// - **Multiple selection**: Select and deselect multiple items simultaneously
/// - **Flexible item rendering**: Custom builders for complete visual control over items
/// - **Selection indicators**: Built-in checkboxes or custom selection indicators
/// - **Popup positioning**: Configurable alignment and constraints for the dropdown
/// - **Keyboard navigation**: Full keyboard support with Space for selection toggle
/// - **Form integration**: Automatic validation and form field registration
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = MultiSelectController<String>(['apple']);
///
/// ControlledMultiSelect<String>(
///   controller: controller,
///   items: ['apple', 'banana', 'cherry', 'date'],
///   itemBuilder: (context, item, selected) => ListTile(
///     leading: Checkbox(value: selected),
///     title: Text(item),
///   ),
///   placeholder: Text('Choose fruits'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// List<String> selectedFruits = [];
///
/// ControlledMultiSelect<String>(
///   initialValue: selectedFruits,
///   onChanged: (fruits) => setState(() => selectedFruits = fruits?.toList() ?? []),
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item, selected) => Text(item),
/// )
/// ```
class ControlledMultiSelect<T> extends StatelessWidget with ControlledComponent<Iterable<T>?>, SelectBase<Iterable<T>> {
  final Iterable<T>? initialValue;
  final ValueChanged<Iterable<T>?>? onChanged;
  final bool enabled;
  final MultiSelectController<T>? controller;
  final Widget? placeholder;
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool autoClosePopover;
  final SelectPopupBuilder popup;
  SelectValueBuilder<Iterable<T>> get itemBuilder;
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  final Predicate<Iterable<T>>? showValuePredicate;
  /// Builder for rendering individual items in multi-select mode.
  final SelectValueBuilder<T> multiItemBuilder;
  /// Creates a [ControlledMultiSelect].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with multiple item selection capabilities.
  ///
  /// Parameters:
  /// - [controller] (`MultiSelectController<T>?`, optional): external state controller
  /// - [initialValue] (`Iterable<T>?`, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether select is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no items selected
  /// - [filled] (bool, default: false): whether to use filled appearance
  /// - [focusNode] (FocusNode?, optional): custom focus node for keyboard handling
  /// - [constraints] (BoxConstraints?, optional): size constraints for select widget
  /// - [popupConstraints] (BoxConstraints?, optional): size constraints for popup
  /// - [popupWidthConstraint] (PopoverConstraint, default: anchorFixedSize): popup width behavior
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override select border radius
  /// - [padding] (EdgeInsetsGeometry?, optional): override internal padding
  /// - [popoverAlignment] (AlignmentGeometry, default: topCenter): popup alignment
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): anchor alignment
  /// - [disableHoverEffect] (bool, default: false): disable item hover effects
  /// - [canUnselect] (bool, default: false): allow deselecting all items
  /// - [autoClosePopover] (bool, default: false): close popup after each selection
  /// - [popup] (SelectPopupBuilder, required): builder for popup content
  /// - [itemBuilder] (`SelectItemBuilder<T>`, required): builder for individual items
  /// - [multiItemBuilder] (`SelectValueBuilder<T>`, required): builder for selected items display
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<Iterable<T>>?`, optional): custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<Iterable<T>>?`, optional): selection validation
  /// - [showValuePredicate] (`Predicate<Iterable<T>>?`, optional): visibility filter for values
  ///
  /// Example:
  /// ```dart
  /// ControlledMultiSelect<String>(
  ///   controller: controller,
  ///   popup: (context, items) => ListView(children: items),
  ///   itemBuilder: (context, item, selected) => CheckboxListTile(
  ///     value: selected,
  ///     title: Text(item),
  ///   ),
  ///   multiItemBuilder: (context, items) => Wrap(
  ///     children: items.map((item) => Chip(label: Text(item))).toList(),
  ///   ),
  /// )
  /// ```
  const ControlledMultiSelect({super.key, this.controller, this.onChanged, this.enabled = true, this.initialValue, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.popupWidthConstraint = PopoverConstraint.anchorFixedSize, this.borderRadius, this.padding, this.popoverAlignment = Alignment.topCenter, this.popoverAnchorAlignment, this.disableHoverEffect = false, this.canUnselect = true, this.autoClosePopover = false, this.showValuePredicate, required this.popup, required SelectValueBuilder<T> itemBuilder, this.valueSelectionHandler, this.valueSelectionPredicate});
  Widget build(BuildContext context);
}
```
