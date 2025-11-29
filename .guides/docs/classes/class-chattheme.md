---
title: "Class: ChatTheme"
description: "Defines the theme for [ChatBubble]s."
---

```dart
/// Defines the theme for [ChatBubble]s.
class ChatTheme extends ComponentThemeData {
  /// The background color of the chat bubble.
  final Color? color;
  /// The alignment of the chat bubble.
  final AxisAlignmentGeometry? alignment;
  /// The type of the chat bubble (e.g., plain, tailed).
  final ChatBubbleType? type;
  /// The border radius of the chat bubble.
  final BorderRadiusGeometry? borderRadius;
  /// The padding inside the chat bubble.
  final EdgeInsetsGeometry? padding;
  /// The border of the chat bubble.
  final BorderSide? border;
  /// Creates a [ChatTheme].
  ///
  /// Parameters:
  /// - [color] (`Color?`, optional): The background color of the chat bubble.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubble.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubble (e.g., plain, tailed).
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubble.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubble.
  const ChatTheme({this.color, this.alignment, this.type, this.borderRadius, this.padding, this.border});
  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [color] (`ValueGetter<Color?>?`, optional): New color value.
  /// - [alignment] (`ValueGetter<AxisAlignmentGeometry?>?`, optional): New alignment value.
  /// - [type] (`ValueGetter<ChatBubbleType?>?`, optional): New type value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius value.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding value.
  /// - [border] (`ValueGetter<BorderSide?>?`, optional): New border value.
  ///
  /// Returns:
  /// A new [ChatTheme] with the specified values updated.
  ChatTheme copyWith({ValueGetter<Color?>? color, ValueGetter<AxisAlignmentGeometry?>? alignment, ValueGetter<ChatBubbleType?>? type, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderSide?>? border});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
