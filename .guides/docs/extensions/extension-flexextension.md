---
title: "Extension: FlexExtension"
description: "Extension adding gap and separator utilities to [Flex]."
---

```dart
/// Extension adding gap and separator utilities to [Flex].
extension FlexExtension on Flex {
  /// Adds gaps between flex children.
  ///
  /// The gap direction depends on the flex direction (vertical or horizontal).
  ///
  /// Parameters:
  /// - [gap] (`double`, required): Spacing between children.
  ///
  /// Returns: `Widget` — flex with gaps.
  Widget gap(double gap);
  /// Adds separators between flex children.
  ///
  /// Parameters:
  /// - [separator] (`Widget`, required): Widget to insert between children.
  ///
  /// Returns: `Widget` — flex with separators.
  Widget separator(Widget separator);
}
```
