---
title: "Mixin: SubFocusScopeState"
description: "Mixin providing focus scope state management capabilities."
---

```dart
/// Mixin providing focus scope state management capabilities.
///
/// Defines the interface for interacting with a [SubFocusScope], including
/// methods for focus management, child attachment/detachment, and action routing.
///
/// This mixin is implemented by internal scope state classes and provides
/// the public API for focus operations within a scope.
mixin SubFocusScopeState {
  /// Invokes an action on the currently focused child widget.
  ///
  /// Routes keyboard shortcuts or other intents to the focused child.
  /// Returns the result of the action, or `null` if no child is focused
  /// or the action is not handled.
  ///
  /// Parameters:
  /// - [intent]: The intent/action to invoke
  ///
  /// Returns the action result or `null`.
  Object? invokeActionOnFocused(Intent intent);
  /// Moves focus to the next child in the specified direction.
  ///
  /// Traverses the focus order in the given direction, wrapping around
  /// at the edges if needed. Returns `true` if focus was successfully
  /// moved, `false` otherwise (e.g., no children available).
  ///
  /// Parameters:
  /// - [direction]: Direction to traverse (defaults to [TraversalDirection.down])
  ///
  /// Returns `true` if focus moved successfully.
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]);
  /// Retrieves the nearest [SubFocusScopeState] from the widget tree.
  ///
  /// Searches up the widget tree for an ancestor [SubFocusScope] and
  /// returns its state. Returns `null` if no scope is found.
  ///
  /// Parameters:
  /// - [context]: Build context to search from
  ///
  /// Returns the scope state or `null`.
  static SubFocusScopeState? maybeOf(BuildContext context);
  /// Detaches a child focus state from this scope.
  ///
  /// Called when a [SubFocus] widget is disposed or removed from the tree.
  /// Removes the child from the scope's managed focus list.
  ///
  /// Parameters:
  /// - [child]: The child state to detach
  void detach(SubFocusState child);
  /// Attaches a child focus state to this scope.
  ///
  /// Called when a [SubFocus] widget is initialized. Adds the child to
  /// the scope's managed focus list and may auto-focus it if configured.
  ///
  /// Parameters:
  /// - [child]: The child state to attach
  ///
  /// Returns `true` if attachment succeeded.
  bool attach(SubFocusState child);
  /// Requests focus for a specific child.
  ///
  /// Transfers focus to the specified child, unfocusing the previously
  /// focused child if any. Updates visual state and ensures the focused
  /// widget is scrolled into view if needed.
  ///
  /// Parameters:
  /// - [child]: The child to receive focus
  ///
  /// Returns `true` if focus was granted successfully.
  bool requestFocus(SubFocusState child);
  /// Removes focus from a specific child.
  ///
  /// If the specified child currently has focus, clears the focus state.
  /// Otherwise, does nothing.
  ///
  /// Parameters:
  /// - [child]: The child to unfocus
  ///
  /// Returns `true` if the child was unfocused, `false` if it didn't have focus.
  bool unfocus(SubFocusState child);
}
```
