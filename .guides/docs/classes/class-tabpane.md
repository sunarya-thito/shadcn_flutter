---
title: "Class: TabPane"
description: "A comprehensive tab pane widget with sortable tabs and integrated content display."
---

```dart
/// A comprehensive tab pane widget with sortable tabs and integrated content display.
///
/// TabPane provides a complete tab interface that combines a sortable tab bar with
/// a content display area. It supports drag-and-drop reordering of tabs, scrollable
/// tab overflow, and customizable leading/trailing elements in the tab bar.
///
/// The widget manages both the tab selection state and the tab ordering, providing
/// callbacks for both focus changes and sort operations. The tab bar is horizontally
/// scrollable when tabs exceed the available width, with fade effects at the edges.
///
/// Features:
/// - Drag-and-drop sortable tabs with visual feedback
/// - Horizontal scrolling with edge fade effects for tab overflow
/// - Integrated content area with customizable styling  
/// - Leading and trailing widget support in the tab bar
/// - Custom tab rendering through builder patterns
/// - Comprehensive theming and styling options
/// - Automatic focus management during sorting operations
///
/// The content area is styled as a card-like container that appears above the
/// tab bar, creating a cohesive tabbed interface suitable for complex applications.
///
/// Example:
/// ```dart
/// TabPane<String>(
///   items: [
///     TabPaneData('tab1'),
///     TabPaneData('tab2'),
///     TabPaneData('tab3'),
///   ],
///   focused: currentTab,
///   onFocused: (index) => setState(() => currentTab = index),
///   onSort: (newOrder) => setState(() => tabOrder = newOrder),
///   itemBuilder: (context, item, index) => TabChild(
///     child: Text(item.data),
///   ),
///   child: IndexedStack(
///     index: currentTab,
///     children: tabContent,
///   ),
/// )
/// ```
class TabPane<T> extends StatefulWidget {
  /// List of tab data items to display in the tab pane.
  ///
  /// Type: `List<TabPaneData<T>>`. Each item contains the data for one tab
  /// and will be passed to the [itemBuilder] to create the visual representation.
  final List<TabPaneData<T>> items;
  /// Builder function to create tab child widgets from data items.
  ///
  /// Type: `TabPaneItemBuilder<T>`. Called for each tab item to create the
  /// visual representation in the tab bar. Should return a TabChild widget.
  final TabPaneItemBuilder<T> itemBuilder;
  /// Callback invoked when tabs are reordered through drag-and-drop.
  ///
  /// Type: `ValueChanged<List<TabPaneData<T>>>?`. Called with the new tab
  /// order when sorting operations complete. If null, sorting is disabled.
  final ValueChanged<List<TabPaneData<T>>>? onSort;
  /// Index of the currently focused/selected tab.
  ///
  /// Type: `int`. Zero-based index of the active tab. The focused tab receives
  /// special visual styling and its content is typically displayed.
  final int focused;
  /// Callback invoked when the focused tab changes.
  ///
  /// Type: `ValueChanged<int>`. Called when a tab is selected either through
  /// user interaction or programmatic changes during sorting operations.
  final ValueChanged<int> onFocused;
  /// Widgets displayed at the leading edge of the tab bar.
  ///
  /// Type: `List<Widget>`, default: `[]`. These widgets appear before the
  /// scrollable tab area, useful for controls or branding elements.
  final List<Widget> leading;
  /// Widgets displayed at the trailing edge of the tab bar.
  ///
  /// Type: `List<Widget>`, default: `[]`. These widgets appear after the
  /// scrollable tab area, useful for actions or controls.
  final List<Widget> trailing;
  /// Border radius for the tab pane container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's large border
  /// radius. Applied to both the content area and tab styling.
  final BorderRadiusGeometry? borderRadius;
  /// Background color for the content area and active tabs.
  ///
  /// Type: `Color?`. If null, uses the theme's card background color.
  /// Provides consistent styling across the tab pane components.
  final Color? backgroundColor;
  /// Border styling for the tab pane container.
  ///
  /// Type: `BorderSide?`. If null, uses theme defaults for border appearance
  /// around the entire tab pane structure.
  final BorderSide? border;
  /// The main content widget displayed in the content area.
  ///
  /// Type: `Widget`. This widget fills the content area above the tab bar
  /// and typically shows content related to the currently focused tab.
  final Widget child;
  /// Height of the tab bar area in logical pixels.
  ///
  /// Type: `double?`. If null, uses 32 logical pixels scaled by theme scaling.
  /// Determines the vertical space allocated for tab buttons.
  final double? barHeight;
  /// Creates a [TabPane] with sortable tabs and integrated content display.
  ///
  /// Configures a comprehensive tab interface that combines sortable tab management
  /// with a content display area, providing a complete tabbed user interface.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [items] (`List<TabPaneData<T>>`, required): Tab data items to display
  /// - [itemBuilder] (`TabPaneItemBuilder<T>`, required): Builder for tab widgets
  /// - [focused] (int, default: 0): Index of the currently focused tab
  /// - [onFocused] (`ValueChanged<int>`, required): Callback for focus changes
  /// - [child] (Widget, required): Content widget for the main display area
  /// - [onSort] (`ValueChanged<List<TabPaneData<T>>>?`, optional): Callback for tab reordering
  /// - [leading] (`List<Widget>`, default: []): Widgets before the tab area
  /// - [trailing] (`List<Widget>`, default: []): Widgets after the tab area
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Border radius override
  /// - [backgroundColor] (Color?, optional): Background color override
  /// - [border] (BorderSide?, optional): Border styling override
  /// - [barHeight] (double?, optional): Tab bar height override
  ///
  /// Example:
  /// ```dart
  /// TabPane<DocumentTab>(
  ///   items: documentTabs.map(TabPaneData.new).toList(),
  ///   focused: activeDocumentIndex,
  ///   onFocused: switchToDocument,
  ///   onSort: reorderDocuments,
  ///   leading: [IconButton(icon: Icon(Icons.add), onPressed: newDocument)],
  ///   trailing: [IconButton(icon: Icon(Icons.settings), onPressed: showSettings)],
  ///   itemBuilder: (context, item, index) => TabChild(
  ///     child: Row(
  ///       children: [
  ///         Text(item.data.title),
  ///         IconButton(icon: Icon(Icons.close), onPressed: () => closeTab(index)),
  ///       ],
  ///     ),
  ///   ),
  ///   child: DocumentEditor(document: documents[activeDocumentIndex]),
  /// )
  /// ```
  const TabPane({super.key, required this.items, required this.itemBuilder, this.focused = 0, required this.onFocused, this.leading = const [], this.trailing = const [], this.borderRadius, this.backgroundColor, this.border, this.onSort, required this.child, this.barHeight});
  State<TabPane<T>> createState();
}
```
