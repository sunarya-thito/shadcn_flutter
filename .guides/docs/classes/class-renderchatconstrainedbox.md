---
title: "Class: RenderChatConstrainedBox"
description: "A render object that constrains the width of its child and aligns it."
---

```dart
/// A render object that constrains the width of its child and aligns it.
///
/// This render object implements the layout logic for [ChatConstrainedBox].
class RenderChatConstrainedBox extends RenderShiftedBox {
  /// Creates a [RenderChatConstrainedBox].
  ///
  /// Parameters:
  /// - [widthFactor] (`double`, required): The fraction of the available width that the child should occupy.
  /// - [alignment] (`AxisAlignment`, required): The alignment of the child within the available space.
  /// - [child] (`RenderBox?`, optional): The child render object.
  RenderChatConstrainedBox({required double widthFactor, required AxisAlignment alignment, RenderBox? child});
  /// The fraction of the available width that the child should occupy.
  double get widthFactor;
  /// The alignment of the child within the available space.
  AxisAlignment get alignment;
  /// Sets the width factor.
  set widthFactor(double value);
  /// Sets the alignment.
  set alignment(AxisAlignment value);
  void performLayout();
  Size computeDryLayout(covariant BoxConstraints constraints);
  double computeMaxIntrinsicHeight(double width);
  double computeMinIntrinsicHeight(double width);
}
```
