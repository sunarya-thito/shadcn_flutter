import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/display/fade_scroll.dart';

class TabItem extends StatelessWidget implements SortableData<TabItem> {
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final BoxConstraints? constraints;

  @override
  TabItem get data => this;

  TabItem({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.of<TabPaneData>(context);
    final isFocused = data.focusedIndex == data.currentIndex;
    final borderRadius = data.borderRadius?.optionallyResolve(context) ??
        Theme.of(context).borderRadiusLg;
    final backgroundColor =
        data.backgroundColor ?? Theme.of(context).colorScheme.card;
    final border = data.border ??
        BorderSide(
          color: Theme.of(context).colorScheme.border,
          width: 1,
        );
    final borderWidth = border.width;
    final theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      child: CustomPaint(
          painter: _TabItemPainter(
              borderRadius: borderRadius,
              backgroundColor: backgroundColor,
              isFocused: isFocused,
              borderColor: border.color,
              borderWidth: borderWidth),
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8) * theme.scaling,
              constraints: constraints,
              child: IntrinsicWidth(
                child: Row(
                  spacing: 8 * theme.scaling,
                  children: [
                    if (leading != null) leading!,
                    Expanded(child: title),
                    if (trailing != null) trailing!,
                  ],
                ),
              ))),
    );
  }
}

class TabPaneData {
  final int currentIndex;
  final int focusedIndex;
  final TabPaneState state;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? border;

  const TabPaneData({
    this.currentIndex = 0,
    this.focusedIndex = 0,
    required this.state,
    this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabPaneData &&
        other.currentIndex == currentIndex &&
        other.focusedIndex == focusedIndex &&
        other.state == state &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.border == border;
  }

  @override
  int get hashCode => Object.hash(
      currentIndex, focusedIndex, state, backgroundColor, borderRadius, border);
}

class TabPane extends StatefulWidget {
  final List<TabItem> tabs;
  final ValueChanged<List<TabItem>>? onSort;
  final int focused;
  final ValueChanged<int> onFocused;
  final List<Widget> leading;
  final List<Widget> trailing;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final BorderSide? border;
  final Widget child;
  final double? barHeight;
  const TabPane({
    required this.tabs,
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
  State<TabPane> createState() => TabPaneState();
}

class TabPaneState extends State<TabPane> {
  final ScrollController _scrollController = ScrollController();

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
                        child: SortableDropFallback<TabItem>(
                          onAccept: (value) {
                            List<TabItem> tabs = List.of(widget.tabs);
                            tabs.swapItem(value.data, tabs.length);
                            widget.onSort?.call(tabs);
                          },
                          child: ScrollableSortableLayer(
                            controller: _scrollController,
                            child: ListView.separated(
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
                                  child: Sortable<TabItem>(
                                    data: widget.tabs[index],
                                    enabled: widget.onSort != null,
                                    onDragStart: () {
                                      widget.onFocused(index);
                                    },
                                    onAcceptLeft: (value) {
                                      List<TabItem> tabs = List.of(widget.tabs);
                                      tabs.swapItem(value.data, index);
                                      widget.onSort?.call(tabs);
                                    },
                                    onAcceptRight: (value) {
                                      List<TabItem> tabs = List.of(widget.tabs);
                                      tabs.swapItem(value.data, index + 1);
                                      widget.onSort?.call(tabs);
                                    },
                                    ghost: Data.inherit(
                                      data: TabPaneData(
                                        currentIndex: index,
                                        focusedIndex: index,
                                        borderRadius: borderRadius,
                                        backgroundColor: widget.backgroundColor,
                                        border: widget.border,
                                        state: this,
                                      ),
                                      child: widget.tabs[index],
                                    ),
                                    child: Data.inherit(
                                      data: TabPaneData(
                                        currentIndex: index,
                                        focusedIndex: widget.focused,
                                        borderRadius: borderRadius,
                                        backgroundColor: widget.backgroundColor,
                                        border: widget.border,
                                        state: this,
                                      ),
                                      child: widget.tabs[index],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                bool beforeIsFocused = widget.focused == index;
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
                              itemCount: widget.tabs.length,
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
