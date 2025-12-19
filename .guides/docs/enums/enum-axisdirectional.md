---
title: "Enum: AxisDirectional"
description: "Defines a direction along an axis, either vertical or horizontal."
---

```dart
/// Defines a direction along an axis, either vertical or horizontal.
///
/// This is similar to [AxisDirection] but includes support for directional
/// values (start/end) that resolve based on [TextDirection].
enum AxisDirectional {
  /// Up direction.
  up,
  /// Down direction.
  down,
  /// Start direction (left in LTR, right in RTL).
  start,
  /// End direction (right in LTR, left in RTL).
  end,
}
```
