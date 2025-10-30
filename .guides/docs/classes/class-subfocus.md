---
title: "Class: SubFocus"
description: "Individual focusable widget within a SubFocusScope hierarchy."
---

```dart
/// Individual focusable widget within a SubFocusScope hierarchy.
///
/// Creates a single focusable element that can receive keyboard focus and respond
/// to user interactions within a [SubFocusScope]. Provides focus state information
/// and handles focus-related behaviors like visibility scrolling and action routing.
///
/// Key Features:
/// - **Focus State**: Tracks and reports whether this widget currently has focus
/// - **Focus Request**: Can programmatically request focus from its parent scope
/// - **Action Handling**: Receives and processes keyboard actions when focused
/// - **Scroll Integration**: Automatically scrolls to ensure visibility when focused
/// - **State Tracking**: Maintains focus count and state across widget lifecycle
/// - **Enable/Disable**: Can be temporarily disabled to prevent focus acquisition
///
/// The widget uses a builder pattern to provide focus state to child widgets,
/// allowing them to update their appearance and behavior based on focus status.
/// This enables rich visual feedback for focused states.
///
/// Common Use Cases:
/// - List items in navigable lists
/// - Form fields in keyboard-navigable forms
/// - Menu items in dropdown menus
/// - Tree nodes in tree views
/// - Tab headers in tab panels
///
/// Example:
/// ```dart
/// SubFocus(
///   enabled: true,
///   builder: (context, state) => GestureDetector(
///     onTap: () => state.requestFocus(),
///     child: Container(
///       padding: EdgeInsets.all(8),
///       decoration: BoxDecoration(
///         color: state.isFocused ? Colors.blue : Colors.transparent,
///         border: Border.all(
///           color: state.isFocused ? Colors.blue : Colors.grey,
///         ),
///       ),
///       child: Text(
///         'Focusable Item',
///         style: TextStyle(
///           color: state.isFocused ? Colors.white : Colors.black,
///         ),
///       ),
///     ),
///   ),
/// )
/// ```
class SubFocus extends StatefulWidget {
  /// Builder function that creates the widget tree with focus state.
  ///
  /// Called with the build context and focus state, allowing the widget
  /// to update its appearance and behavior based on the current focus status.
  final SubFocusBuilder builder;
  /// Whether this focusable element is enabled.
  ///
  /// When `false`, the element cannot receive focus and is excluded from
  /// the focus traversal order. Defaults to `true`.
  final bool enabled;
  /// Creates a focusable widget.
  ///
  /// Parameters:
  /// - [builder]: Widget builder with focus state (required)
  /// - [enabled]: Whether focus is enabled (defaults to `true`)
  const SubFocus({super.key, required this.builder, this.enabled = true});
  State<SubFocus> createState();
}
```
