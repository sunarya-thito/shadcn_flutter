---
title: "Class: TailChatBubbleType"
description: "A [ChatBubbleType] that draws an external triangular tail."
---

```dart
/// A [ChatBubbleType] that draws an external triangular tail.
class TailChatBubbleType extends ChatBubbleType {
  /// The alignment of the tail along the bubble's edge.
  final AxisAlignmentGeometry? tailAlignment;
  /// The position of the tail relative to the bubble.
  final AxisDirectional? position;
  /// The size of the tail.
  final Size? size;
  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;
  /// The radius of the tail's curve.
  final double? tailRadius;
  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;
  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;
  /// Creates a [TailChatBubbleType].
  ///
  /// Parameters:
  /// - [tailAlignment] (`AxisAlignmentGeometry?`, optional): The alignment of the tail along the bubble's edge.
  /// - [position] (`AxisDirectional?`, optional): The position of the tail relative to the bubble.
  /// - [size] (`Size?`, optional): The size of the tail.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [tailRadius] (`double?`, optional): The radius of the tail's curve.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the tail.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  const TailChatBubbleType({this.tailAlignment, this.position, this.size, this.borderRadius, this.tailRadius, this.tailBehavior, this.padding});
  /// Creates a copy of this bubble type with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [tailAlignment] (`ValueGetter<AxisAlignmentGeometry>?`, optional): New tail alignment value.
  /// - [position] (`ValueGetter<AxisDirectional>?`, optional): New position value.
  /// - [size] (`ValueGetter<Size>?`, optional): New size value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry>?`, optional): New border radius value.
  /// - [tailRadius] (`ValueGetter<double>?`, optional): New tail radius value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [TailChatBubbleType] with the specified values updated.
  TailChatBubbleType copyWith({ValueGetter<AxisAlignmentGeometry>? tailAlignment, ValueGetter<AxisDirectional>? position, ValueGetter<Size>? size, ValueGetter<BorderRadiusGeometry>? borderRadius, ValueGetter<double>? tailRadius, ValueGetter<TailBehavior>? tailBehavior});
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data, ChatBubble chat);
}
```
