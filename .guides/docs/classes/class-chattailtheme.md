---
title: "Class: ChatTailTheme"
description: "Defines the theme for the tail of a [ChatBubble]."
---

```dart
/// Defines the theme for the tail of a [ChatBubble].
class ChatTailTheme extends ComponentThemeData {
  /// The position of the tail relative to the bubble.
  final AxisDirectional? position;
  /// The size of the tail.
  final Size? size;
  /// The border radius of the bubble when a tail is present.
  final BorderRadiusGeometry? borderRadius;
  /// The radius of the tail's curve.
  final double? tailRadius;
  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;
  /// Creates a [ChatTailTheme].
  ///
  /// Parameters:
  /// - [position] (`AxisDirectional?`, optional): The position of the tail relative to the bubble.
  /// - [size] (`Size?`, optional): The size of the tail.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble when a tail is present.
  /// - [tailRadius] (`double?`, optional): The radius of the tail's curve.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the tail.
  const ChatTailTheme({this.position, this.size, this.borderRadius, this.tailRadius, this.tailBehavior});
  String toString();
  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [position] (`ValueGetter<AxisDirectional>?`, optional): New position value.
  /// - [size] (`ValueGetter<Size>?`, optional): New size value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry>?`, optional): New border radius value.
  /// - [tailRadius] (`ValueGetter<double>?`, optional): New tail radius value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [ChatTailTheme] with the specified values updated.
  ChatTailTheme copyWith({ValueGetter<AxisDirectional>? position, ValueGetter<Size>? size, ValueGetter<BorderRadiusGeometry>? borderRadius, ValueGetter<double>? tailRadius, ValueGetter<TailBehavior>? tailBehavior});
  bool operator ==(Object other);
  int get hashCode;
}
```
