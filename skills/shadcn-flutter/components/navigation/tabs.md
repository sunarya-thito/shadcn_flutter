# Tabs

A tabbed interface widget for organizing content into switchable panels.

## Usage

### Tabs Example
```dart
import 'package:docs/pages/docs/components/tabs/tabs_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TabsExample extends StatelessWidget {
  const TabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tabs',
      description: 'A list of tabs for selecting a single item.',
      displayName: 'Tabs',
      children: [
        WidgetUsageExample(
          title: 'Tabs Example',
          path: 'lib/pages/docs/components/tabs/tabs_example_1.dart',
          child: TabsExample1(),
        ),
      ],
    );
  }
}

```

### Tabs Example 1
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates Tabs as a header paired with an IndexedStack body.
// Tabs manages the active index; the stack swaps content without unmounting.

class TabsExample1 extends StatefulWidget {
  const TabsExample1({super.key});

  @override
  State<TabsExample1> createState() => _TabsExample1State();
}

class _TabsExample1State extends State<TabsExample1> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tabs(
          // Bind the active tab index; Tabs is the header-only control.
          index: index,
          children: const [
            TabItem(child: Text('Tab 1')),
            TabItem(child: Text('Tab 2')),
            TabItem(child: Text('Tab 3')),
          ],
          onChanged: (int value) {
            // Keep header and body in sync by updating state.
            setState(() {
              index = value;
            });
          },
        ),
        const Gap(8),
        // The IndexedStack acts as the tab body; it switches content by index
        // without unmounting inactive children.
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

### Tabs Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabsTile extends StatelessWidget implements IComponentPage {
  const TabsTile({super.key});

  @override
  String get title => 'Tabs';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Tabs',
      name: 'tabs',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            Tabs(index: 0, onChanged: (value) {}, children: const [
              // Text('Tab 1'),
              // Text('Tab 2'),
              // Text('Tab 3'),
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
            Tabs(index: 1, onChanged: (value) {}, children: const [
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
            Tabs(index: 2, onChanged: (value) {}, children: const [
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
          ],
        ).gap(8),
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
| `index` | `int` | The index of the currently selected tab (0-indexed).  Must be between 0 and `children.length - 1` inclusive. |
| `expand` | `bool` | Used to expand children horizontally |
| `onChanged` | `ValueChanged<int>` | Callback invoked when the user selects a different tab.  Called with the new tab index when the user taps a tab header. |
| `children` | `List<TabChild>` | List of tab children defining tab headers and content.  Each [TabChild] contains a tab header widget and the associated content panel widget. The list must not be empty. |
| `padding` | `EdgeInsetsGeometry?` | Optional padding around individual tabs.  Overrides the theme's tab padding if provided. If `null`, uses the padding from [TabsTheme]. |
