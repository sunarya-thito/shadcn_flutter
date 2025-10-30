---
title: "Class: GroupWidget"
description: "A multi-child layout widget that positions children using absolute coordinates."
---

```dart
/// A multi-child layout widget that positions children using absolute coordinates.
///
/// Similar to Flutter's [Stack] but with more explicit positioning control.
/// Children are positioned using [GroupPositioned] widgets that specify their
/// exact location and/or size within the group's bounds.
///
/// Example:
/// ```dart
/// GroupWidget(
///   children: [
///     GroupPositioned(
///       top: 10,
///       left: 10,
///       child: Text('Positioned text'),
///     ),
///   ],
/// )
/// ```
class GroupWidget extends MultiChildRenderObjectWidget {
  /// Creates a [GroupWidget].
  const GroupWidget({super.key, super.children});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderGroup renderObject);
}
```
