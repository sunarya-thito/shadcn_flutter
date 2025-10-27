---
title: "Class: ScrollableClientTheme"
description: "Theme data for [ScrollableClient]."
---

```dart
/// Theme data for [ScrollableClient].
class ScrollableClientTheme {
  final DiagonalDragBehavior? diagonalDragBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final Clip? clipBehavior;
  final HitTestBehavior? hitTestBehavior;
  final bool? overscroll;
  const ScrollableClientTheme({this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll});
  ScrollableClientTheme copyWith({ValueGetter<DiagonalDragBehavior?>? diagonalDragBehavior, ValueGetter<DragStartBehavior?>? dragStartBehavior, ValueGetter<ScrollViewKeyboardDismissBehavior?>? keyboardDismissBehavior, ValueGetter<Clip?>? clipBehavior, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<bool?>? overscroll});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
