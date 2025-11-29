---
title: "Class: SharpCornerChatBubbleType"
description: "A [ChatBubbleType] that makes one corner sharp instead of rounded."
---

```dart
/// A [ChatBubbleType] that makes one corner sharp instead of rounded.
///
/// This style modifies the border radius of one corner to create a pointed
/// corner effect, similar to a speech bubble tail.
class SharpCornerChatBubbleType extends ChatBubbleType {
  /// The corner where the tail should be applied.
  final ChatBubbleCornerDirectional? corner;
  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;
  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;
  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;
  /// Creates a [SharpCornerChatBubbleType].
  ///
  /// Parameters:
  /// - [corner] (`ChatBubbleCornerDirectional?`, optional): The corner that should be sharp.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the sharp corner.
  const SharpCornerChatBubbleType({this.corner, this.borderRadius, this.padding, this.tailBehavior});
  /// Creates a copy of this bubble type with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [corner] (`ValueGetter<ChatBubbleCornerDirectional?>?`, optional): New corner value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius value.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior?>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [SharpCornerChatBubbleType] with the specified values updated.
  SharpCornerChatBubbleType copyWith({ValueGetter<ChatBubbleCornerDirectional?>? corner, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TailBehavior?>? tailBehavior});
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data, ChatBubble chat);
}
```
