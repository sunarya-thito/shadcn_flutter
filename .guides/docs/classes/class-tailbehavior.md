---
title: "Class: TailBehavior"
description: "Defines when a tail should be shown on a [ChatBubble]."
---

```dart
/// Defines when a tail should be shown on a [ChatBubble].
abstract class TailBehavior {
  /// Shows a tail on the first bubble in a group.
  static const first = _ChatTailBehavior(_first);
  /// Shows a tail on the middle bubble in a group.
  static const middle = _ChatTailBehavior(_middle);
  /// Shows a tail on the last bubble in a group.
  static const last = _ChatTailBehavior(_last);
  /// Determines whether the bubble at the given index should have a tail.
  bool wrapWithTail(ChatBubbleData data);
}
```
