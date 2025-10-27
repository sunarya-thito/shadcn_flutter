---
title: "Class: SubFocusScope"
description: "Hierarchical focus management system for complex widget trees."
---

```dart
/// Hierarchical focus management system for complex widget trees.
///
/// Creates a focus scope that manages keyboard navigation and focus traversal
/// for child widgets. Provides centralized control over which child widget
/// has focus and handles focus navigation between multiple focusable elements.
///
/// Key Features:
/// - **Focus Hierarchy**: Manages focus relationships between parent and child widgets
/// - **Keyboard Navigation**: Handles arrow key and tab navigation between elements
/// - **Action Delegation**: Routes keyboard actions to currently focused child
/// - **Auto-focus Support**: Automatically focuses first child when enabled
/// - **Focus State Management**: Tracks and updates focus state across widget rebuilds
/// - **Scroll Integration**: Ensures focused elements remain visible in scrollable areas
///
/// The scope maintains a list of attached [SubFocus] widgets and manages which
/// one currently has focus. It handles focus traversal, action routing, and
/// ensures focused widgets remain visible through scroll positioning.
///
/// Used commonly in:
/// - Lists with keyboard navigation
/// - Form field traversal
/// - Menu and dropdown navigation
/// - Tree view navigation
/// - Tab panel systems
///
/// Example:
/// ```dart
/// SubFocusScope(
///   autofocus: true,
///   builder: (context, state) => Column(
///     children: [
///       SubFocus(
///         builder: (context, focusState) => Container(
///           color: focusState.isFocused ? Colors.blue : Colors.grey,
///           child: Text('Item 1'),
///         ),
///       ),
///       SubFocus(
///         builder: (context, focusState) => Container(
///           color: focusState.isFocused ? Colors.blue : Colors.grey,
///           child: Text('Item 2'),
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
class SubFocusScope extends StatefulWidget {
  final SubFocusScopeBuilder? builder;
  final bool autofocus;
  const SubFocusScope({super.key, this.builder, this.autofocus = false});
  State<SubFocusScope> createState();
}
```
