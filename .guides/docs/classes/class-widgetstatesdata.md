---
title: "Class: WidgetStatesData"
description: "Data class wrapping a set of widget states."
---

```dart
/// Data class wrapping a set of widget states.
///
/// [WidgetStatesData] is a simple container for a `Set<WidgetState>` that can
/// be passed through the widget tree using the [Data] inherited widget system.
/// It's used by components like [Clickable] to propagate state information
/// (hovered, pressed, focused, etc.) to descendant widgets.
///
/// Example:
/// ```dart
/// const statesData = WidgetStatesData({WidgetState.hovered, WidgetState.focused});
/// ```
class WidgetStatesData {
  /// The set of current widget states.
  ///
  /// Common states include [WidgetState.hovered], [WidgetState.pressed],
  /// [WidgetState.focused], [WidgetState.disabled], and [WidgetState.selected].
  final Set<WidgetState> states;
  /// Creates widget states data with the specified states.
  const WidgetStatesData(this.states);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
