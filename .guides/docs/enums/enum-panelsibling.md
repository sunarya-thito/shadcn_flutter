---
title: "Enum: PanelSibling"
description: "Represents the position of a panel relative to another panel."
---

```dart
/// Represents the position of a panel relative to another panel.
///
/// Used to specify which neighboring panel should be affected when
/// expanding or collapsing a resizable panel.
enum PanelSibling {
  /// The panel before (left/top) the current panel.
  before,
  /// The panel after (right/bottom) the current panel.
  after,
  /// Both panels on either side of the current panel.
  both,
}
```
