import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PopoverRoute<T> extends PopupRoute<T> {
  final BuildContext anchorContext;
  final WidgetBuilder builder;
  final Offset position;
  final Alignment alignment;
  final CapturedThemes themes;
  final Key? key;
  final bool modal;
  final Size? anchorSize;
  final Alignment anchorAlignment;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final Object? regionGroupId;
  final Offset? offset;
  final Alignment? transitionAlignment;
  final EdgeInsets margin;
  final bool follow;
  final bool consumeOutsideTaps;

  PopoverRoute({
    required this.anchorContext,
    required this.builder,
    required this.position,
    required this.alignment,
    required this.themes,
    required this.anchorAlignment,
    this.modal = false,
    this.key,
    this.anchorSize,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    super.settings,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin = const EdgeInsets.all(8),
    this.follow = true,
    this.consumeOutsideTaps = true,
  }) : super(traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop);

  @override
  Widget buildModalBarrier() {
    if (modal) return super.buildModalBarrier();
    if (!consumeOutsideTaps) {
      return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          if (isCurrent) {
            Navigator.of(anchorContext).pop();
          } else {
            Navigator.of(anchorContext).removeRoute(this);
          }
        },
      );
    }
    return const SizedBox();
  }

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return PopoverAnchor(
      key: key,
      anchorContext: anchorContext,
      position: position,
      alignment: alignment,
      themes: themes,
      builder: builder,
      animation: animation,
      anchorSize: anchorSize,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      onTapOutside: () {
        if (!modal) {
          if (isCurrent) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).removeRoute(this);
          }
        }
      },
      route: this,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Duration get reverseTransitionDuration => kDefaultDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0, 2 / 3));
  }
}

class PopoverAnchor extends StatefulWidget {
  const PopoverAnchor({
    super.key,
    required this.anchorContext,
    required this.position,
    required this.alignment,
    this.themes,
    required this.builder,
    required this.animation,
    required this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.anchorSize,
    this.route,
    this.onTapOutside,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin = const EdgeInsets.all(8),
    this.follow = true,
    this.consumeOutsideTaps = true,
  });

  final Offset position;
  final Alignment alignment;
  final Alignment anchorAlignment;
  final CapturedThemes? themes;
  final WidgetBuilder builder;
  final Size? anchorSize;
  final Animation<double> animation;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final PopoverRoute? route;
  final VoidCallback? onTapOutside;
  final Object? regionGroupId;
  final Offset? offset;
  final Alignment? transitionAlignment;
  final EdgeInsets margin;
  final bool follow;
  final BuildContext anchorContext;
  final bool consumeOutsideTaps;

  @override
  State<PopoverAnchor> createState() => PopoverAnchorState();
}

enum PopoverConstraint {
  flexible,
  anchorFixedSize,
  anchorMinSize,
  anchorMaxSize,
}

class PopoverLayoutDelegate extends SingleChildLayoutDelegate {
  final Alignment alignment;
  final Alignment anchorAlignment;
  final Offset position;
  final Size? anchorSize;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final Offset? offset;
  final EdgeInsets margin;

