---
title: "Class: SelectData"
description: "Reference for SelectData"
---

```dart
class SelectData {
  final bool? autoClose;
  final Predicate<Object?> isSelected;
  final SelectValueChanged<Object?> onChanged;
  final bool hasSelection;
  final bool enabled;
  const SelectData({required this.autoClose, required this.isSelected, required this.onChanged, required this.hasSelection, required this.enabled});
  bool operator ==(Object other);
  int get hashCode;
}
```
