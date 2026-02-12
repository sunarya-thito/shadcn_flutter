---
title: "Class: ChatConstrainedBox"
description: "A widget that constrains the width of its child based on a factor and aligns it.   This widget is used by [ChatBubble] to limit the width of the bubble relative to  the available width and to align it within that space.   Parameters:  - [widthFactor] (`double`, required): The fraction of the available width that the child should occupy.  - [alignment] (`AxisAlignmentGeometry`, required): The alignment of the child within the available space.  - [child] (`Widget`, required): The widget below this widget in the tree."
---

```dart
/// A widget that constrains the width of its child based on a factor and aligns it.
///
/// This widget is used by [ChatBubble] to limit the width of the bubble relative to
/// the available width and to align it within that space.
///
/// Parameters:
/// - [widthFactor] (`double`, required): The fraction of the available width that the child should occupy.
/// - [alignment] (`AxisAlignmentGeometry`, required): The alignment of the child within the available space.
/// - [child] (`Widget`, required): The widget below this widget in the tree.
class ChatConstrainedBox extends SingleChildRenderObjectWidget {
  /// The fraction of the available width that the child should occupy.
  final double widthFactor;
  /// The alignment of the child within the available space.
  final AxisAlignmentGeometry alignment;
  /// Creates a [ChatConstrainedBox].
  const ChatConstrainedBox({required this.widthFactor, required this.alignment, required super.child, super.key});
  RenderChatConstrainedBox createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderChatConstrainedBox renderObject);
}
```
