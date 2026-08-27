---
title: "Class: ChatReaction"
description: "Reference for ChatReaction"
---

```dart
class ChatReaction extends StatelessWidget {
  final Widget child;
  final ChatBubbleCornerDirectional? corner;
  final Widget reaction;
  /// The minimum extra width the bubble keeps beyond the reaction when the
  /// reaction is wider than the bubble.
  final double? extraWidth;
  const ChatReaction({super.key, this.corner, this.extraWidth, required this.reaction, required this.child});
  Widget build(BuildContext context);
}
```
