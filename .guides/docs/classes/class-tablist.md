---
title: "Class: TabList"
description: "A horizontal tab list widget for selecting between multiple tab content areas."
---

```dart
/// A horizontal tab list widget for selecting between multiple tab content areas.
///
/// TabList provides a classic tab interface with a horizontal row of tab buttons
/// and an active tab indicator. It handles tab selection state and provides visual
/// feedback for the currently active tab through styling and an indicator line.
///
/// The widget automatically manages the appearance of tab buttons, applying
/// appropriate styling for active and inactive states. The active tab is
/// highlighted with foreground styling and an indicator line at the bottom.
///
/// Features:
/// - Horizontal row of selectable tab buttons
/// - Visual active tab indicator with customizable styling
/// - Automatic tab button state management (active/inactive)
/// - Theme-aware styling with customizable colors and dimensions
/// - Integration with TabContainer for coordinated tab management
///
/// The TabList works as part of a complete tab system, typically used with
/// corresponding content areas that show/hide based on the selected tab.
///
/// Example:
/// ```dart
/// TabList(
///   index: currentTabIndex,
///   onChanged: (index) => setState(() => currentTabIndex = index),
///   children: [
///     TabChild(child: Text('Tab 1')),
///     TabChild(child: Text('Tab 2')), 
///     TabChild(child: Text('Tab 3')),
///   ],
/// )
/// ```
class TabList extends StatelessWidget {
  /// List of tab child widgets to display in the tab list.
  ///
  /// Type: `List<TabChild>`. Each TabChild represents one selectable tab
  /// with its own label and optional content. The tabs are displayed in
  /// the order provided in the list.
  final List<TabChild> children;
  /// Index of the currently active/selected tab.
  ///
  /// Type: `int`. Zero-based index indicating which tab is currently active.
  /// Must be within the bounds of the [children] list. The active tab
  /// receives special styling and the indicator line.
  final int index;
  /// Callback invoked when a tab is selected.
  ///
  /// Type: `ValueChanged<int>?`. Called with the index of the newly selected
  /// tab when the user taps on a tab button. If null, tabs are not interactive.
  final ValueChanged<int>? onChanged;
  /// Creates a [TabList] with horizontal tab selection.
  ///
  /// Configures a tab list widget that displays a horizontal row of selectable
  /// tab buttons with visual feedback for the active tab.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [children] (`List<TabChild>`, required): List of tab items to display
  /// - [index] (int, required): Index of the currently active tab
  /// - [onChanged] (`ValueChanged<int>?`, required): Callback for tab selection
  ///
  /// Example:
  /// ```dart
  /// TabList(
  ///   index: selectedIndex,
  ///   onChanged: (newIndex) {
  ///     setState(() {
  ///       selectedIndex = newIndex;
  ///       // Update content based on new tab selection
  ///     });
  ///   },
  ///   children: [
  ///     TabChild(child: Text('Overview')),
  ///     TabChild(child: Text('Details')),
  ///     TabChild(child: Text('Settings')),
  ///   ],
  /// )
  /// ```
  const TabList({super.key, required this.children, required this.index, required this.onChanged});
  Widget build(BuildContext context);
}
```
