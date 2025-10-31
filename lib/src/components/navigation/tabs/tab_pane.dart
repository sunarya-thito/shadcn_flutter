import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/display/fade_scroll.dart';

/// Theme configuration for [TabPane] appearance and layout.
///
/// TabPaneTheme defines the visual styling for tab pane components including
/// borders, background colors, dimensions, and corner rounding. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabPaneTheme>(
///   data: TabPaneTheme(
///     borderRadius: BorderRadius.circular(12),
///     backgroundColor: Colors.white,
///     border: BorderSide(color: Colors.grey),
///     barHeight: 40.0,
///   ),
///   child: TabPane(...),
/// )
/// ```
/// Theme for [TabPane].
class TabPaneTheme {
  /// Border radius for the tab pane container and individual tabs.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's large border radius.
  /// This affects both the main content area and the tab button appearance.
  final BorderRadiusGeometry? borderRadius;

  /// Background color for the tab pane content area and active tabs.
  ///
  /// Type: `Color?`. If null, uses the theme's card color. This provides
  /// the background for both the main content area and highlighted tabs.
  final Color? backgroundColor;

  /// Border styling for the tab pane container.
  ///
  /// Type: `BorderSide?`. If null, uses the theme's default border. This
  /// creates the outline around the entire tab pane component.
  final BorderSide? border;

  /// Height of the tab bar area in logical pixels.
  ///
  /// Type: `double?`. If null, uses 32 logical pixels scaled by theme scaling.
  /// This determines the vertical space allocated for the tab buttons.
  final double? barHeight;

  /// Creates a [TabPaneTheme].
  ///
  /// All parameters are optional and allow customization of tab pane appearance.
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Border radius for the tab pane container.
  /// - [backgroundColor] (`Color?`, optional): Background color of the tab pane.
  /// - [border] (`BorderSide?`, optional): Border styling for the tab pane.
  /// - [barHeight] (`double?`, optional): Height of the tab bar area.
  ///
  /// Example:
  /// ```dart
  /// const TabPaneTheme(
  ///   borderRadius: BorderRadius.circular(8),
  ///   backgroundColor: Colors.white,
  ///   border: BorderSide(color: Colors.grey),
  ///   barHeight: 32.0,
  /// )
  /// ```
  const TabPaneTheme({
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.barHeight,
  });

  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): new border radius getter
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): new background color getter
  /// - [border] (`ValueGetter<BorderSide?>?`, optional): new border getter
  /// - [barHeight] (`ValueGetter<double?>?`, optional): new bar height getter
  ///
  /// Returns: `TabPaneTheme` — new theme with updated values
  TabPaneTheme copyWith({
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderSide?>? border,
    ValueGetter<double?>? barHeight,
  }) {
    return TabPaneTheme(
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      border: border == null ? this.border : border(),
      barHeight: barHeight == null ? this.barHeight : barHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabPaneTheme &&
        other.borderRadius == borderRadius &&
        other.backgroundColor == backgroundColor &&
        other.border == border &&
        other.barHeight == barHeight;
  }

  @override
  int get hashCode =>
      Object.hash(borderRadius, backgroundColor, border, barHeight);
}

/// Data wrapper for tab pane items that extends sortable functionality.
///
/// TabPaneData extends SortableData to provide drag-and-drop reordering
/// capabilities for tab pane items. Each tab item is wrapped in this data
/// structure to enable sorting operations.
///
/// Example:
/// ```dart
/// TabPaneData<String>('tab_content')
/// TabPaneData<TabInfo>(TabInfo(title: 'Tab 1', content: widget))
/// ```
class TabPaneData<T> extends SortableData<T> {
  /// Creates a [TabPaneData] wrapper for tab content.
  ///
  /// Wraps the provided data for use in sortable tab pane operations.
  ///
  /// Parameters:
  /// - [data] (T): The data to associate with this tab item
  const TabPaneData(super.data);
}

/// Builder function for creating tab child widgets from tab pane data.
///
/// Takes the build context, tab data, and index to create a TabChild widget
/// that represents the visual appearance of each tab button.
///
/// Parameters:
/// - [context] (BuildContext): Build context for theme access
/// - [item] (`TabPaneData<T>`): The data for this specific tab
/// - [index] (int): Zero-based index of this tab in the list
///
/// Returns: A [TabChild] widget for the tab button
typedef TabPaneItemBuilder<T> = TabChild Function(
    BuildContext context, TabPaneData<T> item, int index);

