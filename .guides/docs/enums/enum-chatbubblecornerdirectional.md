---
title: "Enum: ChatBubbleCornerDirectional"
description: "Defines the directional corner of a [ChatBubble]."
---

```dart
/// Defines the directional corner of a [ChatBubble].
///
/// This is used to support RTL languages by defining corners in terms of
/// start and end instead of left and right.
enum ChatBubbleCornerDirectional {
  /// The top-start corner (top-left in LTR, top-right in RTL).
  topStart,
  /// The top-end corner (top-right in LTR, top-left in RTL).
  topEnd,
  /// The bottom-start corner (bottom-left in LTR, bottom-right in RTL).
  bottomStart,
  /// The bottom-end corner (bottom-right in LTR, bottom-left in RTL).
  bottomEnd,
}
```
