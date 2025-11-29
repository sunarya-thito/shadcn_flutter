---
title: "Class: PlainChatBubbleType"
description: "A simple [ChatBubbleType] with no tail."
---

```dart
/// A simple [ChatBubbleType] with no tail.
class PlainChatBubbleType extends ChatBubbleType {
  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;
  /// The border of the bubble.
  final BorderSide? border;
  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;
  /// Creates a [PlainChatBubbleType].
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [border] (`BorderSide?`, optional): The border of the bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  const PlainChatBubbleType({this.borderRadius, this.border, this.padding});
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data, ChatBubble chat);
}
```
