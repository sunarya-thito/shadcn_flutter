import 'package:shadcn_flutter/src/components/control/hover.dart';

import '../../../shadcn_flutter.dart';

/// Theme data for customizing [TooltipContainer] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// tooltip containers, including surface effects, padding, colors,
/// and border styling. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TooltipTheme {
  /// Opacity applied to the tooltip surface color.
  final double? surfaceOpacity;

  /// Blur amount for the tooltip surface.
  final double? surfaceBlur;

  /// Padding around the tooltip content.
  final EdgeInsetsGeometry? padding;

  /// Background color of the tooltip.
  final Color? backgroundColor;

  /// Border radius of the tooltip container.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [TooltipTheme].
  const TooltipTheme({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  TooltipTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return TooltipTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      padding: padding == null ? this.padding : padding(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TooltipTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
      surfaceOpacity, surfaceBlur, padding, backgroundColor, borderRadius);
}

/// A styled container widget for tooltip content.
///
/// Provides consistent visual styling for tooltip popups with customizable
/// background, opacity, blur, padding, and border radius. Integrates with
/// the tooltip theme system while allowing per-instance overrides.
class TooltipContainer extends StatelessWidget {
  /// The tooltip content widget.
  final Widget child;

  /// Opacity applied to the background surface (0.0 to 1.0).
  final double? surfaceOpacity;

  /// Blur radius applied to the background surface.
  final double? surfaceBlur;

  /// Padding around the tooltip content.
  final EdgeInsetsGeometry? padding;

  /// Background color of the tooltip container.
  final Color? backgroundColor;

  /// Border radius for rounded corners.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [TooltipContainer].
  ///
  /// All styling parameters are optional and fall back to theme defaults.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Content to display in the tooltip.
  /// - [surfaceOpacity] (`double?`, optional): Background opacity (0.0-1.0).
  /// - [surfaceBlur] (`double?`, optional): Background blur radius.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Content padding.
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Border radius.
  ///
  /// Example:
  /// ```dart
  /// TooltipContainer(
  ///   surfaceOpacity: 0.9,
  ///   padding: EdgeInsets.all(8),
  ///   backgroundColor: Colors.black,
  ///   borderRadius: BorderRadius.circular(4),
  ///   child: Text('Tooltip text'),
  /// )
  /// ```
  const TooltipContainer({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    required this.child,
  });

  /// Builds the tooltip container.
  ///
  /// This allows using the widget as a builder function.
  Widget call(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TooltipTheme>(context);
    Color backgroundColor = styleValue(
        widgetValue: this.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: theme.colorScheme.primary);
    var surfaceOpacity = this.surfaceOpacity ?? compTheme?.surfaceOpacity;
    var surfaceBlur = this.surfaceBlur ?? compTheme?.surfaceBlur;
    if (surfaceOpacity != null) {
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    final padding = styleValue(
                widgetValue: this.padding,
                themeValue: compTheme?.padding,
                defaultValue:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6))
            .resolve(Directionality.of(context)) *
        scaling;
    final borderRadius = styleValue(
        widgetValue: this.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusSm));
    Widget animatedContainer = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child.xSmall().primaryForeground(),
    );
    if (surfaceBlur != null && surfaceBlur > 0) {
      animatedContainer = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: borderRadius,
        child: animatedContainer,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(6) * scaling,
      child: animatedContainer,
    );
  }
}

/// An interactive tooltip widget that displays contextual information on hover.
///
/// [Tooltip] provides contextual help and information by displaying a small overlay
/// when users hover over or interact with the child widget. It supports configurable
/// positioning, timing, and custom content through builder functions, making it
/// ideal for providing additional context without cluttering the interface.
///
/// Key features:
/// - Hover-activated tooltip display with configurable delays
/// - Flexible positioning with alignment and anchor point control
/// - Custom content through builder functions
/// - Duration controls for show/hide timing and minimum display time
/// - Smooth animations and transitions
/// - Integration with the overlay system for proper z-ordering
/// - Theme support for consistent styling
/// - Automatic positioning adjustment to stay within screen bounds
///
/// Timing behavior:
/// - Wait duration: Time to wait before showing tooltip on hover
/// - Show duration: Animation time for tooltip appearance
/// - Min duration: Minimum time tooltip stays visible once shown
/// - Auto-hide: Tooltip disappears when hover ends (after min duration)
///
/// The tooltip uses a popover-based implementation that ensures proper layering
/// and positioning relative to the trigger widget. The positioning system
/// automatically adjusts to keep tooltips within the viewport.
///
/// Example:
/// ```dart
/// Tooltip(
///   tooltip: (context) => TooltipContainer(
///     child: Text('This button performs a critical action'),
///   ),
///   waitDuration: Duration(milliseconds: 800),
///   showDuration: Duration(milliseconds: 150),
///   alignment: Alignment.topCenter,
///   anchorAlignment: Alignment.bottomCenter,
///   child: IconButton(
///     icon: Icon(Icons.warning),
///     onPressed: () => _handleCriticalAction(),
///   ),
/// );
/// ```
class Tooltip extends StatefulWidget {
  /// The widget that triggers the tooltip on hover.
  final Widget child;

