import '../../../../shadcn_flutter.dart';

class TabContainerData {
  static TabContainerData of(BuildContext context) {
    var data = Data.maybeOf<TabContainerData>(context);
    assert(data != null, 'TabChild must be a descendant of TabContainer');
    return data!;
  }

  final int index;
  final int selected;
  final ValueChanged<int>? onSelect;
  final TabChildBuilder childBuilder;

  TabContainerData({
    required this.index,
    required this.selected,
    required this.onSelect,
    required this.childBuilder,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabContainerData &&
        other.selected == selected &&
        other.onSelect == onSelect &&
        other.index == index &&
        other.childBuilder == childBuilder;
  }

  @override
  int get hashCode => Object.hash(index, selected, onSelect, childBuilder);
}

mixin TabChild on Widget {
  bool get indexed;
}

mixin KeyedTabChild<T> on TabChild {
  T get tabKey;
}

class TabChildWidget extends StatelessWidget with TabChild {
  final Widget child;
  final bool indexed;

  const TabChildWidget({
    super.key,
    required this.child,
    this.indexed = false,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class KeyedTabChildWidget<T> extends TabChildWidget with KeyedTabChild<T> {
  KeyedTabChildWidget({
    required T key,
    required super.child,
    super.indexed,
  }) : super(key: ValueKey(key));

  @override
  ValueKey<T> get key => super.key as ValueKey<T>;

  @override
  T get tabKey => key.value;
}

class TabItem extends StatelessWidget with TabChild {
  final Widget child;

  const TabItem({
    super.key,
    required this.child,
  });

  @override
  bool get indexed => true;

  @override
  Widget build(BuildContext context) {
    TabContainerData data = TabContainerData.of(context);
    return data.childBuilder(context, data, child);
  }
}

class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  KeyedTabItem({
    required T key,
    required super.child,
  }) : super(key: ValueKey(key));

  @override
  ValueKey<T> get key => super.key as ValueKey<T>;

  @override
  T get tabKey => key.value;
}

typedef TabBuilder = Widget Function(
    BuildContext context, List<Widget> children);
typedef TabChildBuilder = Widget Function(
    BuildContext context, TabContainerData data, Widget child);

class TabContainer extends StatelessWidget {
  final int selected;
  final ValueChanged<int>? onSelect;
  final List<TabChild> children;
  final TabBuilder builder;
  final TabChildBuilder childBuilder;

  const TabContainer({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.children,
    required this.builder,
    required this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> wrappedChildren = [];
    int index = 0;
    for (TabChild child in children) {
      if (child.indexed) {
        wrappedChildren.add(
          Data.inherit(
            key: ValueKey(child),
            data: TabContainerData(
              index: index,
              selected: selected,
              onSelect: onSelect,
              childBuilder: childBuilder,
            ),
            child: child,
          ),
        );
        index++;
      } else {
        wrappedChildren.add(
          child,
        );
      }
    }
    return builder(
      context,
      wrappedChildren,
    );
  }
}
