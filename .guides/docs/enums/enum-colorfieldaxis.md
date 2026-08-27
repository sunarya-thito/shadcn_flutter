---
title: "Enum: ColorFieldAxis"
description: "The axis a colour component varies along inside a colour field."
---

```dart
/// The axis a colour component varies along inside a colour field.
///
/// A component set to [none] is held constant across the whole field. A
/// component set to [horizontal] or [vertical] ramps from its minimum at the
/// left/top edge to its maximum at the right/bottom edge.
enum ColorFieldAxis {
  /// The component does not vary; it is held at a single value.
  none,
  /// The component ramps from left (minimum) to right (maximum).
  horizontal,
  /// The component ramps from top (minimum) to bottom (maximum).
  vertical,
}
```
