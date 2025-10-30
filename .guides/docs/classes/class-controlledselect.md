---
title: "Class: ControlledSelect"
description: "Reactive single-selection dropdown with automatic state management."
---

```dart
/// Reactive single-selection dropdown with automatic state management.
///
/// A high-level select widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for item presentation,
/// popup behavior, and interaction handling.
///
/// ## Features
///
/// - **Flexible item rendering**: Custom builders for complete visual control over items
/// - **Popup positioning**: Configurable alignment and constraints for the dropdown
/// - **Keyboard navigation**: Full keyboard support with arrow keys and Enter/Escape
/// - **Form integration**: Automatic validation and form field registration
/// - **Unselection support**: Optional ability to deselect the current selection
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = SelectController<String>('apple');
///
/// ControlledSelect<String>(
///   controller: controller,
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item) => Text(item),
///   placeholder: Text('Choose fruit'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// String? selectedFruit;
///
/// ControlledSelect<String>(
///   initialValue: selectedFruit,
///   onChanged: (fruit) => setState(() => selectedFruit = fruit),
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item) => Text(item),
/// )
/// ```
class ControlledSelect<T> extends StatelessWidget with ControlledComponent<T?>, SelectBase<T> {
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final SelectController<T>? controller;
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
  final SelectValueBuilder<T> itemBuilder;
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  final Predicate<T>? showValuePredicate;
  /// Creates a [ControlledSelect].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns depending on application architecture needs.
  ///
  /// Parameters:
  /// - [controller] (`SelectController<T>?`, optional): external state controller
  /// - [initialValue] (T?, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<T?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether select is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no item selected
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
  /// - [canUnselect] (bool, default: false): allow deselecting current item
  /// - [autoClosePopover] (bool, default: true): close popup after selection
  /// - [popup] (SelectPopupBuilder, required): builder for popup content
  /// - [itemBuilder] (`SelectItemBuilder<T>`, required): builder for individual items
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<T>?`, optional): custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<T>?`, optional): selection validation
  /// - [showValuePredicate] (`Predicate<T>?`, optional): visibility filter for values
  ///
  /// Example:
  /// ```dart
  /// ControlledSelect<String>(
  ///   controller: controller,
  ///   popup: (context, items) => ListView(children: items),
  ///   itemBuilder: (context, item, selected) => Text(item),
  ///   placeholder: Text('Select option'),
  /// )
  /// ```
  const ControlledSelect({super.key, this.controller, this.onChanged, this.enabled = true, this.initialValue, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.popupWidthConstraint = PopoverConstraint.anchorFixedSize, this.borderRadius, this.padding, this.popoverAlignment = Alignment.topCenter, this.popoverAnchorAlignment, this.disableHoverEffect = false, this.canUnselect = false, this.autoClosePopover = true, required this.popup, required this.itemBuilder, this.valueSelectionHandler, this.valueSelectionPredicate, this.showValuePredicate});
  Widget build(BuildContext context);
}
```
