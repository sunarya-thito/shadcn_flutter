---
title: "Mixin: SubFocusState"
description: "Mixin providing focus state and control capabilities for focusable widgets."
---

```dart
/// Mixin providing focus state and control capabilities for focusable widgets.
///
/// Defines the interface for interacting with a [SubFocus] widget, including
/// methods for focus management, visibility control, and action handling.
///
/// This mixin is implemented by internal focus state classes and provides
/// the public API for focus operations on individual focusable elements.
mixin SubFocusState {
  /// Retrieves the render box for this focusable element.
  ///
  /// Used for positioning and scroll calculations. Returns `null` if
  /// the widget is not currently rendered.
  ///
  /// Returns the [RenderBox] or `null`.
  RenderBox? findRenderObject();
  /// Scrolls the widget into view within its scrollable ancestor.
  ///
  /// Ensures the focused widget is visible by scrolling its nearest
  /// [Scrollable] ancestor. Useful when focus moves to an off-screen element.
  ///
  /// Parameters:
  /// - [alignmentPolicy]: How to align the widget when scrolling
  void ensureVisible({ScrollPositionAlignmentPolicy alignmentPolicy = ScrollPositionAlignmentPolicy.explicit});
  /// Whether this element currently has focus.
  ///
  /// Returns `true` if this is the focused element in its parent scope.
  bool get isFocused;
  /// Requests focus for this element.
  ///
  /// Asks the parent scope to transfer focus to this element. Returns
  /// `true` if focus was successfully acquired, `false` otherwise.
  ///
  /// Returns `true` on success.
  bool requestFocus();
  /// Invokes an action/intent on this focused element.
  ///
  /// Routes keyboard shortcuts or other actions to this widget's
  /// action handlers. Returns the action result or `null` if not handled.
  ///
  /// Parameters:
  /// - [intent]: The intent/action to invoke
  ///
  /// Returns the action result or `null`.
  Object? invokeAction(Intent intent);
  /// The number of times this element has received focus.
  ///
  /// Increments each time [requestFocus] succeeds. Useful for analytics
  /// or behavior tracking.
  int get focusCount;
  /// Marks this element as focused or unfocused (internal method).
  ///
  /// Called by the parent scope to update focus state. Should not be
  /// called directly by application code.
  ///
  /// Parameters:
  /// - [focused]: Whether the element should be focused
  void markFocused(bool focused);
  /// Removes focus from this element.
  ///
  /// Asks the parent scope to clear focus from this element. Returns
  /// `true` if focus was successfully removed, `false` if it didn't have focus.
  ///
  /// Returns `true` on success.
  bool unfocus();
}
```