  /// Builder function for the tooltip content.
  final WidgetBuilder tooltip;

  /// Alignment of the tooltip relative to the anchor.
  final AlignmentGeometry alignment;

  /// Alignment point on the child widget where tooltip anchors.
  final AlignmentGeometry anchorAlignment;

  /// Time to wait before showing the tooltip on hover.
  final Duration waitDuration;

  /// Duration of the tooltip show animation.
  final Duration showDuration;

  /// Minimum time the tooltip stays visible once shown.
  final Duration minDuration;

  /// Creates a [Tooltip].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers the tooltip.
  /// - [tooltip] (`WidgetBuilder`, required): Builder for tooltip content.
  /// - [alignment] (`AlignmentGeometry`, default: `Alignment.topCenter`): Tooltip position.
  /// - [anchorAlignment] (`AlignmentGeometry`, default: `Alignment.bottomCenter`): Anchor point on child.
  /// - [waitDuration] (`Duration`, default: 500ms): Delay before showing.
  /// - [showDuration] (`Duration`, default: 200ms): Animation duration.
  /// - [minDuration] (`Duration`, default: 0ms): Minimum visible time.
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

/// A tooltip that shows immediately on hover without delay.
///
/// Unlike [Tooltip], this widget displays the tooltip instantly when the
/// mouse enters the child widget area. It's useful for situations where
/// immediate feedback is desired, such as toolbar buttons or icon-only
/// controls where labels need to be visible right away.
///
/// The tooltip automatically closes when the mouse leaves the widget.
class InstantTooltip extends StatefulWidget {
  /// The widget that triggers the tooltip on hover.
  final Widget child;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  /// Builder function for the tooltip content.
  final WidgetBuilder tooltipBuilder;

  /// Alignment of the tooltip relative to the anchor.
  final AlignmentGeometry tooltipAlignment;

  /// Alignment point on the child widget where tooltip anchors.
  final AlignmentGeometry? tooltipAnchorAlignment;

  /// Creates an [InstantTooltip].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers the tooltip.
  /// - [tooltipBuilder] (`WidgetBuilder`, required): Builder for tooltip content.
  /// - [behavior] (`HitTestBehavior`, default: `HitTestBehavior.translucent`): Hit test behavior.
  /// - [tooltipAlignment] (`AlignmentGeometry`, default: `Alignment.bottomCenter`): Tooltip position.
  /// - [tooltipAnchorAlignment] (`AlignmentGeometry?`, optional): Anchor point on child.
  ///
  /// Example:
  /// ```dart
  /// InstantTooltip(
  ///   tooltipBuilder: (context) => Text('Help text'),
  ///   child: Icon(Icons.help),
  /// )
  /// ```
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

/// Overlay handler that delegates tooltip display to an [OverlayManager].
///
/// This handler integrates tooltips with the overlay management system,
/// allowing tooltips to be displayed through the overlay manager's
/// tooltip-specific display logic. This ensures proper layering and
/// lifecycle management within the overlay system.
class OverlayManagerAsTooltipOverlayHandler extends OverlayHandler {
  /// The overlay manager instance to use for displaying tooltips.
  final OverlayManager overlayManager;

  /// Creates an [OverlayManagerAsTooltipOverlayHandler].
  ///
  /// Parameters:
  /// - [overlayManager] (`OverlayManager`, required): The overlay manager instance.
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

/// A fixed overlay handler for tooltips using direct overlay entries.
///
/// This handler creates tooltips using Flutter's built-in overlay system
/// without delegating to an overlay manager. Tooltips are positioned
/// directly in the overlay and use fixed positioning relative to their
/// anchor widget.
///
/// Use this handler when you need direct control over tooltip overlay
/// entries or when not using an overlay manager.
class FixedTooltipOverlayHandler extends OverlayHandler {
  /// Creates a [FixedTooltipOverlayHandler].
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
