---
title: "Class: Tabs"
description: "A tabbed interface widget for organizing content into switchable panels."
---

```dart
/// A tabbed interface widget for organizing content into switchable panels.
///
/// [Tabs] provides a clean and intuitive way to organize related content into
/// separate panels that users can switch between by tapping tab headers. It manages
/// the selection state and provides visual feedback for the active tab while
/// handling the display of corresponding content.
///
/// Key features:
/// - Tab-based content organization with header and panel areas
/// - Active tab highlighting with smooth transitions
/// - Customizable tab styling through theming
/// - Gesture-based tab switching with tap support
/// - Flexible content management through TabChild system
/// - Integration with the shadcn_flutter design system
/// - Responsive layout adaptation
/// - Keyboard navigation support
///
/// The widget works with [TabChild] elements that define both the tab header
/// and the associated content panel. Each tab can contain any widget content,
/// from simple text to complex layouts.
///
/// Tab organization:
/// - Headers: Displayed in a horizontal row for tab selection
/// - Content: The active tab's content is shown in the main area
/// - Selection: Visual indication of the currently active tab
/// - Transitions: Smooth animations between tab switches
///
/// Example:
/// ```dart
/// Tabs(
///   index: currentTabIndex,
///   onChanged: (index) => setState(() => currentTabIndex = index),
///   children: [
///     TabChild(
///       tab: Text('Overview'),
///       child: Center(child: Text('Overview content')),
///     ),
///     TabChild(
///       tab: Text('Details'),
///       child: Center(child: Text('Details content')),
///     ),
///     TabChild(
///       tab: Text('Settings'),
///       child: Center(child: Text('Settings content')),
///     ),
///   ],
/// );
/// ```
class Tabs extends StatelessWidget {
  /// The index of the currently selected tab (0-indexed).
  ///
  /// Must be between 0 and `children.length - 1` inclusive.
  final int index;
  /// Callback invoked when the user selects a different tab.
  ///
  /// Called with the new tab index when the user taps a tab header.
  final ValueChanged<int> onChanged;
  /// List of tab children defining tab headers and content.
  ///
  /// Each [TabChild] contains a tab header widget and the associated
  /// content panel widget. The list must not be empty.
  final List<TabChild> children;
  /// Optional padding around individual tabs.
  ///
  /// Overrides the theme's tab padding if provided. If `null`,
  /// uses the padding from [TabsTheme].
  final EdgeInsetsGeometry? padding;
  /// Creates a tabs widget.
  ///
  /// Parameters:
  /// - [index]: Currently selected tab index (required)
  /// - [onChanged]: Tab selection callback (required)
  /// - [children]: List of tab children (required, non-empty)
  /// - [padding]: Custom tab padding (optional)
  const Tabs({super.key, required this.index, required this.onChanged, required this.children, this.padding});
  Widget build(BuildContext context);
}
```
