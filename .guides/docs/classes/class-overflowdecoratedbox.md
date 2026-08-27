---
title: "Class: OverflowDecoratedBox"
description: "A [DecoratedBox] that can overflow its bounds.   [OverflowDecoratedBox] is similar to [DecoratedBox], but it can paint its  decoration outside its layout bounds when [expands] margins are provided.  This is used internally by [Clickable] to support negative margins for  visual effects like hover outlines."
---

```dart
/// A [DecoratedBox] that can overflow its bounds.
///
/// [OverflowDecoratedBox] is similar to [DecoratedBox], but it can paint its
/// decoration outside its layout bounds when [expands] margins are provided.
/// This is used internally by [Clickable] to support negative margins for
/// visual effects like hover outlines.
class OverflowDecoratedBox extends SingleChildRenderObjectWidget {
  /// Creates an [OverflowDecoratedBox].
  const OverflowDecoratedBox({super.key, required this.decoration, required this.expands, super.child});
  /// The amount by which the decoration should expand beyond the layout bounds.
  final EdgeInsets expands;
  /// The decoration to paint.
  final Decoration decoration;
  RenderOverflowDecoratedBox createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderOverflowDecoratedBox renderObject);
}
```
