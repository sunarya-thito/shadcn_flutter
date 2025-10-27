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
