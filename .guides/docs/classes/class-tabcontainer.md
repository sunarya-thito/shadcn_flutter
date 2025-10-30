---
title: "Class: TabContainer"
description: "Container widget for managing multiple tabs."
---

```dart
/// Container widget for managing multiple tabs.
///
/// Provides tab selection and content display with customizable builders.
class TabContainer extends StatelessWidget {
  /// Currently selected tab index.
  final int selected;
  /// Callback when tab selection changes.
  final ValueChanged<int>? onSelect;
  /// List of tab children to display.
  final List<TabChild> children;
  /// Optional custom tab layout builder.
  final TabBuilder? builder;
  /// Optional custom child widget builder.
  final TabChildBuilder? childBuilder;
  /// Creates a [TabContainer].
  ///
  /// Parameters:
  /// - [selected] (`int`, required): index of the selected tab
  /// - [onSelect] (`ValueChanged<int>?`, optional): callback when tab changes
  /// - [children] (`List<TabChild>`, required): list of tab items
  /// - [builder] (`TabBuilder?`, optional): custom tab layout builder
  /// - [childBuilder] (`TabChildBuilder?`, optional): custom child builder
  const TabContainer({super.key, required this.selected, required this.onSelect, required this.children, this.builder, this.childBuilder});
  Widget build(BuildContext context);
}
```
