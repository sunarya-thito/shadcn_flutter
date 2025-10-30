---
title: "Enum: FocusChangeReason"
description: "Reason for a focus change event in tree navigation."
---

```dart
/// Reason for a focus change event in tree navigation.
///
/// Used to differentiate between programmatic focus changes and
/// user-initiated focus changes.
enum FocusChangeReason {
  /// Focus changed due to focus scope management.
  focusScope,
  /// Focus changed due to direct user interaction.
  userInteraction,
}
```
