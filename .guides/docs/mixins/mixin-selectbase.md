---
title: "Mixin: SelectBase"
description: "Common interface for select components."
---

```dart
/// Common interface for select components.
///
/// Defines the contract for both single and multi-select widgets, providing
/// properties for popup behavior, styling, and value handling.
mixin SelectBase<T> {
  /// Callback when selection changes.
  ValueChanged<T?>? get onChanged;
  /// Placeholder widget shown when nothing is selected.
  Widget? get placeholder;
  /// Whether to use filled appearance style.
  bool get filled;
  /// Focus node for keyboard navigation.
  FocusNode? get focusNode;
  /// Size constraints for the select trigger.
  BoxConstraints? get constraints;
  /// Size constraints for the popup menu.
  BoxConstraints? get popupConstraints;
  /// How popup width should relate to trigger width.
  PopoverConstraint get popupWidthConstraint;
  /// Border radius of the select trigger.
  BorderRadiusGeometry? get borderRadius;
  /// Internal padding of the select trigger.
  EdgeInsetsGeometry? get padding;
  /// Alignment of popup relative to trigger.
  AlignmentGeometry get popoverAlignment;
  /// Alignment of anchor point for popup positioning.
  AlignmentGeometry? get popoverAnchorAlignment;
  /// Whether to disable hover effects.
  bool get disableHoverEffect;
  /// Whether clicking selected item deselects it.
  bool get canUnselect;
  /// Whether popup auto-closes after selection.
  bool? get autoClosePopover;
  /// Builder for popup content.
  SelectPopupBuilder get popup;
  /// Builder for rendering selected values.
  SelectValueBuilder<T> get itemBuilder;
  /// Custom selection handler logic.
  SelectValueSelectionHandler<T>? get valueSelectionHandler;
  /// Predicate for testing selection state.
  SelectValueSelectionPredicate<T>? get valueSelectionPredicate;
  /// Predicate for showing value in trigger.
  Predicate<T>? get showValuePredicate;
}
```
