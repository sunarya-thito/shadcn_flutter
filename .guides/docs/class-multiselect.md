---
title: "Class: MultiSelect"
description: "Reference for MultiSelect"
---

```dart
class MultiSelect<T> extends StatelessWidget with SelectBase<Iterable<T>> {
  final ValueChanged<Iterable<T>?>? onChanged;
  final Widget? placeholder;
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  final Iterable<T>? value;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool? autoClosePopover;
  final bool? enabled;
  final SelectPopupBuilder popup;
  SelectValueBuilder<Iterable<T>> get itemBuilder;
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  final SelectValueBuilder<T> multiItemBuilder;
  final Predicate<Iterable<T>>? showValuePredicate;
  const MultiSelect({super.key, this.onChanged, this.placeholder, this.filled = false, this.focusNode, this.constraints, this.popupConstraints, this.popupWidthConstraint = PopoverConstraint.anchorFixedSize, required this.value, this.disableHoverEffect = false, this.borderRadius, this.padding, this.popoverAlignment = Alignment.topCenter, this.popoverAnchorAlignment, this.canUnselect = true, this.autoClosePopover = false, this.enabled, this.valueSelectionHandler, this.valueSelectionPredicate, this.showValuePredicate, required this.popup, required SelectValueBuilder<T> itemBuilder});
  Widget build(BuildContext context);
}
```
