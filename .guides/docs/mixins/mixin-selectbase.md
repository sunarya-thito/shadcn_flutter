---
title: "Mixin: SelectBase"
description: "Reference for SelectBase"
---

```dart
mixin SelectBase<T> {
  ValueChanged<T?>? get onChanged;
  Widget? get placeholder;
  bool get filled;
  FocusNode? get focusNode;
  BoxConstraints? get constraints;
  BoxConstraints? get popupConstraints;
  PopoverConstraint get popupWidthConstraint;
  BorderRadiusGeometry? get borderRadius;
  EdgeInsetsGeometry? get padding;
  AlignmentGeometry get popoverAlignment;
  AlignmentGeometry? get popoverAnchorAlignment;
  bool get disableHoverEffect;
  bool get canUnselect;
  bool? get autoClosePopover;
  SelectPopupBuilder get popup;
  SelectValueBuilder<T> get itemBuilder;
  SelectValueSelectionHandler<T>? get valueSelectionHandler;
  SelectValueSelectionPredicate<T>? get valueSelectionPredicate;
  Predicate<T>? get showValuePredicate;
}
```
