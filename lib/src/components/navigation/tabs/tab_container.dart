import '../../../../shadcn_flutter.dart';

/// {@template tab_container_theme}
/// Theme data for [TabContainer] providing default builders.
/// {@endtemplate}
class TabContainerTheme {
  /// Default builder for laying out tab children.
  final TabBuilder? builder;

  /// Default builder for wrapping each tab child.
  final TabChildBuilder? childBuilder;

  /// {@macro tab_container_theme}
  const TabContainerTheme({
    this.builder,
    this.childBuilder,
  });

  /// Creates a copy of this theme with the given fields replaced.
  TabContainerTheme copyWith({
    ValueGetter<TabBuilder?>? builder,
    ValueGetter<TabChildBuilder?>? childBuilder,
  }) {
    return TabContainerTheme(
      builder: builder == null ? this.builder : builder(),
      childBuilder: childBuilder == null ? this.childBuilder : childBuilder(),
    );
  }

  @override
  int get hashCode => Object.hash(builder, childBuilder);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabContainerTheme &&
        other.builder == builder &&
        other.childBuilder == childBuilder;
  }

  @override
  String toString() {
    return 'TabContainerTheme(builder: $builder, childBuilder: $childBuilder)';
  }
}

/// Internal data class holding tab container state and callbacks.
///
/// Provides context information to child tabs including the current
/// selection state, tab index, and selection callback. Used internally
/// by the tab system to coordinate between container and children.
///
/// Accessed via [TabContainerData.of] from within tab child widgets.
class TabContainerData {
  /// Retrieves the nearest [TabContainerData] from the widget tree.
  ///
  /// Throws an assertion error if no [TabContainer] is found in the
  /// ancestor chain, as tab children must be descendants of a tab container.
  ///
  /// Parameters:
  /// - [context]: Build context to search from
  ///
  /// Returns the container data.
  static TabContainerData of(BuildContext context) {
    var data = Data.maybeOf<TabContainerData>(context);
    assert(data != null, 'TabChild must be a descendant of TabContainer');
    return data!;
  }

  /// The index of this tab within the container (0-indexed).
  final int index;

  /// The index of the currently selected tab.
  final int selected;

  /// Callback to invoke when this tab should be selected.
  ///
  /// Called with the tab's index when the user interacts with the tab.
  final ValueChanged<int>? onSelect;

  /// Builder function for wrapping tab child content.
  ///
  /// Applies consistent styling or layout to tab children.
  final TabChildBuilder childBuilder;

  /// Creates tab container data.
  ///
  /// Parameters:
  /// - [index]: This tab's index (required)
  /// - [selected]: Currently selected tab index (required)
  /// - [onSelect]: Selection callback (required)
  /// - [childBuilder]: Child wrapping builder (required)
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

/// Mixin for widgets that can be used as tab children.
///
/// Provides the interface for tab child widgets, indicating whether
/// the child participates in indexed tab selection.
mixin TabChild on Widget {
  /// Whether this tab child uses indexed positioning.
  ///
  /// When `true`, the tab's position in the list determines its index.
  /// When `false`, the tab may use a custom key for identification.
  bool get indexed;
}

/// Mixin for keyed tab children that use custom keys for identification.
///
/// Extends [TabChild] to support tab children identified by custom keys
/// of type [T] rather than positional indices.
///
/// Type parameter [T] is the type of the key used to identify this tab.
mixin KeyedTabChild<T> on TabChild {
  /// The unique key identifying this tab.
  ///
  /// Used instead of positional index for tab selection and tracking.
  T get tabKey;
}

/// A simple tab child widget wrapping arbitrary content.
///
/// Implements [TabChild] to make any widget usable within a tab container.
/// The wrapped child is rendered directly without additional decoration.
class TabChildWidget extends StatelessWidget with TabChild {
  /// The child widget to display.
  final Widget child;

  @override

  /// Whether this tab uses indexed positioning.
  ///
  /// Defaults to `false` unless specified in the constructor.
  final bool indexed;

  /// Creates a tab child widget.
  ///
  /// Parameters:
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (defaults to `false`)
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

/// A keyed tab child widget identified by a custom key value.
///
/// Extends [TabChildWidget] with [KeyedTabChild] to support tab identification
/// via custom keys rather than positional indices. The key value determines
/// tab selection and tracking.
///
/// Type parameter [T] is the type of the key value.
class KeyedTabChildWidget<T> extends TabChildWidget with KeyedTabChild<T> {
  /// Creates a keyed tab child widget.
  ///
  /// Parameters:
  /// - [key]: The unique key value for this tab (required)
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (optional)
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

/// A basic tab item widget.
///
/// Represents a single tab item with content that can be displayed
/// in a [TabContainer].
class TabItem extends StatelessWidget with TabChild {
  /// Content widget for this tab.
  final Widget child;

  /// Creates a [TabItem].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): content to display in this tab
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

/// A keyed tab item widget.
///
/// Similar to [TabItem] but includes a unique key for identification.
class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  /// Creates a [KeyedTabItem].
  ///
  /// Parameters:
  /// - [key] (`T`, required): unique key for this tab
  /// - [child] (`Widget`, required): content to display in this tab
  KeyedTabItem({
    required T key,
    required super.child,
  }) : super(key: ValueKey(key));

  @override
  ValueKey<T> get key => super.key as ValueKey<T>;

  @override
  T get tabKey => key.value;
}

/// Builder function for creating tab layout.
///
/// Parameters:
/// - [context] (`BuildContext`): build context
/// - [children] (`List<Widget>`): list of tab widgets
///
/// Returns: `Widget` — the tab layout widget
typedef TabBuilder = Widget Function(
    BuildContext context, List<Widget> children);

/// Builder function for creating individual tab child widgets.
///
/// Parameters:
/// - [context] (`BuildContext`): build context
/// - [data] (`TabContainerData`): tab container data
/// - [child] (`Widget`): child widget to wrap
///
/// Returns: `Widget` — the wrapped child widget
typedef TabChildBuilder = Widget Function(
    BuildContext context, TabContainerData data, Widget child);

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
  const TabContainer({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.children,
    this.builder,
    this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<TabContainerTheme>(context);
    final tabBuilder = builder ??
        compTheme?.builder ??
        (context, children) => Column(children: children);
    final tabChildBuilder =
        childBuilder ?? compTheme?.childBuilder ?? ((_, __, child) => child);

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
              childBuilder: tabChildBuilder,
            ),
            child: child,
          ),
        );
        index++;
      } else {
        wrappedChildren.add(child);
      }
    }
    return tabBuilder(
      context,
      wrappedChildren,
    );
  }
}
