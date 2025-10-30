---
title: "Class: ScrollableClientTheme"
description: "Theme data for [ScrollableClient]."
---

```dart
/// Theme data for [ScrollableClient].
class ScrollableClientTheme {
  /// Behavior for diagonal drag gestures.
  final DiagonalDragBehavior? diagonalDragBehavior;
  /// When drag gestures should start.
  final DragStartBehavior? dragStartBehavior;
  /// How the keyboard dismissal should behave.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  /// How to clip the scrollable content.
  final Clip? clipBehavior;
  /// How hit testing should behave for the scrollable.
  final HitTestBehavior? hitTestBehavior;
  /// Whether overscroll effects are enabled.
  final bool? overscroll;
  /// Creates a [ScrollableClientTheme].
  const ScrollableClientTheme({this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll});
  /// Creates a copy of this theme with the given fields replaced.
  ScrollableClientTheme copyWith({ValueGetter<DiagonalDragBehavior?>? diagonalDragBehavior, ValueGetter<DragStartBehavior?>? dragStartBehavior, ValueGetter<ScrollViewKeyboardDismissBehavior?>? keyboardDismissBehavior, ValueGetter<Clip?>? clipBehavior, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<bool?>? overscroll});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
