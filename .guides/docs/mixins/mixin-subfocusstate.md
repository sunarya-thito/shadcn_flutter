---
title: "Mixin: SubFocusState"
description: "Reference for SubFocusState"
---

```dart
mixin SubFocusState {
  RenderBox? findRenderObject();
  void ensureVisible({ScrollPositionAlignmentPolicy alignmentPolicy = ScrollPositionAlignmentPolicy.explicit});
  bool get isFocused;
  bool requestFocus();
  Object? invokeAction(Intent intent);
  int get focusCount;
  void markFocused(bool focused);
  bool unfocus();
}
```
