import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class SwiperHandler {
  static const SwiperHandler drawer = DrawerSwiperHandler();
  static const SwiperHandler sheet = SheetSwiperHandler();
  const SwiperHandler();
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required OverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  });
}

class DrawerSwiperHandler extends SwiperHandler {
  const DrawerSwiperHandler();

  @override
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required OverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  }) {
    return openDrawerOverlay(
      context: context,
      builder: builder,
      position: position,
      expands: expands ?? true,
      draggable: draggable ?? true,
      barrierDismissible: barrierDismissible ?? true,
      backdropBuilder: backdropBuilder,
      useSafeArea: useSafeArea ?? true,
      showDragHandle: showDragHandle ?? true,
      borderRadius: borderRadius,
      dragHandleSize: dragHandleSize,
      transformBackdrop: transformBackdrop ?? true,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      barrierColor: barrierColor,
      autoOpen: false,
    );
  }
}

class SheetSwiperHandler extends SwiperHandler {
  const SheetSwiperHandler();

  @override
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required OverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  }) {
    return openSheetOverlay(
      context: context,
      builder: builder,
      position: position,
      barrierDismissible: barrierDismissible ?? true,
      backdropBuilder: backdropBuilder,
      transformBackdrop: transformBackdrop ?? false,
      barrierColor: barrierColor,
      draggable: draggable ?? false,
      autoOpen: false,
    );
  }
}

class Swiper extends StatefulWidget {
  final bool enabled;
  final OverlayPosition position;
  final WidgetBuilder builder;
  final SwiperHandler handler;
  final bool? expands;
  final bool? draggable;
  final bool? barrierDismissible;
  final WidgetBuilder? backdropBuilder;
  final bool? useSafeArea;
  final bool? showDragHandle;
  final BorderRadiusGeometry? borderRadius;
  final Size? dragHandleSize;
  final bool? transformBackdrop;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Color? barrierColor;
  final Widget child;
  final HitTestBehavior? behavior;

  const Swiper({
    super.key,
    this.enabled = true,
    required this.position,
    required this.builder,
    required this.handler,
    this.expands,
    this.draggable,
    this.barrierDismissible,
    this.backdropBuilder,
    this.useSafeArea,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior,
    required this.child,
  });

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  DrawerOverlayCompleter? _activeOverlay;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  OverlayPosition get resolvedPosition {
    if (widget.position == OverlayPosition.start) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    }
    if (widget.position == OverlayPosition.end) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    return widget.position;
  }

  void _onDrag(DragUpdateDetails details) {
    if (_activeOverlay != null) {
      var resolvedPosition = this.resolvedPosition;
      var controller = _activeOverlay!.animationController;
      double delta;
      switch (resolvedPosition) {
        case OverlayPosition.top:
        case OverlayPosition.left:
          delta = details.primaryDelta!;
          break;
        case OverlayPosition.bottom:
        case OverlayPosition.right:
          delta = -details.primaryDelta!;
          break;
        default:
          throw UnimplementedError('Unresolved position');
      }
      // normalize delta
      var size = _key.currentContext?.size;
      if (size == null) {
        return;
      }
      double axisSize;
      if (resolvedPosition == OverlayPosition.top ||
          resolvedPosition == OverlayPosition.bottom) {
        axisSize = size.height;
      } else {
        axisSize = size.width;
      }
      delta = delta / axisSize;
      controller?.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      var controller = activeOverlay.animationController;
      if (controller != null) {
        if (controller.value < 0.5) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        } else {
          controller.forward();
        }
      }
      _activeOverlay = null;
    }
  }

  void _onDragCancel() {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var controller = activeOverlay.animationController;
        if (controller != null) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        }
      });
      _activeOverlay = null;
    }
  }

  void _onDragStart(DragStartDetails details) {
    _onDragCancel();
    _activeOverlay = widget.handler.openSwiper(
      context: context,
      builder: (context) {
        return KeyedSubtree(
          key: _key,
          child: widget.builder(context),
        );
      },
      position: widget.position,
      expands: widget.expands,
      draggable: widget.draggable,
      barrierDismissible: widget.barrierDismissible,
      backdropBuilder: widget.backdropBuilder,
      useSafeArea: widget.useSafeArea,
      showDragHandle: widget.showDragHandle,
      borderRadius: widget.borderRadius,
      dragHandleSize: widget.dragHandleSize,
      transformBackdrop: widget.transformBackdrop,
      surfaceOpacity: widget.surfaceOpacity,
      surfaceBlur: widget.surfaceBlur,
      barrierColor: widget.barrierColor,
    );
  }

  Widget _buildGesture({
    required Widget child,
    required bool draggable,
  }) {
    if (widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom) {
      return GestureDetector(
        behavior: widget.behavior ?? HitTestBehavior.translucent,
        onVerticalDragUpdate: draggable ? _onDrag : null,
        onVerticalDragEnd: draggable ? _onDragEnd : null,
        onVerticalDragStart: draggable ? _onDragStart : null,
        onVerticalDragCancel: _onDragCancel,
        child: child,
      );
    }
    return GestureDetector(
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      onHorizontalDragUpdate: draggable ? _onDrag : null,
      onHorizontalDragEnd: draggable ? _onDragEnd : null,
      onHorizontalDragStart: draggable ? _onDragStart : null,
      onHorizontalDragCancel: _onDragCancel,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGesture(
      child: widget.child,
      draggable: widget.enabled,
    );
  }
}
