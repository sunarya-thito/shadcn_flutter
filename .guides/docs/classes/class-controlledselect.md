---
title: "Class: ControlledSelect"
description: "Reactive single-selection dropdown with automatic state management.   A high-level select widget that provides automatic state management through  the controlled component pattern. Supports both controller-based and callback-based  state management with comprehensive customization options for item presentation,  popup behavior, and interaction handling.   ## Features   - **Flexible item rendering**: Custom builders for complete visual control over items  - **Popup positioning**: Configurable alignment and constraints for the dropdown  - **Keyboard navigation**: Full keyboard support with arrow keys and Enter/Escape  - **Form integration**: Automatic validation and form field registration  - **Unselection support**: Optional ability to deselect the current selection   ## Usage Patterns   **Controller-based (recommended for complex state):**  ```dart  final controller = SelectController<String>('apple');   ControlledSelect<String>(    controller: controller,    items: ['apple', 'banana', 'cherry'],    itemBuilder: (context, item) => Text(item),    placeholder: Text('Choose fruit'),  )  ```   **Callback-based (simple state management):**  ```dart  String? selectedFruit;   ControlledSelect<String>(    initialValue: selectedFruit,    onChanged: (fruit) => setState(() => selectedFruit = fruit),    items: ['apple', 'banana', 'cherry'],    itemBuilder: (context, item) => Text(item),  )  ```"
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
  final OverlayConfiguration? overlayConfiguration;
  final bool? adaptiveOverlay;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final WidgetStatePropertyDelegate<Decoration>? decoration;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool autoClosePopover;
  final SelectPopupBuilder popup;
  final SelectValueBuilder<T> itemBuilder;
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  final Predicate<T>? showValuePredicate;
  final Widget? expandIcon;
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
  /// - [overlayConfiguration] (OverlayConfiguration?, optional): overrides the popup presentation
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override select border radius
  /// - [padding] (EdgeInsetsGeometry?, optional): override internal padding
  /// - [decoration] (`WidgetStatePropertyDelegate<Decoration>?`, optional): override the trigger decoration per state
  /// - [disableHoverEffect] (bool, default: false): disable item hover effects
  /// - [canUnselect] (bool, default: false): allow deselecting current item
  /// - [autoClosePopover] (bool, default: true): close popup after selection
  /// - [popup] (SelectPopupBuilder, required): builder for popup content
  /// - [itemBuilder] (`SelectItemBuilder<T>`, required): builder for individual items
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<T>?`, optional): custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<T>?`, optional): selection validation
  /// - [showValuePredicate] (`Predicate<T>?`, optional): visibility filter for values
  /// - [expandIcon] (Widget): The expand icon for the select, defaults to SelectExpandIcon widget
  /// - [adaptiveOverlay] (bool?, optional): whether `adaptiveConversion` runs for this overlay
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
  const ControlledSelect({super.key, this.controller, this.onChanged, this.enabled = true, this.initialValue, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.overlayConfiguration, this.borderRadius, this.padding, this.decoration, this.disableHoverEffect = false, this.canUnselect = false, this.autoClosePopover = true, this.expandIcon = const SelectExpandIcon(), required this.popup, required this.itemBuilder, this.valueSelectionHandler, this.valueSelectionPredicate, this.showValuePredicate, this.adaptiveOverlay});
  Widget build(BuildContext context);
}
```
