import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

const kLoadingProgressIndeterminate = double.infinity;

class SideBar {
  final Key? key;
  final Widget child;
  final double initialSize;
  final double? collapsedSize;
  final double? maxSize;
  final double? minSize;
  final bool resizable;
  final bool initialCollapsed;

  const SideBar({
    this.key,
    required this.child,
    required this.initialSize,
    this.collapsedSize,
    this.maxSize,
    this.minSize,
    this.resizable = false,
    this.initialCollapsed = false,
  });
}

class Scaffold extends StatefulWidget {
  final List<Widget> headers;
  final List<Widget> footers;
  final Widget child;
  final SideBar? leftSideBar;
  final SideBar? rightSideBar;
  final double? loadingProgress;
  final VoidCallback? onRefresh;
  final bool
      floatingHeader; // when header floats, it takes no space in the layout, and positioned on top of the content
  final bool floatingFooter;
  final Color? headerBackgroundColor;
  final Color? footerBackgroundColor;

  const Scaffold({
    super.key,
    required this.child,
    this.headers = const [],
    this.footers = const [],
    this.leftSideBar,
    this.rightSideBar,
    this.loadingProgress,
    this.onRefresh,
    this.floatingHeader = false,
    this.floatingFooter = false,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
  });

  @override
  State<Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<Scaffold> {
  late List<BarHolder> _headerHolders;
  late List<BarHolder> _footerHolders;

  @override
  void initState() {
    super.initState();
    _headerHolders =
        List.generate(widget.headers.length, (index) => BarHolder());
    _footerHolders = List.generate(
        widget.footers.length,
        (index) => BarHolder(
              isHeader: false,
            ));
  }

  @override
  void didUpdateWidget(covariant Scaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.headers, widget.headers)) {
      _headerHolders =
          List.generate(widget.headers.length, (index) => BarHolder());
    }
    if (!listEquals(oldWidget.footers, widget.footers)) {
      _footerHolders = List.generate(
          widget.footers.length,
          (index) => BarHolder(
                isHeader: false,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DrawerOverlay(
      child: AnimatedContainer(
        duration: kDefaultDuration,
        color: theme.colorScheme.background,
        child: _ScaffoldFlex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: widget.headerBackgroundColor,
              child: Column(
                children: [
                  for (int i = 0; i < widget.headers.length; i++)
                    Data(
                      data: _headerHolders[i],
                      child: widget.headers[i],
                    ),
                ],
              ),
            ),
            Expanded(
              child: ResizablePanel(
                direction: Axis.horizontal,
                children: [
                  if (widget.leftSideBar != null)
                    ResizablePane(
                      key: widget.leftSideBar!.key,
                      initialSize: widget.leftSideBar!.initialSize,
                      initialCollapsed: widget.leftSideBar!.initialCollapsed,
                      collapsedSize: widget.leftSideBar!.collapsedSize,
                      maxSize: widget.leftSideBar!.maxSize,
                      minSize: widget.leftSideBar!.minSize,
                      resizable: widget.leftSideBar!.resizable,
                      child: widget.leftSideBar!.child,
                    ),
                  ResizablePane.flex(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          double? currentScrollDelta = notification.scrollDelta;
                          if (currentScrollDelta != null) {
                            double topScrollDelta = currentScrollDelta;
                            double bottomScrollDelta = currentScrollDelta;
                            // start from most top header
                            for (int i = 0; i < _headerHolders.length; i++) {
                              if (topScrollDelta != 0) {
                                var attachedBar =
                                    _headerHolders[i]._attachedBar;
                                if (attachedBar != null) {
                                  var consumedScrollDelta = attachedBar
                                      .consumeScrollDelta(topScrollDelta);
                                  topScrollDelta -= consumedScrollDelta;
                                  _headerHolders[i]._consumedDelta +=
                                      consumedScrollDelta;
                                }
                              } else {
                                break;
                              }
                            }
                            // start from most bottom footer
                            for (int i = _footerHolders.length - 1;
                                i >= 0;
                                i--) {
                              if (bottomScrollDelta < 0) {
                                var attachedBar =
                                    _footerHolders[i]._attachedBar;
                                if (attachedBar != null) {
                                  var consumedScrollDelta = attachedBar
                                      .consumeScrollDelta(bottomScrollDelta);
                                  bottomScrollDelta -= consumedScrollDelta;
                                  _footerHolders[i]._consumedDelta +=
                                      consumedScrollDelta;
                                }
                              } else {
                                break;
                              }
                            }
                          }
                        }
                        return true;
                      },
                      child: widget.child,
                    ),
                  ),
                  if (widget.rightSideBar != null)
                    ResizablePane(
                      key: widget.rightSideBar!.key,
                      initialSize: widget.rightSideBar!.initialSize,
                      initialCollapsed: widget.rightSideBar!.initialCollapsed,
                      collapsedSize: widget.rightSideBar!.collapsedSize,
                      maxSize: widget.rightSideBar!.maxSize,
                      minSize: widget.rightSideBar!.minSize,
                      resizable: widget.rightSideBar!.resizable,
                      child: widget.rightSideBar!.child,
                    ),
                ],
              ),
            ),
            Container(
              color: widget.footerBackgroundColor,
              child: Column(
                children: [
                  for (int i = 0; i < widget.footers.length; i++)
                    Data(
                      data: _footerHolders[i],
                      child: widget.footers[i],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarHolder {
  final bool isHeader;
  BarInstance? _attachedBar;
  double _consumedDelta = 0;

  BarHolder({this.isHeader = true});
}

abstract class BarInstance {
  double consumeScrollDelta(double delta);
}

class AppBar extends StatefulWidget {
  final List<Widget> trailing;
  final List<Widget> leading;
  final Widget? title;
  final Widget? header; // small widget placed on top of title
  final Widget? subtitle; // small widget placed below title
  final bool
      trailingExpanded; // expand the trailing instead of the main content
  final Alignment alignment;
  final Color? backgroundColor;

  const AppBar({
    super.key,
    this.trailing = const [],
    this.leading = const [],
    this.title,
    this.header,
    this.subtitle,
    this.trailingExpanded = false,
    this.alignment = Alignment.bottomCenter,
    this.backgroundColor,
  });

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class ExpandableAppBar extends StatefulWidget {
  final Widget child;
  final Widget? collapsedChild;
  final bool pinned;

  const ExpandableAppBar({
    super.key,
    required this.child,
    this.collapsedChild,
    this.pinned = false,
  });

  @override
  State<ExpandableAppBar> createState() => _ExpandableAppBarState();
}

class _ExpandableAppBarState extends State<ExpandableAppBar>
    implements BarInstance {
  BarHolder? _barHolder;
  final GlobalKey _key = GlobalKey(); // help to keep child state persistent
  double _expandValue = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newBarHolder = Data.maybeOf<BarHolder>(context);
    if (newBarHolder != _barHolder) {
      _barHolder?._attachedBar = null;
      _barHolder = newBarHolder;
      _barHolder?._attachedBar = this;
    }
  }

  @override
  double consumeScrollDelta(double delta) {
    if (widget.pinned) {
      return 0;
    }
    print('consumeScrollDelta: $delta');
    RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
    double minIntrinsicHeight = box.getMinIntrinsicHeight(double.infinity);
    double maxIntrinsicHeight = box.getMaxIntrinsicHeight(double.infinity);
    Size size = box.size;
    double consumedDelta = delta;
    setState(() {
      _expandValue += consumedDelta;
      print('expandValue: $_expandValue');
    });
    return consumedDelta;
  }

  @override
  Widget build(BuildContext context) {
    return _ExpandableAppBar(
      key: _key,
      extraSize: _expandValue,
      child: widget.child,
      reverseDirection: !(_barHolder?.isHeader ?? true),
    );
  }
}

class _ScaffoldFlex extends Flex {
  _ScaffoldFlex({
    super.direction = Axis.vertical,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.children = const <Widget>[],
  });

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _ScaffoldRenderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.of(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }
}

class _ScaffoldRenderFlex extends RenderFlex {
  _ScaffoldRenderFlex({
    super.direction = Axis.vertical,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisSize = MainAxisSize.max,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.textDirection,
    super.verticalDirection = VerticalDirection.down,
    super.textBaseline,
    super.clipBehavior = Clip.none,
  });

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    // There is gonna be only 3 children
    // 1. header
    // 2. content
    // 3. footer
    // By default, the paint order is 1, 2, 3
    // but with this custom implementation, we can change the order to 2, 1, 3
    // which means the header will be painted after the content
    // and the footer will be painted after the header
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as FlexParentData).nextSibling!;
    RenderBox footer = (content.parentData as FlexParentData).nextSibling!;
    context.paintChild(content, (content.parentData as BoxParentData).offset);
    context.paintChild(header, (header.parentData as BoxParentData).offset);
    context.paintChild(footer, (footer.parentData as BoxParentData).offset);
  }
}

class _ExpandableAppBar extends SingleChildRenderObjectWidget {
  final double extraSize;
  final bool reverseDirection;

  const _ExpandableAppBar({
    super.key,
    this.reverseDirection = false,
    required this.extraSize,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ExpandableAppBarRenderBox(
      extraSize: extraSize,
      reverseDirection: reverseDirection,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _ExpandableAppBarRenderBox renderObject) {
    bool needsRelayout = false;
    if (renderObject.extraSize != extraSize) {
      renderObject.extraSize = extraSize;
      needsRelayout = true;
    }
    if (renderObject.reverseDirection != reverseDirection) {
      renderObject.reverseDirection = reverseDirection;
      needsRelayout = true;
    }
    if (needsRelayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _ExpandableAppBarRenderBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  double extraSize;
  bool reverseDirection;
  _ExpandableAppBarRenderBox({
    required this.extraSize,
    this.reverseDirection = false,
  });

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(
          child!, offset + (child!.parentData as BoxParentData).offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child != null) {
      return child!.hitTest(result, position: position);
    }
    return false;
  }

  @override
  void performLayout() {
    if (child != null) {
      // minSize, if null, use intrinsic size
      Size dryLayoutSize = child!.computeDryLayout(this.constraints);
      double minSize = child!.getMinIntrinsicHeight(double.infinity);
      double maxSize = dryLayoutSize.height - extraSize;
      if (maxSize < minSize) {
        maxSize = minSize;
      }
      BoxConstraints constraints = BoxConstraints(
        minWidth: this.constraints.minWidth,
        maxWidth: this.constraints.maxWidth,
        minHeight: minSize,
        maxHeight: maxSize,
      );
      child!.layout(constraints, parentUsesSize: true);
      var childSize = child!.size;
      final BoxParentData childParentData = child!.parentData as BoxParentData;
      double shiftSize = minSize + extraSize.min(0);
      print(
          'minSize: $minSize, maxSize: $maxSize, childSize: $childSize, extraSize: $extraSize, shiftSize: $shiftSize, dryLayoutSize: $dryLayoutSize');
      if (reverseDirection) {
      } else {
        // childParentData.offset = Offset(0, -shiftSize);
      }
      size = constraints.constrain(childSize);
    } else {
      size = constraints.smallest;
    }
  }
}
