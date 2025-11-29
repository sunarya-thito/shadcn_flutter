---
title: "Class: ChatBubble"
description: "A widget that displays a single chat message or content."
---

```dart
/// A widget that displays a single chat message or content.
///
/// This widget renders a chat bubble with customizable styling, including
/// background color, alignment, and tail behavior.
///
/// Example:
/// ```dart
/// ChatBubble(
///   child: Text('Hello World'),
///   alignment: AxisAlignment.right,
///   color: Colors.blue,
/// )
/// ```
class ChatBubble extends StatelessWidget {
  /// The content of the chat bubble.
  final Widget child;
  /// The type of the chat bubble.
  final ChatBubbleType? type;
  /// The background color of the chat bubble.
  final Color? color;
  /// The alignment of the chat bubble.
  final AxisAlignmentGeometry? alignment;
  /// The border of the chat bubble.
  final BorderSide? border;
  /// The padding inside the chat bubble.
  final EdgeInsetsGeometry? padding;
  /// The border radius of the chat bubble.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [ChatBubble].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The content of the chat bubble.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubble.
  /// - [color] (`Color?`, optional): The background color of the chat bubble.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubble.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubble.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubble.
  const ChatBubble({super.key, required this.child, this.type, this.color, this.alignment, this.border, this.padding, this.borderRadius});
  Widget build(BuildContext context);
}
```
