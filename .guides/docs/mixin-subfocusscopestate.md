---
title: "Mixin: SubFocusScopeState"
description: "Reference for SubFocusScopeState"
---

```dart
mixin SubFocusScopeState {
  Object? invokeActionOnFocused(Intent intent);
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]);
  static SubFocusScopeState? maybeOf(BuildContext context);
  void detach(SubFocusState child);
  bool attach(SubFocusState child);
  bool requestFocus(SubFocusState child);
  bool unfocus(SubFocusState child);
}
```
