---
title: "Class: NoBackdropTransform"
description: "A [BackdropTransform] that leaves the backdrop untouched."
---

```dart
/// A [BackdropTransform] that leaves the backdrop untouched.
class NoBackdropTransform extends BackdropTransform {
  /// Creates an identity backdrop transform.
  const NoBackdropTransform();
  Widget wrapBackdrop(BuildContext context, Widget child, double t, {bool isRoot = true});
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}
```
