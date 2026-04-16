# TabList

A horizontal tab list widget for selecting between multiple tab content areas.

## Usage

### Tab List Example
```dart
import 'package:docs/pages/docs/components/tab_list/tab_list_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TabListExample extends StatelessWidget {
  const TabListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tab_list',
      description: 'A list of tabs for selecting a single item.',
      displayName: 'Tab List',
      children: [
        WidgetUsageExample(
          title: 'Tab List Example',
          path: 'lib/pages/docs/components/tab_list/tab_list_example_1.dart',
          child: TabListExample1(),
        ),
      ],
    );
  }
}

```

### Tab List Example 1
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates TabList (a low-level tab header) with an IndexedStack body.
// The header controls the index; the content is managed separately.

class TabListExample1 extends StatefulWidget {
  const TabListExample1({super.key});

  @override
  State<TabListExample1> createState() => _TabListExample1State();
}

class _TabListExample1State extends State<TabListExample1> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabList(
          // TabList is a lower-level tab header; it doesn't manage content.
          index: index,
          onChanged: (value) {
            setState(() {
              index = value;
            });
          },
          children: const [
            TabItem(
              child: Text('Tab 1'),
            ),
            TabItem(
              child: Text('Tab 2'),
            ),
            TabItem(
              child: Text('Tab 3'),
            ),
          ],
        ),
        const Gap(16),
        // Like Tabs example, use an IndexedStack to switch the content area.
        IndexedStack(
          index: index,
          children: const [
            NumberedContainer(
              index: 1,
            ),
            NumberedContainer(
              index: 2,
            ),
            NumberedContainer(
              index: 3,
            ),
          ],
        ).sized(height: 300),
      ],
    );
  }
}

```

### Tab List Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabListTile extends StatelessWidget implements IComponentPage {
  const TabListTile({super.key});

  @override
  String get title => 'Tab List';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tab_list',
      title: 'Tab List',
      scale: 1,
      reverseVertical: true,
      verticalOffset: 60,
      example: TabList(
        index: 0,
        onChanged: (value) {},
        children: const [
          TabItem(child: Text('Preview')),
          TabItem(child: Text('Code')),
          TabItem(child: Text('Design')),
          TabItem(child: Text('Settings')),
        ],
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `children` | `List<TabChild>` | List of tab child widgets to display in the tab list.  Type: `List<TabChild>`. Each TabChild represents one selectable tab with its own label and optional content. The tabs are displayed in the order provided in the list. |
| `index` | `int` | Index of the currently active/selected tab.  Type: `int`. Zero-based index indicating which tab is currently active. Must be within the bounds of the [children] list. The active tab receives special styling and the indicator line. |
| `onChanged` | `ValueChanged<int>?` | Callback invoked when a tab is selected.  Type: `ValueChanged<int>?`. Called with the index of the newly selected tab when the user taps on a tab button. If null, tabs are not interactive. |