/// A comprehensive tab pane widget with sortable tabs and integrated content display.
///
/// TabPane provides a complete tab interface that combines a sortable tab bar with
/// a content display area. It supports drag-and-drop reordering of tabs, scrollable
/// tab overflow, and customizable leading/trailing elements in the tab bar.
///
/// The widget manages both the tab selection state and the tab ordering, providing
/// callbacks for both focus changes and sort operations. The tab bar is horizontally
/// scrollable when tabs exceed the available width, with fade effects at the edges.
///
/// Features:
/// - Drag-and-drop sortable tabs with visual feedback
/// - Horizontal scrolling with edge fade effects for tab overflow
/// - Integrated content area with customizable styling
/// - Leading and trailing widget support in the tab bar
/// - Custom tab rendering through builder patterns
/// - Comprehensive theming and styling options
/// - Automatic focus management during sorting operations
///
/// The content area is styled as a card-like container that appears above the
/// tab bar, creating a cohesive tabbed interface suitable for complex applications.
///
/// Example:
/// ```dart
/// TabPane<String>(
///   items: [
///     TabPaneData('tab1'),
///     TabPaneData('tab2'),
///     TabPaneData('tab3'),
///   ],
///   focused: currentTab,
///   onFocused: (index) => setState(() => currentTab = index),
///   onSort: (newOrder) => setState(() => tabOrder = newOrder),
///   itemBuilder: (context, item, index) => TabChild(
///     child: Text(item.data),
///   ),
///   child: IndexedStack(
///     index: currentTab,
///     children: tabContent,
///   ),
/// )
/// ```
class TabPane<T> extends StatefulWidget {
  /// List of tab data items to display in the tab pane.
  ///
  /// Type: `List<TabPaneData<T>>`. Each item contains the data for one tab
  /// and will be passed to the [itemBuilder] to create the visual representation.
  final List<TabPaneData<T>> items;

  /// Builder function to create tab child widgets from data items.
  ///
  /// Type: `TabPaneItemBuilder<T>`. Called for each tab item to create the
  /// visual representation in the tab bar. Should return a TabChild widget.
  final TabPaneItemBuilder<T> itemBuilder;

  /// Callback invoked when tabs are reordered through drag-and-drop.
  ///
  /// Type: `ValueChanged<List<TabPaneData<T>>>?`. Called with the new tab
  /// order when sorting operations complete. If null, sorting is disabled.
  final ValueChanged<List<TabPaneData<T>>>? onSort;

  /// Index of the currently focused/selected tab.
  ///
  /// Type: `int`. Zero-based index of the active tab. The focused tab receives
  /// special visual styling and its content is typically displayed.
  final int focused;

  /// Callback invoked when the focused tab changes.
  ///
  /// Type: `ValueChanged<int>`. Called when a tab is selected either through
  /// user interaction or programmatic changes during sorting operations.
  final ValueChanged<int> onFocused;

  /// Widgets displayed at the leading edge of the tab bar.
  ///
  /// Type: `List<Widget>`, default: `[]`. These widgets appear before the
  /// scrollable tab area, useful for controls or branding elements.
  final List<Widget> leading;

  /// Widgets displayed at the trailing edge of the tab bar.
  ///
  /// Type: `List<Widget>`, default: `[]`. These widgets appear after the
  /// scrollable tab area, useful for actions or controls.
  final List<Widget> trailing;

  /// Border radius for the tab pane container.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's large border
  /// radius. Applied to both the content area and tab styling.
  final BorderRadiusGeometry? borderRadius;

  /// Background color for the content area and active tabs.
  ///
  /// Type: `Color?`. If null, uses the theme's card background color.
  /// Provides consistent styling across the tab pane components.
  final Color? backgroundColor;

  /// Border styling for the tab pane container.
  ///
  /// Type: `BorderSide?`. If null, uses theme defaults for border appearance
  /// around the entire tab pane structure.
  final BorderSide? border;

  /// The main content widget displayed in the content area.
  ///
  /// Type: `Widget`. This widget fills the content area above the tab bar
  /// and typically shows content related to the currently focused tab.
  final Widget child;

  /// Height of the tab bar area in logical pixels.
  ///
  /// Type: `double?`. If null, uses 32 logical pixels scaled by theme scaling.
  /// Determines the vertical space allocated for tab buttons.
  final double? barHeight;

