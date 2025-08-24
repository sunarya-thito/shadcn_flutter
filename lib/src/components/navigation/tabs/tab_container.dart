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
      childBuilder:
          childBuilder == null ? this.childBuilder : childBuilder(),
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

/// Contextual data for tab children within a [TabContainer].
///
/// [TabContainerData] provides the necessary context information for widgets
/// that are children of a [TabContainer], including the current selection state,
/// the child's index, and callbacks for handling selection changes.
///
/// This data is automatically provided by [TabContainer] and can be accessed
/// by child widgets using [TabContainerData.of(context)].
class TabContainerData {
  /// Retrieves the [TabContainerData] from the widget tree context.
  ///
  /// This method searches up the widget tree for the nearest [TabContainer]
  /// and returns its associated data. If no [TabContainer] is found in the
  /// ancestor chain, an assertion error is thrown.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Widget tree context to search from
  ///
  /// Returns the [TabContainerData] instance from the nearest ancestor [TabContainer].
  ///
  /// Throws [AssertionError] if no [TabContainer] is found in the widget tree.
  static TabContainerData of(BuildContext context) {
    var data = Data.maybeOf<TabContainerData>(context);
    assert(data != null, 'TabChild must be a descendant of TabContainer');
    return data!;
  }

  /// The zero-based index of this tab child within the container.
  final int index;
  
  /// The index of the currently selected tab in the container.
  final int selected;
  
  /// Callback invoked when a tab selection change is requested.
  final ValueChanged<int>? onSelect;
  
  /// Builder function for constructing child widgets within tabs.
  final TabChildBuilder childBuilder;

  /// Creates a [TabContainerData] with the specified properties.
  ///
  /// Parameters:
  /// - [index] (int, required): Zero-based index of this tab child
  /// - [selected] (int, required): Index of the currently selected tab
  /// - [onSelect] (ValueChanged<int>?, optional): Selection change callback
  /// - [childBuilder] (TabChildBuilder, required): Child widget builder
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

/// Mixin for widgets that can be used as children within a [TabContainer].
///
/// [TabChild] defines the interface that widgets must implement to be
/// compatible with tab container systems. It primarily indicates whether
/// the child should be automatically indexed within the container.
///
/// Widgets that mix in [TabChild] can be placed within tab containers
/// and will receive appropriate contextual data through [TabContainerData].
mixin TabChild on Widget {
  /// Whether this tab child should be automatically indexed by the container.
  ///
  /// When `true`, the tab container will assign an index to this child and
  /// include it in the selection system. When `false`, the child is treated
  /// as a non-interactive or decorative element.
  bool get indexed;
}

/// Mixin for tab children that can be identified by a key of type [T].
///
/// [KeyedTabChild] extends [TabChild] to provide a strongly-typed key system
/// for identifying and managing tab children. This is useful when tabs need
/// to be referenced by something other than their numeric index.
///
/// The key type [T] can be any type that uniquely identifies the tab child,
/// such as String, enum values, or custom identifier objects.
///
/// Example usage:
/// ```dart
/// class MyTabChild extends StatelessWidget with TabChild, KeyedTabChild<String> {
///   @override
///   String get tabKey => 'unique-tab-id';
///   
///   @override
///   bool get indexed => true;
///   
///   // ... widget implementation
/// }
/// ```
mixin KeyedTabChild<T> on TabChild {
  /// The unique key that identifies this tab child.
  ///
  /// This key should be unique within the tab container and remain constant
  /// for the lifetime of the tab child widget.
  T get tabKey;
}

/// A wrapper widget that implements the [TabChild] interface for arbitrary widgets.
///
/// [TabChildWidget] allows any widget to be used within a [TabContainer] by
/// wrapping it and providing the required [TabChild] interface. This is useful
/// when you need to include widgets in tabs that don't natively implement
/// the [TabChild] mixin.
class TabChildWidget extends StatelessWidget with TabChild {
  /// The widget to display as the tab child content.
  ///
  /// This can be any widget, from simple text to complex layouts.
  final Widget child;
  
  @override
  /// Whether this tab child should be automatically indexed by the container.
  ///
  /// When `true`, the tab container will assign an index to this child and
  /// include it in the selection system. When `false`, the child is treated
  /// as a non-interactive or decorative element.
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

/// A keyed wrapper widget that implements both [TabChild] and [KeyedTabChild] interfaces.
///
/// [KeyedTabChildWidget] extends [TabChildWidget] to provide a strongly-typed key
/// system for identifying tab children. The key is used both as the widget key
/// and the tab identifier.
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

/// A tab item widget that automatically integrates with tab container theming.
///
/// [TabItem] provides a standardized way to create tab content that uses the
/// tab container's configured child builder for consistent styling and behavior.
/// Unlike [TabChildWidget], this always participates in tab indexing.
class TabItem extends StatelessWidget with TabChild {
  /// The widget content to display within the tab.
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

/// A keyed tab item that combines [TabItem] functionality with key-based identification.
///
/// [KeyedTabItem] provides the same theming integration as [TabItem] while
/// adding strongly-typed key support for programmatic tab management.
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

/// A function signature for building tab container layouts from child widgets.
///
/// Takes a build context and list of prepared tab children, returning the
/// widget that arranges them within the container.
typedef TabBuilder = Widget Function(
    BuildContext context, List<Widget> children);
    
/// A function signature for building individual tab child widgets.
///
/// Takes a build context, tab container data, and the child widget,
/// returning the widget with applied tab styling and behavior.
typedef TabChildBuilder = Widget Function(
    BuildContext context, TabContainerData data, Widget child);

/// A container widget that manages tab children with selection state and theming.
///
/// [TabContainer] provides the infrastructure for tab-based interfaces by managing
/// the selection state, providing contextual data to child widgets, and applying
/// consistent styling through builder functions. It works with widgets that
/// implement the [TabChild] mixin.
///
/// The container automatically indexes eligible children and provides them with
/// [TabContainerData] containing selection state and interaction callbacks.
class TabContainer extends StatelessWidget {
  /// The index of the currently selected tab.
  ///
  /// Must be a valid index within the range of indexed tab children.
  final int selected;
  
  /// Callback invoked when tab selection changes.
  ///
  /// Receives the index of the newly selected tab. May be null to disable selection.
  final ValueChanged<int>? onSelect;
  
  /// List of tab child widgets to display within the container.
  ///
  /// Only children with [TabChild.indexed] set to true will participate in
  /// the selection system and receive index values.
  final List<TabChild> children;
  
  /// Custom builder for arranging tab children within the container.
  ///
  /// When null, uses the theme builder or defaults to a vertical column layout.
  final TabBuilder? builder;
  
  /// Custom builder for styling individual tab children.
  ///
  /// When null, uses the theme child builder or passes children through unchanged.
  final TabChildBuilder? childBuilder;

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
    final tabBuilder =
        builder ?? compTheme?.builder ?? (context, children) => Column(children: children);
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
