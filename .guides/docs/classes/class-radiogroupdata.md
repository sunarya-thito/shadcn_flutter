---
title: "Class: RadioGroupData"
description: "Data class holding radio group state information."
---

```dart
/// Data class holding radio group state information.
///
/// Contains the selected item and enabled state for a radio group.
class RadioGroupData<T> {
  /// The currently selected item value.
  final T? selectedItem;
  /// Whether the radio group is enabled.
  final bool enabled;
  /// Creates radio group data.
  RadioGroupData(this.selectedItem, this.enabled);
  bool operator ==(Object other);
  int get hashCode;
}
```
