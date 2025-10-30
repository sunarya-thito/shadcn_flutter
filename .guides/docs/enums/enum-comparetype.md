---
title: "Enum: CompareType"
description: "Defines comparison operators for numeric validation."
---

```dart
/// Defines comparison operators for numeric validation.
///
/// Used by [CompareValidator] to specify the type of comparison to perform.
enum CompareType {
  /// Value must be greater than the compared value.
  greater,
  /// Value must be greater than or equal to the compared value.
  greaterOrEqual,
  /// Value must be less than the compared value.
  less,
  /// Value must be less than or equal to the compared value.
  lessOrEqual,
  /// Value must be equal to the compared value.
  equal,
}
```
