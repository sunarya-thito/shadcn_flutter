---
title: "Class: MultiSelect"
description: "A customizable dropdown selection widget for multi-value selection."
---

```dart
/// A customizable dropdown selection widget for multi-value selection.
///
/// Extends the base select functionality to support selecting multiple items
/// simultaneously. Displays selected items as removable chips within the trigger.
///
/// Example:
/// ```dart
/// MultiSelect<String>(
///   value: selectedItems,
///   onChanged: (items) => setState(() => selectedItems = items),
///   popup: SelectPopup.menu(children: [...]),
///   multiItemBuilder: (context, item) => Text(item),
/// )
/// ```
class MultiSelect<T> extends StatelessWidget with SelectBase<Iterable<T>> {
  final ValueChanged<Iterable<T>?>? onChanged;
  final Widget? placeholder;
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  /// The currently selected values.
  final Iterable<T>? value;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool? autoClosePopover;
  /// Whether the multi-select is enabled for user interaction.
  final bool? enabled;
  final SelectPopupBuilder popup;
  SelectValueBuilder<Iterable<T>> get itemBuilder;
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  /// Builder for rendering individual items in the chip display.
  final SelectValueBuilder<T> multiItemBuilder;
  final Predicate<Iterable<T>>? showValuePredicate;
  /// Creates a multi-selection dropdown widget.
  ///
  /// Allows selecting multiple items from a dropdown list, displaying them as chips.
  /// The [value], [popup], and [itemBuilder] parameters are required.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget key for controlling widget identity
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`): Callback when selection changes; if null, widget is disabled
  /// - [placeholder] (Widget?): Widget shown when no values are selected
  /// - [filled] (bool): Whether to use filled background style, defaults to false
  /// - [focusNode] (FocusNode?): Focus node for keyboard interaction
  /// - [constraints] (BoxConstraints?): Size constraints for the select button
  /// - [popupConstraints] (BoxConstraints?): Size constraints for the popup menu
  /// - [popupWidthConstraint] (PopoverConstraint): Width constraint mode for popup, defaults to `PopoverConstraint.anchorFixedSize`
  /// - [value] (`Iterable<T>`): Required currently selected values
  /// - [disableHoverEffect] (bool): Whether to disable hover visual feedback, defaults to false
  /// - [borderRadius] (BorderRadiusGeometry?): Custom border radius
  /// - [padding] (EdgeInsetsGeometry?): Custom padding
  /// - [popoverAlignment] (AlignmentGeometry): Popup alignment, defaults to `Alignment.topCenter`
  /// - [popoverAnchorAlignment] (AlignmentGeometry?): Anchor alignment for popup positioning
  /// - [canUnselect] (bool): Whether user can deselect items, defaults to true
  /// - [autoClosePopover] (bool?): Whether popup closes after selection, defaults to false
  /// - [enabled] (bool?): Whether multi-select is enabled for interaction
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<Iterable<T>>?`): Custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<Iterable<T>>?`): Predicate for allowing selection
  /// - [showValuePredicate] (`Predicate<Iterable<T>>?`): Predicate for showing items
  /// - [popup] (SelectPopupBuilder): Required builder for popup content
  /// - [itemBuilder] (`SelectValueBuilder<T>`): Required builder for individual chip items
  const MultiSelect({super.key, this.onChanged, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.popupWidthConstraint = PopoverConstraint.anchorFixedSize, required this.value, this.disableHoverEffect = false, this.borderRadius, this.padding, this.popoverAlignment = Alignment.topCenter, this.popoverAnchorAlignment, this.canUnselect = true, this.autoClosePopover = false, this.enabled, this.valueSelectionHandler, this.valueSelectionPredicate, this.showValuePredicate, required this.popup, required SelectValueBuilder<T> itemBuilder});
  Widget build(BuildContext context);
}
```
