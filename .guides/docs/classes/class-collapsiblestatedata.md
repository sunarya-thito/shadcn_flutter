---
title: "Class: CollapsibleStateData"
description: "Internal data structure for sharing collapsible state between child widgets."
---

```dart
/// Internal data structure for sharing collapsible state between child widgets.
///
/// [CollapsibleStateData] provides a communication mechanism between the
/// [Collapsible] parent and its child widgets like [CollapsibleTrigger] and
/// [CollapsibleContent]. It exposes the current expansion state and a
/// callback for triggering state changes.
class CollapsibleStateData {
  /// Callback to trigger expansion state changes.
  ///
  /// When called, triggers the collapsible to toggle its expansion state.
  /// This function handles both controlled and uncontrolled modes appropriately.
  final VoidCallback handleTap;
  /// Current expansion state of the collapsible.
  ///
  /// True when the collapsible is expanded and content should be visible,
  /// false when collapsed and content should be hidden.
  final bool isExpanded;
  /// Creates a [CollapsibleStateData] with the specified state and callback.
  ///
  /// This constructor is used internally by [Collapsible] to share state
  /// with its child widgets.
  const CollapsibleStateData({required this.isExpanded, required this.handleTap});
}
```
