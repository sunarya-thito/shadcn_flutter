# TabPane

A comprehensive tab pane widget with sortable tabs and integrated content display.

## Usage

### Tab Pane Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/tab_pane/tab_pane_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabPaneExample extends StatelessWidget {
  const TabPaneExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tab_pane',
      description:
          'A chrome-like tab pane that allows you to switch between different tabs.',
      displayName: 'Tab Pane',
      children: [
        WidgetUsageExample(
          title: 'Tab Pane Example',
          summarize: false,
          path: 'lib/pages/docs/components/tab_pane/tab_pane_example_1.dart',
          child: TabPaneExample1(),
        ),
      ],
    );
  }
}

```

### Tab Pane Example 1
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
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                tabs.remove(data);
              });
            },
          ),
          child: Text(data.title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabPane<MyTab>(
      // children: tabs.map((e) => _buildTabItem(e)).toList(),
      // Provide the items and how to render each tab header.
      items: tabs,
      itemBuilder: (context, item, index) {
        return _buildTabItem(item.data);
      },
      // The currently focused tab index.
      focused: focused,
      onFocused: (value) {
        setState(() {
          focused = value;
        });
      },
      // Allow reordering via drag-and-drop; update the list with the new order.
      onSort: (value) {
        setState(() {
          tabs = value;
        });
      },
      // Optional leading/trailing actions for the tab strip.
      leading: [
        IconButton.secondary(
          icon: const Icon(Icons.arrow_drop_down),
          size: ButtonSize.small,
          density: ButtonDensity.iconDense,
          onPressed: () {},
        ),
      ],
      trailing: [
        IconButton.ghost(
          icon: const Icon(Icons.add),
          size: ButtonSize.small,
          density: ButtonDensity.iconDense,
          onPressed: () {
            setState(() {
              int max = tabs.fold<int>(0, (previousValue, element) {
                return element.data.count > previousValue
                    ? element.data.count
                    : previousValue;
              });
              tabs.add(TabPaneData(
                  MyTab('Tab ${max + 1}', max + 1, 'Content ${max + 1}')));
            });
          },
        )
      ],
      // The content area; you can render based on the focused index.
      child: SizedBox(
        height: 400,
        child: Center(
          child: Text('Tab ${focused + 1}').xLarge().bold(),
        ),
      ),
    );
  }
}

```

### Tab Pane Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabPaneTile extends StatelessWidget implements IComponentPage {
  const TabPaneTile({super.key});

  @override
  String get title => 'Tab Pane';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'tab_pane',
      title: 'Tab Pane',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Tab headers
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Tab 1',
                        style: TextStyle(
                          color: theme.colorScheme.primaryForeground,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Text(
                        'Tab 2',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: const Text(
                        'Tab 3',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              // Tab content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('Tab 1 Content'),
                  ),
                ),
              ),
            ],
          ),
        ),
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
| `items` | `List<TabPaneData<T>>` | List of tab data items to display in the tab pane.  Type: `List<TabPaneData<T>>`. Each item contains the data for one tab and will be passed to the [itemBuilder] to create the visual representation. |
| `itemBuilder` | `TabPaneItemBuilder<T>` | Builder function to create tab child widgets from data items.  Type: `TabPaneItemBuilder<T>`. Called for each tab item to create the visual representation in the tab bar. Should return a TabChild widget. |
| `onSort` | `ValueChanged<List<TabPaneData<T>>>?` | Callback invoked when tabs are reordered through drag-and-drop.  Type: `ValueChanged<List<TabPaneData<T>>>?`. Called with the new tab order when sorting operations complete. If null, sorting is disabled. |
| `focused` | `int` | Index of the currently focused/selected tab.  Type: `int`. Zero-based index of the active tab. The focused tab receives special visual styling and its content is typically displayed. |
| `onFocused` | `ValueChanged<int>` | Callback invoked when the focused tab changes.  Type: `ValueChanged<int>`. Called when a tab is selected either through user interaction or programmatic changes during sorting operations. |
| `leading` | `List<Widget>` | Widgets displayed at the leading edge of the tab bar.  Type: `List<Widget>`, default: `[]`. These widgets appear before the scrollable tab area, useful for controls or branding elements. |
| `trailing` | `List<Widget>` | Widgets displayed at the trailing edge of the tab bar.  Type: `List<Widget>`, default: `[]`. These widgets appear after the scrollable tab area, useful for actions or controls. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for the tab pane container.  Type: `BorderRadiusGeometry?`. If null, uses the theme's large border radius. Applied to both the content area and tab styling. |
| `backgroundColor` | `Color?` | Background color for the content area and active tabs.  Type: `Color?`. If null, uses the theme's card background color. Provides consistent styling across the tab pane components. |
| `border` | `BorderSide?` | Border styling for the tab pane container.  Type: `BorderSide?`. If null, uses theme defaults for border appearance around the entire tab pane structure. |
| `child` | `Widget` | The main content widget displayed in the content area.  Type: `Widget`. This widget fills the content area above the tab bar and typically shows content related to the currently focused tab. |
| `barHeight` | `double?` | Height of the tab bar area in logical pixels.  Type: `double?`. If null, uses 32 logical pixels scaled by theme scaling. Determines the vertical space allocated for tab buttons. |
