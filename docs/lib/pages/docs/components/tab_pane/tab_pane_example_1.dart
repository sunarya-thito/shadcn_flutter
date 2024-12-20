import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabPaneExample1 extends StatefulWidget {
  const TabPaneExample1({super.key});

  @override
  State<TabPaneExample1> createState() => _TabPaneExample1State();
}

class _TabPaneExample1State extends State<TabPaneExample1> {
  late List<TabItem> tabs;
  int focused = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabs = [
      for (int i = 0; i < 3; i++) _buildTabItem(i),
    ];
  }

  TabItem _buildTabItem(int index) {
    return TabItem(
      key: ValueKey(index),
      title: Text('Tab ${index + 1}'),
      constraints: const BoxConstraints(minWidth: 150),
      leading: OutlinedContainer(
        backgroundColor: Colors.white,
        width: 18,
        height: 18,
        borderRadius: Theme.of(context).borderRadiusMd,
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.black),
          ).xSmall().bold(),
        ),
      ),
      trailing: IconButton.ghost(
        shape: ButtonShape.circle,
        size: ButtonSize.xSmall,
        icon: Icon(Icons.close),
        onPressed: () {
          setState(() {
            tabs.removeWhere((element) => element.key == ValueKey(index));
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabPane(
      tabs: tabs,
      focused: tabs
          .indexWhere((element) => (element.key as ValueKey).value == focused),
      onFocused: (value) {
        setState(() {
          focused = (tabs[value].key as ValueKey).value;
        });
      },
      onSort: (value) {
        setState(() {
          tabs = value;
        });
      },
      leading: [
        IconButton.secondary(
          icon: Icon(Icons.arrow_drop_down),
          size: ButtonSize.small,
          density: ButtonDensity.iconDense,
          onPressed: () {},
        ),
      ],
      trailing: [
        IconButton.ghost(
          icon: Icon(Icons.add),
          size: ButtonSize.small,
          density: ButtonDensity.iconDense,
          onPressed: () {
            setState(() {
              int max = tabs.fold<int>(0, (previousValue, element) {
                return (element.key as ValueKey).value > previousValue
                    ? (element.key as ValueKey).value
                    : previousValue;
              });
              tabs.add(_buildTabItem(max + 1));
            });
          },
        )
      ],
      child: Container(
        child: Center(
          child: Text('Tab ${focused + 1}').xLarge().bold(),
        ),
        height: 400,
      ),
    );
  }
}
