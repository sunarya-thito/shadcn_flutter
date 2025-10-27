---
title: "Class: TabPaneData"
description: "Data wrapper for tab pane items that extends sortable functionality."
---

```dart
/// Data wrapper for tab pane items that extends sortable functionality.
///
/// TabPaneData extends SortableData to provide drag-and-drop reordering
/// capabilities for tab pane items. Each tab item is wrapped in this data
/// structure to enable sorting operations.
///
/// Example:
/// ```dart
/// TabPaneData<String>('tab_content')
/// TabPaneData<TabInfo>(TabInfo(title: 'Tab 1', content: widget))
/// ```
class TabPaneData<T> extends SortableData<T> {
  /// Creates a [TabPaneData] wrapper for tab content.
  ///
  /// Wraps the provided data for use in sortable tab pane operations.
  ///
  /// Parameters:
  /// - [data] (T): The data to associate with this tab item
  const TabPaneData(super.data);
}
```
