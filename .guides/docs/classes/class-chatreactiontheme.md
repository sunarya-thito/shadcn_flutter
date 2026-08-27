---
title: "Class: ChatReactionTheme"
description: "Reference for ChatReactionTheme"
---

```dart
class ChatReactionTheme extends ComponentThemeData {
  final ChatBubbleCornerDirectional? corner;
  final Decoration? decoration;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? containerPadding;
  /// The minimum extra width the bubble keeps beyond the reaction when the
  /// reaction is wider than the bubble.
  final double? extraWidth;
  const ChatReactionTheme({this.corner, this.decoration, this.horizontalPadding, this.verticalPadding, this.containerPadding, this.extraWidth});
  ChatReactionTheme copyWith({ValueGetter<ChatBubbleCornerDirectional?>? corner, ValueGetter<Decoration?>? decoration, ValueGetter<double?>? horizontalPadding, ValueGetter<double?>? verticalPadding, ValueGetter<EdgeInsetsGeometry?>? containerPadding, ValueGetter<double?>? extraWidth});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
