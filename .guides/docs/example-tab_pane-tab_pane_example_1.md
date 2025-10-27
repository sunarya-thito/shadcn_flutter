---
title: "Example: components/tab_pane/tab_pane_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates TabPane with sortable, closable tabs backed by custom data.
// Tracks a focused index and renders a content area for the active tab.

class TabPaneExample1 extends StatefulWidget {
  const TabPaneExample1({super.key});

  @override
  State<TabPaneExample1> createState() => _TabPaneExample1State();
}

class MyTab {
  final String title;
  final int count;
  final String content;
  MyTab(this.title, this.count, this.content);

  @override
  String toString() {
    return 'TabData{title: $title, count: $count, content: $content}';
  }
}

class _TabPaneExample1State extends State<TabPaneExample1> {
  late List<TabPaneData<MyTab>> tabs;
  int focused = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Build the initial set of tabs. TabPaneData wraps your custom data type
    // (here, MyTab) and adds selection/drag metadata.
    tabs = [
      for (int i = 0; i < 3; i++)
        TabPaneData(MyTab('Tab ${i + 1}', i + 1, 'Content ${i + 1}')),
    ];
  }

  // Render a single tab header item. It shows a badge-like count and a close button.
  TabItem _buildTabItem(MyTab data) {
    return TabItem(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150),
        child: Label(
          leading: OutlinedContainer(
            backgroundColor: Colors.white,
            width: 18,
            height: 18,
            borderRadius: Theme.of(context).borderRadiusMd,
            child: Center(
              child: Text(
                data.count.toString(),
                style: const TextStyle(color: Colors.black),
              ).xSmall().bold(),
            ),
          ),
          trailing: IconButton.ghost(
            shape: ButtonShape.circle,
            size: ButtonSize.xSmall,
```
