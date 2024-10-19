import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class OverlayCompleter<T> {
  void remove();
  void dispose();
  bool get isCompleted;
  bool get isAnimationCompleted;
  Future<T> get future;
  Future<void> get animationFuture;
}

abstract class OverlayHandler {
  const OverlayHandler();
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });
}

class OverlayBarrier {
  final bool modal;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Color? barrierColor;

  const OverlayBarrier({
    this.modal = true,
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.barrierColor,
  });
}

abstract class OverlayManager implements OverlayHandler {
  static OverlayManager of(BuildContext context) {
    var manager = Data.maybeOf<OverlayManager>(context);
    assert(manager != null, 'No OverlayManager found in context');
    return manager!;
  }

  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });

  OverlayCompleter<T> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });
}

class OverlayManagerLayer extends StatefulWidget {
  final OverlayHandler popoverHandler;
  final OverlayHandler tooltipHandler;
  final Widget child;

  const OverlayManagerLayer({
    super.key,
    required this.popoverHandler,
    required this.tooltipHandler,
    required this.child,
  });

  @override
  State<OverlayManagerLayer> createState() => _OverlayManagerLayerState();
}

class _OverlayManagerLayerState extends State<OverlayManagerLayer>
    implements OverlayManager {
  @override
  Widget build(BuildContext context) {
    return Data<OverlayManager>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    return widget.popoverHandler.show(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
    );
  }

  @override
  OverlayCompleter<T> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    return widget.tooltipHandler.show(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
    );
  }
}
