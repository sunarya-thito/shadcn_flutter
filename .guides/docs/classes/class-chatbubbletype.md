---
title: "Class: ChatBubbleType"
description: "Defines the type of a [ChatBubble]."
---

```dart
/// Defines the type of a [ChatBubble].
///
/// This abstract class allows for different visual styles of chat bubbles,
/// such as plain bubbles or bubbles with tails.
abstract class ChatBubbleType {
  /// A plain bubble with no tail.
  static const plain = PlainChatBubbleType();
  /// A bubble with an external triangular tail.
  static const tail = TailChatBubbleType();
  /// A bubble with one sharp corner instead of rounded.
  static const sharpCorner = SharpCornerChatBubbleType();
  /// Creates a [ChatBubbleType].
  const ChatBubbleType();
  /// Wraps the child widget with the bubble styling.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [child] (`Widget`, required): The child widget to wrap.
  /// - [data] (`ChatBubbleData`, required): The data associated with the bubble.
  /// - [chat] (`ChatBubble`, required): The chat bubble widget itself.
  ///
  /// Returns:
  /// A [Widget] that wraps the child with the bubble styling.
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data, ChatBubble chat);
}
```
