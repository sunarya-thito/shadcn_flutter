import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/display/fade_scroll.dart';

class TabPaneData<T> extends SortableData<T> {
  const TabPaneData(super.data);
}

typedef TabPaneItemBuilder<T> = TabChild Function(
    BuildContext context, TabPaneData<T> item, int index);

class TabPane<T> extends StatefulWidget {
  final List<TabPaneData<T>> items;
  final TabPaneItemBuilder<T> itemBuilder;
  final ValueChanged<List<TabPaneData<T>>>? onSort;
  final int focused;
  final ValueChanged<int> onFocused;
  final List<Widget> leading;
  final List<Widget> trailing;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final BorderSide? border;
  final Widget child;
  final double? barHeight;
  const TabPane({super.key, 
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

class TabPaneState<T> extends State<TabPane<T>> {
  final ScrollController _scrollController = ScrollController();
  static const kTabDrag = #tabDrag;

  Widget _childBuilder(
      BuildContext context, TabContainerData data, Widget child) {
    final theme = Theme.of(context);
    final isFocused = data.index == data.selected;
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.card;
    final borderColor = widget.border?.color ?? theme.colorScheme.border;
    final borderWidth = widget.border?.width ?? 1;
    final borderRadius = (widget.borderRadius ?? theme.borderRadiusLg)
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
    final BorderRadiusGeometry borderRadius =
        widget.borderRadius ?? theme.borderRadiusLg;
    final BorderRadius resolvedBorderRadius =
        borderRadius.optionallyResolve(context);
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
              backgroundColor: widget.backgroundColor ?? theme.colorScheme.card,
              child: widget.child,
            ),
          ),
          Container(
            height: widget.barHeight ?? (32 * theme.scaling),
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
                    endCrossOffset: widget.border?.width ?? 1,
                    controller: _scrollController,
                    child: ClipRect(
                      clipper:
                          _ClipRectWithAdjustment(widget.border?.width ?? 1),
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
