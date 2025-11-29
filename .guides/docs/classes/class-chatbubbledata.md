---
title: "Class: ChatBubbleData"
description: "Data associated with a [ChatBubble] within a [ChatGroup]."
---

```dart
/// Data associated with a [ChatBubble] within a [ChatGroup].
class ChatBubbleData {
  /// The index of the bubble in the group.
  final int index;
  /// The total number of bubbles in the group.
  final int length;
  /// Creates a [ChatBubbleData].
  ///
  /// Parameters:
  /// - [index] (`int`, required): The index of the bubble in the group.
  /// - [length] (`int`, required): The total number of bubbles in the group.
  const ChatBubbleData({required this.index, required this.length});
  /// Creates a copy of this data with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [index] (`int?`, optional): New index value.
  /// - [length] (`int?`, optional): New length value.
  ///
  /// Returns:
  /// A new [ChatBubbleData] with the specified values updated.
  ChatBubbleData copyWith({int? index, int? length});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
