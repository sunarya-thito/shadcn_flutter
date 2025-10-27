---
title: "Mixin: OverlayHandlerStateMixin"
description: "Reference for OverlayHandlerStateMixin"
---

```dart
mixin OverlayHandlerStateMixin<T extends StatefulWidget> on State<T> {
  Future<void> close([bool immediate = false]);
  void closeLater();
  Future<void> closeWithResult<X>([X? value]);
  set anchorContext(BuildContext value);
  set alignment(AlignmentGeometry value);
  set anchorAlignment(AlignmentGeometry value);
  set widthConstraint(PopoverConstraint value);
  set heightConstraint(PopoverConstraint value);
  set margin(EdgeInsets value);
  set follow(bool value);
  set offset(Offset? value);
  set allowInvertHorizontal(bool value);
  set allowInvertVertical(bool value);
}
```
