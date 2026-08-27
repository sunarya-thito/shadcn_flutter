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
  /// Overrides the [OverlayConfiguration] used to present the popup. When
  /// null, a default [PopoverConfiguration] is used
  /// (`PopoverConstraint.anchorFixedSize`, `Alignment.topCenter`).
  OverlayConfiguration? get overlayConfiguration;
  /// Whether the popup may adapt to a different presentation on mobile
  /// platforms (see [showOverlay]'s `adaptive` parameter).
  bool? get adaptiveOverlay;
  /// Border radius of the select trigger.
  BorderRadiusGeometry? get borderRadius;
  /// Internal padding of the select trigger.
  EdgeInsetsGeometry? get padding;
  /// Overrides the decoration of the select trigger, resolved per
  /// [WidgetState]. See [SelectTheme.decoration].
  WidgetStatePropertyDelegate<Decoration>? get decoration;
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
  /// Expand icon for the select
  Widget? get expandIcon;
}
```
