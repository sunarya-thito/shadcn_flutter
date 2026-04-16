# TabListTheme

Theme configuration for [TabList] appearance and behavior.

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
| `borderColor` | `Color?` | Color of the bottom border line separating tabs from content.  Type: `Color?`. If null, uses the theme's border color. This creates visual separation between the tab bar and the content area. |
| `borderWidth` | `double?` | Width of the bottom border line in logical pixels.  Type: `double?`. If null, uses 1 logical pixel scaled by theme scaling. The border provides structure and visual hierarchy to the tab interface. |
| `indicatorColor` | `Color?` | Color of the active tab indicator line.  Type: `Color?`. If null, uses the theme's primary color. The indicator clearly shows which tab is currently active. |
| `indicatorHeight` | `double?` | Height of the active tab indicator line in logical pixels.  Type: `double?`. If null, uses 2 logical pixels scaled by theme scaling. The indicator appears at the bottom of the active tab. |
