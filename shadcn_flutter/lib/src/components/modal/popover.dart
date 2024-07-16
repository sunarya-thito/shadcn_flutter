import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PopoverRoute<T> extends PopupRoute<T> {
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

  PopoverRoute({
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
  }) : super(traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop);

  @override
  Widget buildModalBarrier() {
    if (modal) return super.buildModalBarrier();
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
      position: position,
      alignment: alignment,
      themes: themes,
      builder: builder,
      animation: animation,
      anchorSize: anchorSize,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      route: this,
      onTapOutside: () {
        if (!modal) Navigator.of(context).pop();
      },
      regionGroupId: regionGroupId,
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
    required this.position,
    required this.alignment,
    required this.themes,
    required this.builder,
    required this.animation,
    required this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.anchorSize,
    required this.route,
    this.onTapOutside,
    this.regionGroupId,
  });

  final Offset position;
  final Alignment alignment;
  final Alignment anchorAlignment;
  final CapturedThemes themes;
  final WidgetBuilder builder;
  final Size? anchorSize;
  final Animation<double> animation;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final PopoverRoute route;
  final VoidCallback? onTapOutside;
  final Object? regionGroupId;

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
  static const double _margin = 8;
  final Alignment alignment;
  final Alignment anchorAlignment;
  final Offset position;
  final Size? anchorSize;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final Object? regionGroupId;

  PopoverLayoutDelegate({
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.regionGroupId,
    this.anchorSize,
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
    double x =
        position.dx - childSize.width / 2 - (childSize.width / 2 * alignment.x);
    double y = position.dy -
        childSize.height / 2 -
        (childSize.height / 2 * alignment.y);
    double left = x - _margin;
    double top = y - _margin;
    double right = x + childSize.width + _margin;
    double bottom = y + childSize.height + _margin;
    if (left < 0 || right > size.width) {
      x = position.dx -
          childSize.width / 2 -
          (childSize.width / 2 * -alignment.x);
      if (anchorSize != null) {
        x -= anchorSize!.width * anchorAlignment.x;
      }
      left = x - _margin;
      right = x + childSize.width + _margin;
    }
    if (top < 0 || bottom > size.height) {
      y = position.dy -
          childSize.height / 2 -
          (childSize.height / 2 * -alignment.y);
      if (anchorSize != null) {
        y -= anchorSize!.height * anchorAlignment.y;
      }
      top = y - _margin;
      bottom = y + childSize.height + _margin;
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
    return Offset(x + dx, y + dy);
  }

  @override
  bool shouldRelayout(covariant PopoverLayoutDelegate oldDelegate) {
    return oldDelegate.alignment != alignment ||
        oldDelegate.position != position ||
        oldDelegate.anchorSize != anchorSize;
  }
}

class PopoverAnchorState extends State<PopoverAnchor> {
  // late ValueNotifier<Offset> _position;
  late Offset _position;
  late Alignment _alignment;
  late Alignment _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  Size? _anchorSize;

  @override
  void initState() {
    super.initState();
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
  }

  void close() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          Navigator.of(context).removeRoute(widget.route);
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
  }

  Size? get anchorSize => _anchorSize;
  Alignment get anchorAlignment => _anchorAlignment;
  Offset get position => _position;
  Alignment get alignment => _alignment;
  PopoverConstraint get widthConstraint => _widthConstraint;
  PopoverConstraint get heightConstraint => _heightConstraint;

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

  set anchorSize(Size? value) {
    if (_anchorSize != value) {
      setState(() {
        _anchorSize = value;
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

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      consumeOutsideTaps: true,
      onTapOutside: (event) {
        widget.onTapOutside?.call();
      },
      groupId: widget.regionGroupId,
      child: CustomSingleChildLayout(
        delegate: PopoverLayoutDelegate(
          alignment: _alignment,
          position: _position,
          anchorSize: _anchorSize,
          anchorAlignment: _anchorAlignment,
          widthConstraint: _widthConstraint,
          heightConstraint: _heightConstraint,
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
                alignment: _anchorAlignment,
                scale:
                    Tween<double>(begin: 0.9, end: 1).animate(widget.animation),
                child: widget.themes.wrap(widget.builder(context)),
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
  required Offset position,
  required Alignment alignment,
  required WidgetBuilder builder,
  Alignment? anchorAlignment,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  Size? anchorSize,
  Key? key,
  bool useRootNavigator = true,
  bool modal = true,
  Clip clipBehavior = Clip.none,
  RouteSettings? routeSettings,
  Object? regionGroupId,
}) {
  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigator.context);
  return navigator.push(PopoverRoute(
    key: key,
    builder: builder,
    position: position,
    alignment: alignment,
    themes: themes,
    modal: modal,
    settings: routeSettings,
    anchorSize: anchorSize,
    anchorAlignment: anchorAlignment ?? alignment * -1,
    widthConstraint: widthConstraint,
    heightConstraint: heightConstraint,
    regionGroupId: regionGroupId,
  ));
}

extension PopoverExtension on BuildContext {
  Future<T?> showPopover<T>() {
    PopoverState state = Data.of(this);
    return state.show();
  }

  void hidePopover() {
    PopoverState state = Data.of(this);
    state.close();
  }
}

class Popover extends StatefulWidget {
  final WidgetBuilder builder;
  final WidgetBuilder popoverBuilder;
  final Alignment alignment;
  final Alignment? anchorAlignment;
  final bool follow;
  final bool modal;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final Offset? popoverOffset;

  const Popover({
    Key? key,
    required this.builder,
    required this.popoverBuilder,
    required this.alignment,
    this.anchorAlignment,
    this.follow = true,
    this.modal = false,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.popoverOffset,
  }) : super(key: key);

  @override
  PopoverState createState() => PopoverState();
}

class PopoverState extends State<Popover>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late Ticker ticker;
  GlobalKey<PopoverAnchorState>? _key;

  @override
  bool get wantKeepAlive {
    // when follow is true, we want to keep the state alive
    // so that the popover can follow the widget
    // this is useful when the widget is in a list
    // list items are destroyed and recreated when scrolling
    return _key != null && widget.follow;
  }

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      if (_key != null && widget.follow) {
        PopoverAnchorState? state = _key!.currentState;
        if (state != null) {
          Alignment alignment = widget.anchorAlignment ?? widget.alignment * -1;
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset position = renderBox.localToGlobal(Offset.zero);
          final Size size = renderBox.size;
          // find offset based on alignment
          // alignment.x and alignment.y is -1, 0, 1 (where 0 is center)
          Offset result = Offset(
            position.dx + size.width / 2 + size.width / 2 * alignment.x,
            position.dy + size.height / 2 + size.height / 2 * alignment.y,
          );
          if (widget.popoverOffset != null) {
            result += widget.popoverOffset!;
          }
          state.position = result;
          state.alignment = widget.alignment;
          state.anchorSize = size;
          state.anchorAlignment =
              widget.anchorAlignment ?? widget.alignment * -1;
          state.widthConstraint = widget.widthConstraint;
          state.heightConstraint = widget.heightConstraint;
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant Popover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.follow != widget.follow) {
      if (widget.follow) {
        if (_key?.currentContext?.mounted ?? false) {
          _scheduleShow();
        }
      } else {
        _cancelShow();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DataBuilder(
      data: this,
      builder: widget.builder,
    );
  }

  void _scheduleShow() {
    if (!ticker.isActive && widget.follow) {
      ticker.start();
    }
  }

  void _cancelShow() {
    ticker.stop();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void close() {
    _key?.currentState?.close();
  }

  Future<T?> show<T>() async {
    Alignment alignment = widget.anchorAlignment ?? widget.alignment * -1;
    WidgetBuilder builder = widget.popoverBuilder;
    _key = GlobalKey<PopoverAnchorState>();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    // find offset based on alignment
    // alignment.x and alignment.y is -1, 0, 1 (where 0 is center)
    Offset result = Offset(
      position.dx + size.width / 2 + size.width / 2 * alignment.x,
      position.dy + size.height / 2 + size.height / 2 * alignment.y,
    );
    if (widget.popoverOffset != null) {
      result += widget.popoverOffset!;
    }
    _scheduleShow();
    T? res = await showPopover(
        context: context,
        position: result,
        alignment: widget.alignment,
        anchorAlignment: alignment,
        builder: builder,
        modal: widget.modal,
        anchorSize: size,
        widthConstraint: widget.widthConstraint,
        heightConstraint: widget.heightConstraint,
        key: _key);
    _cancelShow();
    _key = null;
    return res;
  }
}

class PopoverController extends ChangeNotifier {
  PopoverPortalState? _attached;
  final List<GlobalKey<PopoverAnchorState>> _openPopovers = [];

  void _attach(PopoverPortalState state) {
    assert(_attached == null,
        'PopoverController already attached to another PopoverPortal');
    _attached = state;
  }

  void _detach(PopoverPortalState state) {
    assert(_attached == state,
        'PopoverController not attached to this PopoverPortal');
    _attached = null;
  }

  bool get hasAttached => _attached != null;

  bool get hasOpenPopovers => _openPopovers.isNotEmpty;

  Future<T?> show<T>({
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
  }) async {
    assert(_attached != null,
        'PopoverController not attached to any PopoverPortal');
    if (closeOthers) {
      close();
    }
    key ??= GlobalKey<PopoverAnchorState>();
    _openPopovers.add(key);
    notifyListeners();
    RenderBox renderBox = _attached!.context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    Offset result = Offset(
      position.dx + size.width / 2 + size.width / 2 * anchorAlignment.x,
      position.dy + size.height / 2 + size.height / 2 * anchorAlignment.y,
    );
    T? res = await showPopover(
      context: _attached!.context,
      position: result + (offset ?? Offset.zero),
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      builder: builder,
      modal: modal,
      anchorSize: size,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      regionGroupId: regionGroupId,
    );
    _openPopovers.remove(key);
    notifyListeners();
    return res;
  }

  void close() {
    for (GlobalKey<PopoverAnchorState> key in _openPopovers) {
      key.currentState?.close();
    }
  }
}

class PopoverPortal extends StatefulWidget {
  final PopoverController controller;
  final Widget child;

  const PopoverPortal({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  PopoverPortalState createState() => PopoverPortalState();
}

class PopoverPortalState extends State<PopoverPortal> {
  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
  }

  @override
  void didUpdateWidget(covariant PopoverPortal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach(this);
      widget.controller._attach(this);
      // transfer open popovers
      for (GlobalKey<PopoverAnchorState> key
          in oldWidget.controller._openPopovers) {
        widget.controller._openPopovers.add(key);
      }
    }
  }

  @override
  void dispose() {
    widget.controller._attached = null;
    widget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
