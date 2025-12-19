---
title: "Class: ChatGroup"
description: "A widget that groups multiple [ChatBubble]s together."
---

```dart
/// A widget that groups multiple [ChatBubble]s together.
///
/// This widget handles the layout and styling of a group of chat bubbles,
/// including avatar positioning and spacing.
///
/// Example:
/// ```dart
/// ChatGroup(
///   avatarPrefix: Avatar(child: Text('A')),
///   children: [
///     ChatBubble(child: Text('Hello')),
///     ChatBubble(child: Text('How are you?')),
///   ],
/// )
/// ```
class ChatGroup extends StatelessWidget {
  /// The widget to display before the chat bubbles (e.g., an avatar).
  final Widget? avatarPrefix;
  /// The widget to display after the chat bubbles.
  final Widget? avatarSuffix;
  /// The list of chat bubbles to display.
  final List<Widget> children;
  /// The alignment of the chat bubbles within the group.
  final AxisAlignmentGeometry? alignment;
  /// The background color of the chat bubbles.
  final Color? color;
  /// The type of the chat bubbles.
  final ChatBubbleType? type;
  /// The border radius of the chat bubbles.
  final BorderRadiusGeometry? borderRadius;
  /// The padding inside the chat bubbles.
  final EdgeInsetsGeometry? padding;
  /// The border of the chat bubbles.
  final BorderSide? border;
  /// The spacing between chat bubbles.
  final double? spacing;
  /// The alignment of the avatar.
  final AxisAlignmentGeometry? avatarAlignment;
  /// The spacing between the avatar and the chat bubbles.
  final double? avatarSpacing;
  /// Creates a [ChatGroup].
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): The list of chat bubbles to display.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubbles within the group.
  /// - [color] (`Color?`, optional): The background color of the chat bubbles.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubbles.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubbles.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubbles.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubbles.
  /// - [spacing] (`double?`, optional): The spacing between chat bubbles.
  /// - [avatarPrefix] (`Widget?`, optional): The widget to display before the chat bubbles.
  /// - [avatarSuffix] (`Widget?`, optional): The widget to display after the chat bubbles.
  /// - [avatarAlignment] (`AxisAlignmentGeometry?`, optional): The alignment of the avatar.
  /// - [avatarSpacing] (`double?`, optional): The spacing between the avatar and the chat bubbles.
  const ChatGroup({super.key, required this.children, this.alignment, this.color, this.type, this.borderRadius, this.padding, this.border, this.spacing, this.avatarPrefix, this.avatarSuffix, this.avatarAlignment, this.avatarSpacing});
  Widget build(BuildContext context);
}
```