  /// Creates a [TabPane] with sortable tabs and integrated content display.
  ///
  /// Configures a comprehensive tab interface that combines sortable tab management
  /// with a content display area, providing a complete tabbed user interface.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [items] (`List<TabPaneData<T>>`, required): Tab data items to display
  /// - [itemBuilder] (`TabPaneItemBuilder<T>`, required): Builder for tab widgets
  /// - [focused] (int, default: 0): Index of the currently focused tab
  /// - [onFocused] (`ValueChanged<int>`, required): Callback for focus changes
  /// - [child] (Widget, required): Content widget for the main display area
  /// - [onSort] (`ValueChanged<List<TabPaneData<T>>>?`, optional): Callback for tab reordering
  /// - [leading] (`List<Widget>`, default: []): Widgets before the tab area
  /// - [trailing] (`List<Widget>`, default: []): Widgets after the tab area
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Border radius override
  /// - [backgroundColor] (Color?, optional): Background color override
  /// - [border] (BorderSide?, optional): Border styling override
  /// - [barHeight] (double?, optional): Tab bar height override
  ///
  /// Example:
  /// ```dart
  /// TabPane<DocumentTab>(
  ///   items: documentTabs.map(TabPaneData.new).toList(),
  ///   focused: activeDocumentIndex,
  ///   onFocused: switchToDocument,
  ///   onSort: reorderDocuments,
  ///   leading: [IconButton(icon: Icon(Icons.add), onPressed: newDocument)],
  ///   trailing: [IconButton(icon: Icon(Icons.settings), onPressed: showSettings)],
  ///   itemBuilder: (context, item, index) => TabChild(
  ///     child: Row(
  ///       children: [
  ///         Text(item.data.title),
  ///         IconButton(icon: Icon(Icons.close), onPressed: () => closeTab(index)),
  ///       ],
  ///     ),
  ///   ),
  ///   child: DocumentEditor(document: documents[activeDocumentIndex]),
  /// )
  /// ```
  const TabPane({
    super.key,
    // required this.children,
    required this.items,
    required this.itemBuilder,
    this.focused = 0,
    required this.onFocused,
    this.leading = const [],
    this.trailing = const [],
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.onSort,
    required this.child,
    this.barHeight,
  });

  @override
  State<TabPane<T>> createState() => TabPaneState<T>();
}

class _TabGhostData {
  @override
  bool operator ==(Object other) {
    return other is _TabGhostData;
  }

  @override
  int get hashCode => 0;
}

/// State class for [TabPane] widget.
///
/// Manages the scrolling and rendering of tab pane content.
class TabPaneState<T> extends State<TabPane<T>> {
  final ScrollController _scrollController = ScrollController();

  /// Drag gesture identifier for tab interactions.
  static const kTabDrag = #tabDrag;

