---
title: "Class: UnorderedListData"
description: "Data class for tracking unordered list nesting depth."
---

```dart
/// Data class for tracking unordered list nesting depth.
///
/// Used internally by the list item modifier to handle bullet points
/// and indentation for nested lists.
class UnorderedListData {
  /// The nesting depth of the list (0 = top level).
  final int depth;
  /// Creates an [UnorderedListData].
  ///
  /// Parameters:
  /// - [depth] (`int`, default: 0): Nesting depth.
  const UnorderedListData({this.depth = 0});
}
```
