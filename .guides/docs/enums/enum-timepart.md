---
title: "Enum: TimePart"
description: "Represents the parts of a time-of-day that can be selected."
---

```dart
/// Represents the parts of a time-of-day that can be selected.
///
/// Used by [TimePicker] to specify which time components are editable.
enum TimePart {
  /// Hour component (0-23 or 1-12 depending on format).
  hour,
  /// Minute component (0-59).
  minute,
  /// Second component (0-59).
  second,
}
```