  PopoverLayoutDelegate({
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.anchorSize,
    this.offset,
    this.margin = const EdgeInsets.all(8),
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double minWidth = 0;
    double maxWidth = constraints.maxWidth;
    double minHeight = 0;
    double maxHeight = constraints.maxHeight;
    if (widthConstraint == PopoverConstraint.anchorFixedSize) {
      minWidth = anchorSize!.width;
      maxWidth = anchorSize!.width;
    } else if (widthConstraint == PopoverConstraint.anchorMinSize) {
      minWidth = anchorSize!.width;
    } else if (widthConstraint == PopoverConstraint.anchorMaxSize) {
      maxWidth = anchorSize!.width;
    }
    if (heightConstraint == PopoverConstraint.anchorFixedSize) {
      minHeight = anchorSize!.height;
      maxHeight = anchorSize!.height;
    } else if (heightConstraint == PopoverConstraint.anchorMinSize) {
      minHeight = anchorSize!.height;
    } else if (heightConstraint == PopoverConstraint.anchorMaxSize) {
      maxHeight = anchorSize!.height;
    }
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // make sure the popup is within the size (with a margin of 8)
    double offsetX = offset?.dx ?? 0;
    double offsetY = offset?.dy ?? 0;
    double x =
        position.dx - childSize.width / 2 - (childSize.width / 2 * alignment.x);
    double y = position.dy -
        childSize.height / 2 -
        (childSize.height / 2 * alignment.y);
    double left = x - margin.left;
    double top = y - margin.top;
    double right = x + childSize.width + margin.right;
    double bottom = y + childSize.height + margin.bottom;
    if (left < 0 || right > size.width) {
      x = position.dx -
          childSize.width / 2 -
          (childSize.width / 2 * -anchorAlignment.x);
      if (anchorSize != null) {
        x -= anchorSize!.width * alignment.x;
      }
      left = x - margin.left;
      right = x + childSize.width + margin.right;
    }
    if (top < 0 || bottom > size.height) {
      y = position.dy -
          childSize.height / 2 -
          (childSize.height / 2 * -anchorAlignment.y);
      if (anchorSize != null) {
        y -= anchorSize!.height * alignment.y;
      }
      top = y - margin.top;
      bottom = y + childSize.height + margin.bottom;
    }
    final double dx = left < 0
        ? -left
        : right > size.width
            ? size.width - right
            : 0;
    final double dy = top < 0
        ? -top
        : bottom > size.height
            ? size.height - bottom
            : 0;
    return Offset(x + dx + offsetX, y + dy + offsetY);
  }

  @override
  bool shouldRelayout(covariant PopoverLayoutDelegate oldDelegate) {
    return oldDelegate.alignment != alignment ||
        oldDelegate.position != position ||
        oldDelegate.anchorSize != anchorSize ||
        oldDelegate.widthConstraint != widthConstraint ||
        oldDelegate.heightConstraint != heightConstraint ||
        oldDelegate.offset != offset ||
        oldDelegate.margin != margin;
  }
}

class PopoverAnchorState extends State<PopoverAnchor>
    with SingleTickerProviderStateMixin {
  late Offset _position;
  late Offset? _offset;
  late Alignment _alignment;
  late Alignment _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  late EdgeInsets _margin;
  Size? _anchorSize;
  late bool _follow;
  late Ticker _ticker;

  set offset(Offset? offset) {
    if (offset != null) {
      setState(() {
        _offset = offset;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _margin = widget.margin;
    _follow = widget.follow;
    _ticker = createTicker(_tick);
    if (_follow) {
      _ticker.start();
    }
  }

  void close([bool immediate = false]) {
    var route = widget.route;
    if (route != null) {
      if (route.isCurrent && !immediate) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).removeRoute(route);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  void closeLater() {
    if (mounted && widget.route != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).removeRoute(widget.route!);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant PopoverAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.position != widget.position) {
      _position = widget.position;
    }
    if (oldWidget.alignment != widget.alignment) {
      _alignment = widget.alignment;
    }
    if (oldWidget.anchorSize != widget.anchorSize) {
      _anchorSize = widget.anchorSize;
    }
    if (oldWidget.anchorAlignment != widget.anchorAlignment) {
      _anchorAlignment = widget.anchorAlignment;
    }
    if (oldWidget.widthConstraint != widget.widthConstraint) {
      _widthConstraint = widget.widthConstraint;
    }
    if (oldWidget.heightConstraint != widget.heightConstraint) {
      _heightConstraint = widget.heightConstraint;
    }
    if (oldWidget.offset != widget.offset) {
      _offset = widget.offset;
    }
    if (oldWidget.margin != widget.margin) {
      _margin = widget.margin;
    }
    if (oldWidget.follow != widget.follow) {
      _follow = widget.follow;
      if (_follow) {
        _ticker.start();
      } else {
        _ticker.stop();
      }
    }
  }

  Size? get anchorSize => _anchorSize;
  Alignment get anchorAlignment => _anchorAlignment;
  Offset get position => _position;
  Alignment get alignment => _alignment;
  PopoverConstraint get widthConstraint => _widthConstraint;
  PopoverConstraint get heightConstraint => _heightConstraint;
  Offset? get offset => _offset;
  EdgeInsets get margin => _margin;
  bool get follow => _follow;

  set position(Offset value) {
    if (_position != value) {
      setState(() {
        _position = value;
      });
    }
  }

  set alignment(Alignment value) {
    if (_alignment != value) {
      setState(() {
        _alignment = value;
      });
    }
  }

  set anchorAlignment(Alignment value) {
    if (_anchorAlignment != value) {
      setState(() {
        _anchorAlignment = value;
      });
    }
  }

  set widthConstraint(PopoverConstraint value) {
    if (_widthConstraint != value) {
      setState(() {
        _widthConstraint = value;
      });
    }
  }

  set heightConstraint(PopoverConstraint value) {
    if (_heightConstraint != value) {
      setState(() {
        _heightConstraint = value;
      });
    }
  }

  set margin(EdgeInsets value) {
    if (_margin != value) {
      setState(() {
        _margin = value;
      });
    }
  }

  set follow(bool value) {
    if (_follow != value) {
      setState(() {
        _follow = value;
        if (_follow) {
          _ticker.start();
        } else {
          _ticker.stop();
        }
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    if (!mounted || !widget.anchorContext.mounted) return;
    // update position based on anchorContext
    RenderBox? renderBox =
        widget.anchorContext.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset pos = renderBox.localToGlobal(Offset.zero);
      Size size = renderBox.size;
      Offset newPos = Offset(
        pos.dx + size.width / 2 + size.width / 2 * _anchorAlignment.x,
        pos.dy + size.height / 2 + size.height / 2 * _anchorAlignment.y,
      );
      if (_position != newPos) {
        setState(() {
          _anchorSize = size;
          _position = newPos;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      enabled: widget.consumeOutsideTaps,
      onTapOutside: widget.onTapOutside != null
          ? (event) {
              widget.onTapOutside?.call();
            }
          : null,
      groupId: widget.regionGroupId,
      child: CustomSingleChildLayout(
        delegate: PopoverLayoutDelegate(
          alignment: _alignment,
          position: _position,
          anchorSize: _anchorSize,
          anchorAlignment: _anchorAlignment,
          widthConstraint: _widthConstraint,
          heightConstraint: _heightConstraint,
          offset: _offset,
          margin: _margin,
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeLeft: true,
          removeRight: true,
          removeTop: true,
          child: Builder(builder: (context) {
            return FadeTransition(
              opacity: widget.animation,
              child: ScaleTransition(
                alignment: widget.transitionAlignment ?? _alignment,
                scale:
                    Tween<double>(begin: 0.9, end: 1).animate(widget.animation),
                child: widget.themes == null
                    ? widget.builder(context)
                    : widget.themes!.wrap(widget.builder(context)),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Future<T?> showPopover<T>({
  required BuildContext context,
  required Alignment alignment,
  required WidgetBuilder builder,
  Offset? position,
  Alignment? anchorAlignment,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  Key? key,
  bool useRootNavigator = true,
  bool modal = true,
  Clip clipBehavior = Clip.none,
  RouteSettings? routeSettings,
  Object? regionGroupId,
  Offset? offset,
  Alignment? transitionAlignment,
  EdgeInsets margin = const EdgeInsets.all(8),
  bool follow = true,
  bool consumeOutsideTaps = true,
}) {
  anchorAlignment ??= alignment * -1;
  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigator.context);
  Size? anchorSize;
  if (position == null) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset pos = renderBox.localToGlobal(Offset.zero);
    anchorSize ??= renderBox.size;
    position = Offset(
      pos.dx + anchorSize.width / 2 + anchorSize.width / 2 * anchorAlignment.x,
      pos.dy +
          anchorSize.height / 2 +
          anchorSize.height / 2 * anchorAlignment.y,
    );
  }
  return navigator.push(PopoverRoute(
    anchorContext: context,
    key: key,
    builder: builder,
    position: position,
    alignment: alignment,
    themes: themes,
    modal: modal,
    settings: routeSettings,
    anchorSize: anchorSize,
    anchorAlignment: anchorAlignment,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    regionGroupId: regionGroupId,
    offset: offset,
    transitionAlignment: transitionAlignment,
    margin: margin,
    follow: follow,
    consumeOutsideTaps: consumeOutsideTaps,
  ));
}

class PopoverController extends ChangeNotifier {
  final List<GlobalKey<PopoverAnchorState>> _openPopovers = [];

  bool get hasOpenPopovers => _openPopovers.isNotEmpty;

  Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required Alignment alignment,
    required Alignment anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    bool modal = false,
    bool closeOthers = true,
    Offset? offset,
    GlobalKey<PopoverAnchorState>? key,
    Object? regionGroupId,
    Alignment? transitionAlignment,
    bool consumeOutsideTaps = true,
  }) async {
    if (closeOthers) {
      close();
    }
    key ??= GlobalKey<PopoverAnchorState>();
    _openPopovers.add(key);
    notifyListeners();
    T? res = await showPopover(
      context: context,
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      builder: builder,
      modal: modal,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      consumeOutsideTaps: consumeOutsideTaps,
    );
    _openPopovers.remove(key);
    notifyListeners();
    return res;
  }

  void close([bool immediate = false]) {
    for (GlobalKey<PopoverAnchorState> key in _openPopovers) {
      key.currentState?.close(immediate);
    }
    _openPopovers.clear();
    notifyListeners();
  }

  void closeLater() {
    for (GlobalKey<PopoverAnchorState> key in _openPopovers) {
      key.currentState?.closeLater();
    }
    _openPopovers.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    for (GlobalKey<PopoverAnchorState> key in _openPopovers) {
      key.currentState?.closeLater();
    }
    super.dispose();
  }
}