  Widget _childBuilder(
      BuildContext context, TabContainerData data, Widget child) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabPaneTheme>(context);
    final isFocused = data.index == data.selected;
    final backgroundColor = widget.backgroundColor ??
        compTheme?.backgroundColor ??
        theme.colorScheme.card;
    final border = widget.border ?? compTheme?.border;
    final borderColor = border?.color ?? theme.colorScheme.border;
    final borderWidth = border?.width ?? 1;
    final borderRadius =
        (widget.borderRadius ?? compTheme?.borderRadius ?? theme.borderRadiusLg)
            .optionallyResolve(context);
    return Builder(builder: (context) {
      var tabGhost = Data.maybeOf<_TabGhostData>(context);
      return SizedBox(
          height: double.infinity,
          child: CustomPaint(
              painter: _TabItemPainter(
                  borderRadius: borderRadius,
                  backgroundColor: backgroundColor,
                  isFocused: isFocused || tabGhost != null,
                  borderColor: borderColor,
                  borderWidth: borderWidth),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8) * theme.scaling,
                  child: IntrinsicWidth(
                    child: child,
                  ))));
    });
  }

  List<TabChild> _buildTabItems() {
    List<TabChild> children = [];
    for (int i = 0; i < widget.items.length; i++) {
      children.add(widget.itemBuilder(context, widget.items[i], i));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabPaneTheme>(context);
    final BorderRadiusGeometry borderRadius =
        widget.borderRadius ?? compTheme?.borderRadius ?? theme.borderRadiusLg;
    final BorderRadius resolvedBorderRadius =
        borderRadius.optionallyResolve(context);
    final backgroundColor = widget.backgroundColor ??
        compTheme?.backgroundColor ??
        theme.colorScheme.card;
    final border = widget.border ?? compTheme?.border;
    final barHeight =
        widget.barHeight ?? compTheme?.barHeight ?? (32 * theme.scaling);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context)
          .copyWith(scrollbars: false, overscroll: false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        verticalDirection: VerticalDirection.up,
        children: [
          Flexible(
            child: OutlinedContainer(
              borderRadius: resolvedBorderRadius,
              backgroundColor: backgroundColor,
              child: widget.child,
            ),
          ),
          Container(
            height: barHeight,
            padding: EdgeInsets.only(
              left: resolvedBorderRadius.bottomLeft.x,
              right: resolvedBorderRadius.bottomRight.x,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2) * theme.scaling,
                  child: Row(
                    spacing: 2 * theme.scaling,
                    children: widget.leading,
                  ),
                ),
                Flexible(
                  child: FadeScroll(
                    startOffset: resolvedBorderRadius.bottomLeft.x,
                    endOffset: resolvedBorderRadius.bottomRight.x,
                    gradient: [
                      Colors.white.withAlpha(0),
                    ],
                    endCrossOffset: border?.width ?? 1,
                    controller: _scrollController,
                    child: ClipRect(
                      clipper: _ClipRectWithAdjustment(border?.width ?? 1),
                      child: SortableLayer(
                        clipBehavior: Clip.none,
                        lock: true,
                        child: SortableDropFallback<T>(
                          onAccept: (value) {
                            if (value is! TabPaneData<T>) {
                              return;
                            }
                            bool wasFocused = widget.focused == value.data;
                            List<TabPaneData<T>> tabs = widget.items;
                            tabs.swapItem(value, tabs.length);
                            widget.onSort?.call(tabs);
                            if (wasFocused) {
                              widget.onFocused(tabs.length - 1);
                            }
                          },
                          child: ScrollableSortableLayer(
                            controller: _scrollController,
                            child: TabContainer(
                              selected: widget.focused,
                              onSelect: widget.onFocused,
                              builder: (context, children) {
                                return ListView.separated(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  padding: EdgeInsets.only(
                                    left: resolvedBorderRadius.bottomLeft.x,
                                    right: resolvedBorderRadius.bottomRight.x,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.onFocused(index);
                                      },
                                      child: Sortable<T>(
                                        key: ValueKey(index),
                                        data: widget.items[index],
                                        enabled: widget.onSort != null,
                                        onDragStart: () {
                                          widget.onFocused(index);
                                        },
                                        onAcceptLeft: (value) {
                                          if (value is! TabPaneData<T>) {
                                            return;
                                          }
                                          List<TabPaneData<T>> tabs =
                                              widget.items;
                                          tabs.swapItem(value, index);
                                          widget.onSort?.call(tabs);
                                          widget.onFocused(index);
                                        },
                                        onAcceptRight: (value) {
                                          if (value is! TabPaneData<T>) {
                                            return;
                                          }
                                          List<TabPaneData<T>> tabs =
                                              widget.items;
                                          tabs.swapItem(value, index + 1);
                                          widget.onSort?.call(tabs);
                                          widget.onFocused(index);
                                        },
                                        ghost: Data.inherit(
                                          data: _TabGhostData(),
                                          child: children[index],
                                        ),
                                        child: children[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    bool beforeIsFocused =
                                        widget.focused == index;
                                    bool afterIsFocused =
                                        widget.focused == index + 1;
                                    if (!beforeIsFocused && !afterIsFocused) {
                                      return VerticalDivider(
                                        indent: 8 * theme.scaling,
                                        endIndent: 8 * theme.scaling,
                                        width: 8 * theme.scaling,
                                      );
                                    }
                                    return SizedBox(width: 8 * theme.scaling);
                                  },
                                  itemCount: children.length,
                                );
                              },
                              childBuilder: _childBuilder,
                              children: _buildTabItems(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2) * theme.scaling,
                  child: Row(
                    spacing: 2 * theme.scaling,
                    children: widget.trailing,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItemPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final bool isFocused;
  final double borderWidth;

  _TabItemPainter({
    required this.borderRadius,
    required this.backgroundColor,
    required this.isFocused,
    required this.borderWidth,
    required this.borderColor,
  });

  @override
  bool shouldRepaint(covariant _TabItemPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.isFocused != isFocused ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderColor != borderColor;
  }

  Path createPath(Size size, [bool closed = false]) {
    Path path = Path();
    double adjustment = borderWidth;
    path.moveTo(-borderRadius.bottomLeft.x, size.height + adjustment);
    path.quadraticBezierTo(
        0, size.height, 0, size.height - borderRadius.bottomLeft.y);
    path.lineTo(0, borderRadius.topLeft.y);
    path.quadraticBezierTo(0, 0, borderRadius.topLeft.x, 0);
    path.lineTo(size.width - borderRadius.topRight.x, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius.topRight.y);
    path.lineTo(size.width, size.height - borderRadius.bottomRight.y);
    path.quadraticBezierTo(size.width, size.height,
        size.width + borderRadius.bottomRight.x, size.height + adjustment);
    if (closed) {
      path.close();
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!isFocused) {
      return;
    }
    Path path = createPath(size, true);
    canvas.drawPath(
      path,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    Path borderPath = createPath(size);

    canvas.drawPath(
      borderPath,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );
  }
}

class _ClipRectWithAdjustment extends CustomClipper<Rect> {
  final double borderWidth;

  _ClipRectWithAdjustment(this.borderWidth);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      -borderWidth,
      size.width,
      size.height + borderWidth * 2,
    );
  }

  @override
  bool shouldReclip(covariant _ClipRectWithAdjustment oldClipper) {
    return oldClipper.borderWidth != borderWidth;
  }
}
