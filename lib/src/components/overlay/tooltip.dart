import 'package:shadcn_flutter/src/components/control/hover.dart';

import '../../../shadcn_flutter.dart';

class TooltipContainer extends StatelessWidget {
  final Widget child;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const TooltipContainer({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.child,
  });

  Widget call(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var backgroundColor = theme.colorScheme.primary;
    // var surfaceOpacity = this.surfaceOpacity ?? theme.surfaceOpacity;
    // var surfaceBlur = this.surfaceBlur ?? theme.surfaceBlur;
    // Do not use the default value of theme.surfaceOpacity and theme.surfaceBlur
    // but still allow the user to set the value
    var surfaceOpacity = this.surfaceOpacity;
    var surfaceBlur = this.surfaceBlur;
    if (surfaceOpacity != null) {
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    Widget animatedContainer = Container(
      padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ) *
          scaling,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(theme.radiusSm),
      ),
      child: child.xSmall().primaryForeground(),
    );
    if (surfaceBlur != null && surfaceBlur > 0) {
      animatedContainer = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        child: animatedContainer,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(6) * scaling,
      child: animatedContainer,
    );
  }
}

class Tooltip extends StatefulWidget {
  final Widget child;
  final WidgetBuilder tooltip;
  final AlignmentGeometry alignment;
  final AlignmentGeometry anchorAlignment;
  final Duration waitDuration;
  final Duration showDuration;
  final Duration minDuration;

  const Tooltip({
    super.key,
    required this.child,
    required this.tooltip,
    this.alignment = Alignment.topCenter,
    this.anchorAlignment = Alignment.bottomCenter,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(milliseconds: 200),
    this.minDuration = const Duration(milliseconds: 0),
  });

  @override
  State<Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> {
  final PopoverController _controller = PopoverController();
  @override
  Widget build(BuildContext context) {
    return Hover(
      waitDuration: widget.waitDuration,
      minDuration: widget.minDuration,
      showDuration: widget.showDuration,
      onHover: (hovered) {
        if (hovered) {
          _controller.show(
            context: context,
            modal: false,
            builder: (context) {
              return widget.tooltip(context);
            },
            alignment: widget.alignment,
            anchorAlignment: widget.anchorAlignment,
            dismissBackdropFocus: false,
            overlayBarrier: const OverlayBarrier(
              barrierColor: Colors.transparent,
            ),
            handler: OverlayManagerAsTooltipOverlayHandler(
                overlayManager: OverlayManager.of(context)),
          );
        } else {
          _controller.close();
        }
      },
      child: widget.child,
    );
  }
}

class InstantTooltip extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;
  final WidgetBuilder tooltipBuilder;
  final AlignmentGeometry tooltipAlignment;
  final AlignmentGeometry? tooltipAnchorAlignment;

  const InstantTooltip({
    super.key,
    required this.child,
    required this.tooltipBuilder,
    this.behavior = HitTestBehavior.translucent,
    this.tooltipAlignment = Alignment.bottomCenter,
    this.tooltipAnchorAlignment,
  });

  @override
  State<InstantTooltip> createState() => _InstantTooltipState();
}

class _InstantTooltipState extends State<InstantTooltip> {
  final PopoverController _controller = PopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayManager = OverlayManager.of(context);
    return MouseRegion(
      onEnter: (event) {
        _controller.close(true);
        _controller.show(
          context: context,
          modal: false,
          builder: widget.tooltipBuilder,
          alignment: widget.tooltipAlignment,
          anchorAlignment: widget.tooltipAnchorAlignment,
          dismissBackdropFocus: false,
          showDuration: Duration.zero,
          hideDuration: Duration.zero,
          overlayBarrier: const OverlayBarrier(
            barrierColor: Colors.transparent,
          ),
          handler: OverlayManagerAsTooltipOverlayHandler(
              overlayManager: overlayManager),
        );
      },
      onExit: (event) {
        _controller.close();
      },
      hitTestBehavior: widget.behavior,
      child: widget.child,
    );
  }
}

class OverlayManagerAsTooltipOverlayHandler extends OverlayHandler {
  final OverlayManager overlayManager;

  const OverlayManagerAsTooltipOverlayHandler({
    required this.overlayManager,
  });

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool barrierDismissable = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return overlayManager.showTooltip(
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
      layerLink: layerLink,
    );
  }
}

class FixedTooltipOverlayHandler extends OverlayHandler {
  const FixedTooltipOverlayHandler();

  @override
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
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    TextDirection textDirection = Directionality.of(context);
    Alignment resolvedAlignment = alignment.resolve(textDirection);
    anchorAlignment ??= alignment * -1;
    Alignment resolvedAnchorAlignment = anchorAlignment.resolve(textDirection);
    final OverlayState overlay = Overlay.of(context, rootOverlay: rootOverlay);
    final themes = InheritedTheme.capture(from: context, to: overlay.context);
    final data = Data.capture(from: context, to: overlay.context);

    ValueNotifier<bool> isClosed = ValueNotifier(false);
    late OverlayEntry overlayEntry;
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry();
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: FocusScope(
            autofocus: dismissBackdropFocus,
            child: AnimatedBuilder(
                animation: isClosed,
                builder: (innerContext, child) {
                  return AnimatedValueBuilder.animation(
                      value: isClosed.value ? 0.0 : 1.0,
                      initialValue: 0.0,
                      curve: isClosed.value
                          ? const Interval(0, 2 / 3)
                          : Curves.linear,
                      duration: isClosed.value
                          ? (showDuration ?? kDefaultDuration)
                          : (dismissDuration ??
                              const Duration(milliseconds: 100)),
                      onEnd: (value) {
                        if (value == 0.0 && isClosed.value) {
                          popoverEntry.remove();
                          popoverEntry.dispose();
                          animationCompleter.complete();
                        }
                      },
                      builder: (innerContext, animation) {
                        final theme = Theme.of(innerContext);
                        var popoverAnchor = PopoverOverlayWidget(
                          animation: animation,
                          onTapOutside: () {
                            if (isClosed.value) return;
                            if (!modal) {
                              isClosed.value = true;
                              completer.complete();
                            }
                          },
                          key: key,
                          anchorContext: context,
                          position: position,
                          alignment: resolvedAlignment,
                          themes: themes,
                          builder: builder,
                          // anchorAlignment: anchorAlignment ?? alignment * -1,
                          anchorAlignment: resolvedAnchorAlignment,
                          widthConstraint: widthConstraint,
                          heightConstraint: heightConstraint,
                          regionGroupId: regionGroupId,
                          offset: offset,
                          transitionAlignment: Alignment.center,
                          margin: const EdgeInsets.all(48) * theme.scaling,
                          follow: false,
                          consumeOutsideTaps: consumeOutsideTaps,
                          allowInvertHorizontal: allowInvertHorizontal,
                          allowInvertVertical: allowInvertVertical,
                          data: data,
                          onClose: () {
                            if (isClosed.value) return Future.value();
                            isClosed.value = true;
                            completer.complete();
                            return animationCompleter.future;
                          },
                          onImmediateClose: () {
                            popoverEntry.remove();
                            completer.complete();
                          },
                          onCloseWithResult: (value) {
                            if (isClosed.value) return Future.value();
                            isClosed.value = true;
                            completer.complete(value as T);
                            return animationCompleter.future;
                          },
                        );
                        return popoverAnchor;
                      });
                }),
          ),
        );
      },
    );
    popoverEntry.initialize(overlayEntry);
    overlay.insert(overlayEntry);
    return popoverEntry;
  }
}
