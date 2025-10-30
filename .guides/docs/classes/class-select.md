---
title: "Class: Select"
description: "A customizable dropdown selection widget for single-value selection."
---

```dart
/// A customizable dropdown selection widget for single-value selection.
///
/// [Select] provides a comprehensive dropdown selection experience with support for
/// custom item rendering, keyboard navigation, search functionality, and extensive
/// customization options. It displays a trigger button that opens a popup containing
/// selectable options when activated.
///
/// Key features:
/// - Single-value selection with optional null/unselect capability
/// - Customizable item rendering through builder functions
/// - Keyboard navigation and accessibility support
/// - Configurable popup positioning and constraints
/// - Search and filtering capabilities
/// - Focus management and interaction handling
/// - Theming and visual customization
/// - Form integration and validation support
///
/// The widget supports various configuration modes:
/// - Filled or outlined appearance styles
/// - Custom popup positioning and alignment
/// - Conditional item visibility and selection
/// - Hover effects and interaction feedback
/// - Auto-closing popup behavior
///
/// Selection behavior can be customized through:
/// - [valueSelectionHandler]: Custom logic for handling selection
/// - [valueSelectionPredicate]: Conditions for allowing selection
/// - [showValuePredicate]: Conditions for displaying items
/// - [canUnselect]: Whether to allow deselecting the current value
///
/// Example:
/// ```dart
/// Select<String>(
///   value: selectedItem,
///   placeholder: Text('Choose an option'),
///   onChanged: (value) => setState(() => selectedItem = value),
///   popup: SelectPopup.menu(
///     children: [
///       SelectItem(value: 'option1', child: Text('Option 1')),
///       SelectItem(value: 'option2', child: Text('Option 2')),
///       SelectItem(value: 'option3', child: Text('Option 3')),
///     ],
///   ),
/// );
/// ```
class Select<T> extends StatefulWidget with SelectBase<T> {
  /// Default maximum height for select popups in logical pixels.
  static const kDefaultSelectMaxHeight = 240.0;
  final ValueChanged<T?>? onChanged;
  final Widget? placeholder;
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  /// The currently selected value.
  final T? value;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool? autoClosePopover;
  /// Whether the select is enabled for user interaction.
  final bool? enabled;
  final SelectPopupBuilder popup;
  final SelectValueBuilder<T> itemBuilder;
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  final Predicate<T>? showValuePredicate;
  /// Creates a single-selection dropdown widget.
  ///
  /// The [popup] and [itemBuilder] parameters are required to define the
  /// dropdown content and how selected values are displayed.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget key for controlling widget identity
  /// - [onChanged] (`ValueChanged<T?>?`): Callback when selection changes; if null, select is disabled
  /// - [placeholder] (Widget?): Widget shown when no value is selected
  /// - [filled] (bool): Whether to use filled background style, defaults to false
  /// - [focusNode] (FocusNode?): Focus node for keyboard interaction
  /// - [constraints] (BoxConstraints?): Size constraints for the select button
  /// - [popupConstraints] (BoxConstraints?): Size constraints for the popup menu
  /// - [popupWidthConstraint] (PopoverConstraint): Width constraint mode for popup, defaults to `PopoverConstraint.anchorFixedSize`
  /// - [value] (T?): Currently selected value
  /// - [disableHoverEffect] (bool): Whether to disable hover visual feedback, defaults to false
  /// - [borderRadius] (BorderRadiusGeometry?): Custom border radius
  /// - [padding] (EdgeInsetsGeometry?): Custom padding
  /// - [popoverAlignment] (AlignmentGeometry): Popup alignment, defaults to `Alignment.topCenter`
  /// - [popoverAnchorAlignment] (AlignmentGeometry?): Anchor alignment for popup positioning
  /// - [canUnselect] (bool): Whether user can deselect current value, defaults to false
  /// - [autoClosePopover] (bool?): Whether popup closes after selection, defaults to true
  /// - [enabled] (bool?): Whether select is enabled for interaction
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<T>?`): Custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<T>?`): Predicate for allowing selection
  /// - [showValuePredicate] (`Predicate<T>?`): Predicate for showing items
  /// - [popup] (SelectPopupBuilder): Required builder for popup content
  /// - [itemBuilder] (`SelectValueBuilder<T>`): Required builder for selected value display
  const Select({super.key, this.onChanged, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.popupWidthConstraint = PopoverConstraint.anchorFixedSize, this.value, this.disableHoverEffect = false, this.borderRadius, this.padding, this.popoverAlignment = Alignment.topCenter, this.popoverAnchorAlignment, this.canUnselect = false, this.autoClosePopover = true, this.enabled, this.valueSelectionHandler, this.valueSelectionPredicate, this.showValuePredicate, required this.popup, required this.itemBuilder});
  SelectState<T> createState();
}
```
