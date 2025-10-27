---
title: "Class: ScrollableClient"
description: "Reference for ScrollableClient"
---

```dart
class ScrollableClient extends StatelessWidget {
  final bool? primary;
  final Axis mainAxis;
  final ScrollableDetails verticalDetails;
  final ScrollableDetails horizontalDetails;
  final ScrollableBuilder builder;
  final Widget? child;
  final DiagonalDragBehavior? diagonalDragBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final Clip? clipBehavior;
  final HitTestBehavior? hitTestBehavior;
  final bool? overscroll;
  const ScrollableClient({super.key, this.primary, this.mainAxis = Axis.vertical, this.verticalDetails = const ScrollableDetails.vertical(), this.horizontalDetails = const ScrollableDetails.horizontal(), required this.builder, this.child, this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll});
  Widget build(BuildContext context);
}
```
