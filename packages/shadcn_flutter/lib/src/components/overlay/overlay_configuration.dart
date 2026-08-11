import '../../../shadcn_flutter.dart';

/// Describes *what* overlay to show and *how*, independent of the specific
/// mechanism (popover, drawer, sheet, dialog, menu, tooltip).
///
/// Each concrete subclass ([PopoverConfiguration], [DrawerConfiguration],
/// [SheetConfiguration], [DialogConfiguration], [MenuConfiguration],
/// [TooltipConfiguration]) owns its own presentation mechanism directly —
/// there is no separate handler/manager indirection to plug into. Each knows
/// how to present itself via [show], and how to adapt itself for the current
/// platform via [adaptiveConversion].
///
/// The content to show is *not* part of the configuration — it's supplied
/// separately as the [WidgetBuilder] argument to [show]/[showOverlay], so a
/// configuration object (and every knob it carries: alignment, margin,
/// width constraint, ...) can be built, overridden, or passed around
/// independently of what it's going to display. Result typing (`T`) belongs
/// to [show] itself, not the configuration — nothing about *how* an overlay
/// presents depends on what type its result will be.
///
/// Use [showOverlay] to present a configuration.
///
/// Example:
/// ```dart
/// showOverlay(
///   context,
///   PopoverConfiguration(
///     alignment: Alignment.topCenter,
///   ),
///   builder: (context) => const Text('Popover content'),
/// );
/// ```
abstract class OverlayConfiguration {
  /// Creates an [OverlayConfiguration].
  const OverlayConfiguration();

  /// Actually presents the overlay using this configuration's mechanism,
  /// with [builder] as its content.
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);

  /// Returns an equivalent configuration adapted for the current platform,
  /// e.g. a [PopoverConfiguration] becomes a [DrawerConfiguration] on mobile.
  ///
  /// Returns `this` by default (no adaptation). Called by [showOverlay] when
  /// `adaptive: true` (the default).
  OverlayConfiguration adaptiveConversion(BuildContext context) => this;

  /// A configuration-level alternative to passing `adaptive: false` at every
  /// call site: a copy of this configuration whose [adaptiveConversion] is a
  /// no-op, regardless of the `adaptive`/`adaptiveOverlay` flag passed where
  /// it's shown.
  ///
  /// The base implementation returns `this` unchanged — correct as-is for
  /// every subclass whose [adaptiveConversion] is already the inherited
  /// identity (everything except [PopoverConfiguration]). Subclasses with
  /// real adaptive behavior override this to return an instance of their own
  /// type (not a wrapper of a different type), so `is` checks — e.g.
  /// `OverlayConfiguration.maybeOf(context) is SheetConfiguration`, or
  /// [OverlayController]'s same-runtime-type in-place-update check — keep
  /// working on the result exactly as they would on the original.
  OverlayConfiguration get nonAdaptive => this;

  /// Finds the [OverlayConfiguration] responsible for presenting the overlay
  /// [context] is inside of, if any.
  ///
  /// Every `show()` implementation publishes itself into its content's
  /// subtree, so code inside an overlay's content can ask "what kind of
  /// overlay am I in" without each configuration hand-rolling its own marker
  /// — e.g. `OverlayConfiguration.maybeOf(context) is SheetConfiguration` or
  /// `is DialogConfiguration`.
  static OverlayConfiguration? maybeOf(BuildContext context) =>
      Data.maybeOf<OverlayConfiguration>(context);
}

/// Unified entry point for presenting any [OverlayConfiguration].
///
/// When [adaptive] is true (the default), [configuration] is first passed
/// through [OverlayConfiguration.adaptiveConversion] so it can present itself
/// differently depending on platform (e.g. a popover becoming a bottom drawer
/// on mobile), explicitly, per call site, instead of via a single app-wide
/// default.
///
/// Example:
/// ```dart
/// showOverlay(
///   context,
///   PopoverConfiguration(
///     alignment: Alignment.topCenter,
///   ),
///   builder: (context) => const Text('Popover content'),
///   adaptive: false, // force a popover even on mobile
/// );
/// ```
OverlayCompleter<T?> showOverlay<T>(
  BuildContext context,
  OverlayConfiguration configuration, {
  required WidgetBuilder builder,
  bool adaptive = true,
}) {
  final resolved =
      adaptive ? configuration.adaptiveConversion(context) : configuration;
  return resolved.show<T>(context, builder);
}

/// Resolves the [BuildContext] to use for theme lookups when presenting an
/// overlay anchored via [anchor], mirroring how each `show()` resolves its
/// content's anchor context.
BuildContext _resolveAnchorContext(BuildContext context, Anchor? anchor) {
  if (anchor is LinkedAnchor) {
    final registry = anchor.registry ?? OverlayAnchorRegistry.of(context);
    return registry.find(anchor.key)?.context ?? context;
  } else if (anchor is ContextAnchor) {
    return anchor.context ?? context;
  }
  return context;
}

/// [OverlayConfiguration] that presents its content as a popover.
///
/// On mobile platforms, [adaptiveConversion] converts this into a
/// [DrawerConfiguration] sliding up from the bottom, matching the historical
/// default behavior under [ShadcnLayer]. Pass `adaptive: false` to
/// [showOverlay] (or call [show] directly) to always get a real popover
/// regardless of platform.
///
/// While shown, [OverlayController] can update this overlay in place (new
/// alignment, margin, etc.) by assigning a new [PopoverConfiguration] to the
/// live overlay's [OverlayCompleter.config].
class PopoverConfiguration extends OverlayConfiguration {
  /// The [Anchor] to position/track against ([LinkedAnchor] for an anchor
  /// key registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// Popover alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Width constraint mode.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode.
  final PopoverConstraint heightConstraint;

  /// Widget key for the popover overlay.
  final Key? key;

  /// Whether to use the root overlay.
  final bool rootOverlay;

  /// Whether the popover is modal.
  final bool modal;

  /// Whether tapping the barrier dismisses the popover.
  final bool barrierDismissable;

  /// Clipping behavior for the popover content.
  final Clip clipBehavior;

  /// Region grouping identifier.
  final Object? regionGroupId;

  /// Additional position offset.
  final Offset? offset;

  /// Transition origin alignment.
  final AlignmentGeometry? transitionAlignment;

  /// Popover margin.
  final EdgeInsetsGeometry? margin;

  /// Whether the popover follows the anchor if it moves.
  final bool follow;

  /// Whether outside taps are consumed.
  final bool consumeOutsideTaps;

  /// Callback invoked on every follow tick.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Whether horizontal inversion is allowed when space is constrained.
  final bool allowInvertHorizontal;

  /// Whether vertical inversion is allowed when space is constrained.
  final bool allowInvertVertical;

  /// Whether to dismiss when backdrop gains focus.
  final bool dismissBackdropFocus;

  /// Show animation duration.
  final Duration? showDuration;

  /// Dismiss animation duration.
  final Duration? dismissDuration;

  /// Custom barrier configuration.
  final OverlayBarrier? overlayBarrier;

  /// Creates a [PopoverConfiguration].
  const PopoverConfiguration({
    this.anchor,
    required this.alignment,
    this.position,
    this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.key,
    this.rootOverlay = true,
    this.modal = true,
    this.barrierDismissable = true,
    this.clipBehavior = Clip.none,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin,
    this.follow = true,
    this.consumeOutsideTaps = true,
    this.onTickFollow,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.dismissBackdropFocus = true,
    this.showDuration,
    this.dismissDuration,
    this.overlayBarrier,
  });

  /// Returns a copy of this configuration with the given fields replaced.
  PopoverConfiguration copyWith({
    ValueGetter<Anchor?>? anchor,
    ValueGetter<AlignmentGeometry>? alignment,
    ValueGetter<Offset?>? position,
    ValueGetter<AlignmentGeometry?>? anchorAlignment,
    ValueGetter<PopoverConstraint>? widthConstraint,
    ValueGetter<PopoverConstraint>? heightConstraint,
    ValueGetter<Key?>? key,
    ValueGetter<bool>? rootOverlay,
    ValueGetter<bool>? modal,
    ValueGetter<bool>? barrierDismissable,
    ValueGetter<Clip>? clipBehavior,
    ValueGetter<Object?>? regionGroupId,
    ValueGetter<Offset?>? offset,
    ValueGetter<AlignmentGeometry?>? transitionAlignment,
    ValueGetter<EdgeInsetsGeometry?>? margin,
    ValueGetter<bool>? follow,
    ValueGetter<bool>? consumeOutsideTaps,
    ValueGetter<ValueChanged<PopoverOverlayWidgetState>?>? onTickFollow,
    ValueGetter<bool>? allowInvertHorizontal,
    ValueGetter<bool>? allowInvertVertical,
    ValueGetter<bool>? dismissBackdropFocus,
    ValueGetter<Duration?>? showDuration,
    ValueGetter<Duration?>? dismissDuration,
    ValueGetter<OverlayBarrier?>? overlayBarrier,
  }) {
    return PopoverConfiguration(
      anchor: anchor == null ? this.anchor : anchor(),
      alignment: alignment == null ? this.alignment : alignment(),
      position: position == null ? this.position : position(),
      anchorAlignment:
          anchorAlignment == null ? this.anchorAlignment : anchorAlignment(),
      widthConstraint:
          widthConstraint == null ? this.widthConstraint : widthConstraint(),
      heightConstraint:
          heightConstraint == null ? this.heightConstraint : heightConstraint(),
      key: key == null ? this.key : key(),
      rootOverlay: rootOverlay == null ? this.rootOverlay : rootOverlay(),
      modal: modal == null ? this.modal : modal(),
      barrierDismissable: barrierDismissable == null
          ? this.barrierDismissable
          : barrierDismissable(),
      clipBehavior: clipBehavior == null ? this.clipBehavior : clipBehavior(),
      regionGroupId:
          regionGroupId == null ? this.regionGroupId : regionGroupId(),
      offset: offset == null ? this.offset : offset(),
      transitionAlignment: transitionAlignment == null
          ? this.transitionAlignment
          : transitionAlignment(),
      margin: margin == null ? this.margin : margin(),
      follow: follow == null ? this.follow : follow(),
      consumeOutsideTaps: consumeOutsideTaps == null
          ? this.consumeOutsideTaps
          : consumeOutsideTaps(),
      onTickFollow: onTickFollow == null ? this.onTickFollow : onTickFollow(),
      allowInvertHorizontal: allowInvertHorizontal == null
          ? this.allowInvertHorizontal
          : allowInvertHorizontal(),
      allowInvertVertical: allowInvertVertical == null
          ? this.allowInvertVertical
          : allowInvertVertical(),
      dismissBackdropFocus: dismissBackdropFocus == null
          ? this.dismissBackdropFocus
          : dismissBackdropFocus(),
      showDuration: showDuration == null ? this.showDuration : showDuration(),
      dismissDuration:
          dismissDuration == null ? this.dismissDuration : dismissDuration(),
      overlayBarrier:
          overlayBarrier == null ? this.overlayBarrier : overlayBarrier(),
    );
  }

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    Widget wrappedBuilder(BuildContext innerContext) {
      return Data<OverlayConfiguration>.inherit(
        data: this,
        child: Builder(builder: builder),
      );
    }

    final Anchor resolvedAnchor =
        (anchor ?? const ContextAnchor()).resolve(context);
    final BuildContext resolvedContext = _resolveAnchorContext(
      context,
      resolvedAnchor,
    );

    final subscription = resolvedAnchor.subscribe();
    if (!subscription.isVisible) {
      final popoverEntry = OverlayPopoverEntry<T>();
      popoverEntry.completer.complete();
      popoverEntry.animationCompleter.complete();
      return popoverEntry;
    }

    final TextDirection textDirection = Directionality.of(resolvedContext);
    final Alignment resolvedAlignment = alignment.resolve(textDirection);
    final AlignmentGeometry effectiveAnchorAlignment =
        anchorAlignment ?? alignment * -1;
    final Alignment resolvedAnchorAlignment =
        effectiveAnchorAlignment.resolve(textDirection);
    final OverlayState overlay =
        Overlay.of(resolvedContext, rootOverlay: rootOverlay);
    final themes =
        InheritedTheme.capture(from: resolvedContext, to: overlay.context);
    final data = Data.capture(from: resolvedContext, to: overlay.context);

    Size? anchorSize = subscription.anchorSize;
    Offset? effectivePosition = position;
    if (effectivePosition == null) {
      RenderBox renderBox = resolvedContext.findRenderObject() as RenderBox;
      Offset pos = renderBox.localToGlobal(Offset.zero);
      anchorSize ??= renderBox.size;
      effectivePosition = Offset(
        pos.dx +
            anchorSize.width / 2 +
            anchorSize.width / 2 * resolvedAnchorAlignment.x,
        pos.dy +
            anchorSize.height / 2 +
            anchorSize.height / 2 * resolvedAnchorAlignment.y,
      );
    }
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry();
    final GlobalKey<PopoverOverlayWidgetState> resolvedKey = key
            is GlobalKey<PopoverOverlayWidgetState>
        ? key as GlobalKey<PopoverOverlayWidgetState>
        : GlobalKey<PopoverOverlayWidgetState>(debugLabel: 'PopoverAnchor$key');
    popoverEntry.stateKey = resolvedKey;
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    ValueNotifier<bool> isClosed = ValueNotifier(false);
    Future<T?> onClose() {
      if (isClosed.value) return Future.value();
      isClosed.value = true;
      completer.complete();
      return animationCompleter.future;
    }

    void onImmediateClose() {
      popoverEntry.remove();
      completer.complete();
    }

    Future<T?> onCloseWithResult(Object? value) {
      if (isClosed.value) return Future.value();
      isClosed.value = true;
      completer.complete(value as T);
      return animationCompleter.future;
    }

    popoverEntry.onClose = onClose;
    popoverEntry.onImmediateClose = onImmediateClose;
    popoverEntry.onCloseWithResult = onCloseWithResult;
    OverlayEntry? barrierEntry;
    late OverlayEntry overlayEntry;
    if (modal) {
      if (consumeOutsideTaps) {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      } else {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      }
    }

    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: AnimatedBuilder(
              animation: isClosed,
              builder: (innerContext, child) {
                return FocusScope(
                  autofocus: dismissBackdropFocus,
                  canRequestFocus: !isClosed.value,
                  child: AnimatedValueBuilder.animation(
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
                        var popoverAnchor = PopoverOverlayWidget(
                          animation: animation,
                          onTapOutside: () {
                            if (isClosed.value) return;
                            if (!modal) {
                              isClosed.value = true;
                              completer.complete();
                            }
                          },
                          key: resolvedKey,
                          anchor: resolvedAnchor,
                          position: effectivePosition!,
                          alignment: resolvedAlignment,
                          themes: themes,
                          builder: wrappedBuilder,
                          anchorSize: anchorSize,
                          anchorAlignment: resolvedAnchorAlignment,
                          widthConstraint: widthConstraint,
                          heightConstraint: heightConstraint,
                          regionGroupId: regionGroupId,
                          offset: offset,
                          transitionAlignment: transitionAlignment,
                          margin: margin,
                          follow: follow,
                          consumeOutsideTaps: consumeOutsideTaps,
                          onTickFollow: onTickFollow,
                          allowInvertHorizontal: allowInvertHorizontal,
                          allowInvertVertical: allowInvertVertical,
                          data: data,
                          onClose: onClose,
                          onImmediateClose: onImmediateClose,
                          onCloseWithResult: onCloseWithResult,
                          completer: popoverEntry,
                        );
                        return popoverAnchor;
                      }),
                );
              }),
        );
      },
    );
    popoverEntry.initialize(overlayEntry, barrierEntry);
    if (barrierEntry != null) {
      overlay.insert(barrierEntry);
    }
    overlay.insert(overlayEntry);
    return popoverEntry;
  }

  @override
  OverlayConfiguration adaptiveConversion(BuildContext context) {
    if (isMobile(Theme.of(context).platform)) {
      return toDrawer();
    }
    return this;
  }

  @override
  OverlayConfiguration get nonAdaptive => _NonAdaptivePopoverConfiguration(this);

  /// Converts this configuration into an equivalent [DrawerConfiguration].
  ///
  /// Used automatically by [adaptiveConversion] on mobile platforms; can also
  /// be called directly for manual conversion.
  DrawerConfiguration toDrawer({
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    return DrawerConfiguration(
      anchor: anchor,
      position: position,
      barrierDismissible: barrierDismissable,
    );
  }
}

/// [PopoverConfiguration.nonAdaptive]'s result: a [PopoverConfiguration] that
/// never converts, produced by copying every field of the source rather than
/// wrapping it — so it stays a real [PopoverConfiguration] and every `is`
/// check on it behaves exactly as on the original.
class _NonAdaptivePopoverConfiguration extends PopoverConfiguration {
  _NonAdaptivePopoverConfiguration(PopoverConfiguration source)
      : super(
          anchor: source.anchor,
          alignment: source.alignment,
          position: source.position,
          anchorAlignment: source.anchorAlignment,
          widthConstraint: source.widthConstraint,
          heightConstraint: source.heightConstraint,
          key: source.key,
          rootOverlay: source.rootOverlay,
          modal: source.modal,
          barrierDismissable: source.barrierDismissable,
          clipBehavior: source.clipBehavior,
          regionGroupId: source.regionGroupId,
          offset: source.offset,
          transitionAlignment: source.transitionAlignment,
          margin: source.margin,
          follow: source.follow,
          consumeOutsideTaps: source.consumeOutsideTaps,
          onTickFollow: source.onTickFollow,
          allowInvertHorizontal: source.allowInvertHorizontal,
          allowInvertVertical: source.allowInvertVertical,
          dismissBackdropFocus: source.dismissBackdropFocus,
          showDuration: source.showDuration,
          dismissDuration: source.dismissDuration,
          overlayBarrier: source.overlayBarrier,
        );

  @override
  OverlayConfiguration adaptiveConversion(BuildContext context) => this;

  @override
  OverlayConfiguration get nonAdaptive => this;
}

/// [OverlayConfiguration] that presents its content as a side/bottom drawer
/// (with backdrop transform).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class DrawerConfiguration extends OverlayConfiguration {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// The edge the drawer slides in from.
  final OverlayPosition position;

  /// Whether the drawer expands to fill available space.
  final bool expands;

  /// Whether the drawer can be dragged to dismiss.
  final bool draggable;

  /// Whether tapping the barrier dismisses the drawer.
  final bool barrierDismissible;

  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;

  /// Whether to respect device safe areas.
  final bool useSafeArea;

  /// Whether to show a drag handle.
  final bool? showDragHandle;

  /// Corner radius for the drawer.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the drag handle.
  final Size? dragHandleSize;

  /// Whether to scale/transform the backdrop.
  final bool transformBackdrop;

  /// Opacity for surface effects.
  final double? surfaceOpacity;

  /// Blur intensity for surface effects.
  final double? surfaceBlur;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// Custom animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on creation.
  final bool autoOpen;

  /// Size constraints for the drawer.
  final BoxConstraints? constraints;

  /// Alignment within constraints.
  final AlignmentGeometry? alignment;

  /// Creates a [DrawerConfiguration].
  const DrawerConfiguration({
    this.anchor,
    this.position = OverlayPosition.bottom,
    this.expands = false,
    this.draggable = true,
    this.barrierDismissible = true,
    this.backdropBuilder,
    this.useSafeArea = true,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop = true,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.animationController,
    this.autoOpen = true,
    this.constraints,
    this.alignment,
  });

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    final themeContext = _resolveAnchorContext(context, anchor);
    final theme = ComponentTheme.maybeOf<DrawerTheme>(themeContext);
    final resolvedShowDragHandle =
        showDragHandle ?? theme?.showDragHandle ?? true;
    final resolvedSurfaceOpacity = surfaceOpacity ?? theme?.surfaceOpacity;
    final resolvedSurfaceBlur = surfaceBlur ?? theme?.surfaceBlur;
    final resolvedBarrierColor = barrierColor ?? theme?.barrierColor;
    final resolvedDragHandleSize = dragHandleSize ?? theme?.dragHandleSize;
    Widget wrappedBuilder(BuildContext innerContext) {
      return Data<OverlayConfiguration>.inherit(
        data: this,
        child: Builder(builder: builder),
      );
    }
    return openRawDrawer<T>(
      anchor: anchor ?? ContextAnchor(context),
      barrierDismissible: barrierDismissible,
      backdropBuilder: backdropBuilder,
      useSafeArea: useSafeArea,
      transformBackdrop: transformBackdrop,
      animationController: animationController,
      autoOpen: autoOpen,
      constraints: constraints,
      alignment: alignment,
      builder: (context, extraSize, size, padding, stackIndex) {
        return DrawerWrapper(
          position: position,
          expands: expands,
          draggable: draggable,
          extraSize: extraSize,
          size: size,
          showDragHandle: resolvedShowDragHandle,
          dragHandleSize: resolvedDragHandleSize,
          padding: padding,
          borderRadius: borderRadius,
          surfaceOpacity: resolvedSurfaceOpacity,
          surfaceBlur: resolvedSurfaceBlur,
          barrierColor: resolvedBarrierColor,
          stackIndex: stackIndex,
          child: Builder(builder: wrappedBuilder),
        );
      },
      position: position,
    );
  }
}

/// [OverlayConfiguration] that presents its content as a minimally-styled,
/// full-extent sheet (no backdrop transform, unlike [DrawerConfiguration]).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class SheetConfiguration extends OverlayConfiguration {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// The edge the sheet slides in from.
  final OverlayPosition position;

  /// Whether tapping the barrier dismisses the sheet.
  final bool barrierDismissible;

  /// Whether to transform the backdrop.
  final bool transformBackdrop;

  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// Whether the sheet can be dragged to dismiss.
  final bool draggable;

  /// Custom animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on creation.
  final bool autoOpen;

  /// Size constraints for the sheet.
  final BoxConstraints? constraints;

  /// Alignment within constraints.
  final AlignmentGeometry? alignment;

  /// Whether to respect device safe areas around the sheet.
  ///
  /// Defaults to `false` since [SheetWrapper] handles safe-area padding
  /// itself for the direct-sheet case. [MenuConfiguration] passes `true`
  /// here for its mobile fallback presentation, matching the historical
  /// `SheetOverlayHandler`-as-menu-handler behavior.
  final bool useSafeArea;

  /// Creates a [SheetConfiguration].
  const SheetConfiguration({
    this.anchor,
    this.position = OverlayPosition.bottom,
    this.barrierDismissible = true,
    this.transformBackdrop = false,
    this.backdropBuilder,
    this.barrierColor,
    this.draggable = false,
    this.animationController,
    this.autoOpen = true,
    this.constraints,
    this.alignment,
    this.useSafeArea = false,
  });

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    final themeContext = _resolveAnchorContext(context, anchor);
    final theme = ComponentTheme.maybeOf<DrawerTheme>(themeContext);
    final resolvedBarrierColor = barrierColor ?? theme?.barrierColor;
    Widget wrappedBuilder(BuildContext innerContext) {
      return Data<OverlayConfiguration>.inherit(
        data: this,
        child: Builder(builder: builder),
      );
    }
    return openRawDrawer<T>(
      anchor: anchor ?? ContextAnchor(context),
      transformBackdrop: transformBackdrop,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      backdropBuilder: backdropBuilder,
      animationController: animationController,
      autoOpen: autoOpen,
      constraints: constraints,
      alignment: alignment,
      builder: (context, extraSize, size, padding, stackIndex) {
        final theme = Theme.of(context);
        return SheetWrapper(
          position: position,
          gapAfterDragger: 8 * theme.scaling,
          expands: true,
          draggable: draggable,
          extraSize: extraSize,
          size: size,
          padding: padding,
          barrierColor: resolvedBarrierColor,
          stackIndex: stackIndex,
          child: Builder(builder: wrappedBuilder),
        );
      },
      position: position,
    );
  }
}

/// [OverlayConfiguration] that presents its content as a modal dialog via
/// [Navigator]/[DialogRoute].
///
/// Dialogs are usually an intentional choice regardless of platform, so
/// [adaptiveConversion] is the identity conversion (no adaptation performed).
///
/// `Navigator.push` only exposes a [Future], so [OverlayCompleter.remove] and
/// [OverlayCompleter.dispose] do nothing here. Close the dialog with
/// `Navigator.pop` or `closeOverlay` instead.
class DialogConfiguration extends OverlayConfiguration {
  /// Whether to use the root navigator.
  final bool useRootNavigator;

  /// Whether tapping outside dismisses the dialog.
  final bool barrierDismissible;

  /// Color of the backdrop barrier.
  final Color? barrierColor;

  /// Semantic label for the barrier.
  final String? barrierLabel;

  /// Whether to respect device safe areas.
  final bool useSafeArea;

  /// Settings for the route.
  final RouteSettings? routeSettings;

  /// Anchor point for transitions.
  final Offset? anchorPoint;

  /// Focus traversal edge behavior.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// Dialog alignment, defaults to center.
  final AlignmentGeometry? alignment;

  /// Whether to display in full-screen mode.
  final bool fullScreen;

  /// Creates a [DialogConfiguration].
  const DialogConfiguration({
    this.useRootNavigator = true,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.useSafeArea = true,
    this.routeSettings,
    this.anchorPoint,
    this.traversalEdgeBehavior,
    this.alignment,
    this.fullScreen = false,
  });

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    final navigatorState = Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    );
    final CapturedThemes themes =
        InheritedTheme.capture(from: context, to: navigatorState.context);
    final CapturedData data =
        Data.capture(from: context, to: navigatorState.context);
    final dialogRoute = DialogRoute<T>(
      context: context,
      builder: (context) {
        return DialogOverlayContent<T>(
          route: ModalRoute.of(context) as DialogRoute<T>,
          child: Data<OverlayConfiguration>.inherit(
            data: this,
            child: Builder(builder: (context) {
              return builder(context);
            }),
          ),
        );
      },
      themes: themes,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? const Color.fromRGBO(0, 0, 0, 0),
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      anchorPoint: anchorPoint,
      data: data,
      traversalEdgeBehavior:
          traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return buildShadcnDialogTransitions(
          context,
          BorderRadius.zero,
          alignment ?? Alignment.center,
          animation,
          secondaryAnimation,
          fullScreen,
          child,
        );
      },
      alignment: alignment ?? Alignment.center,
    );
    final future = navigatorState.push(dialogRoute);
    return _FutureOverlayCompleter<T>(future);
  }
}

/// [OverlayConfiguration] that presents its content as a menu.
///
/// Presents as a real anchored popover on desktop platforms and as a bottom
/// sheet on mobile platforms (matching the historical default menu behavior
/// under [ShadcnLayer]) — this platform branch happens directly inside
/// [show], so [adaptiveConversion] stays the inherited identity conversion.
class MenuConfiguration extends OverlayConfiguration {
  /// Menu alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Width constraint mode.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode.
  final PopoverConstraint heightConstraint;

  /// Widget key for the menu overlay.
  final Key? key;

  /// Whether to use the root overlay.
  final bool rootOverlay;

  /// Whether the menu is modal.
  final bool modal;

  /// Whether tapping the barrier dismisses the menu.
  final bool barrierDismissable;

  /// Clipping behavior for the menu content.
  final Clip clipBehavior;

  /// Region grouping identifier.
  final Object? regionGroupId;

  /// Additional position offset.
  final Offset? offset;

  /// Transition origin alignment.
  final AlignmentGeometry? transitionAlignment;

  /// Menu margin.
  final EdgeInsetsGeometry? margin;

  /// Whether the menu follows the anchor if it moves.
  final bool follow;

  /// Whether outside taps are consumed.
  final bool consumeOutsideTaps;

  /// Callback invoked on every follow tick.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Whether horizontal inversion is allowed when space is constrained.
  final bool allowInvertHorizontal;

  /// Whether vertical inversion is allowed when space is constrained.
  final bool allowInvertVertical;

  /// Whether to dismiss when backdrop gains focus.
  final bool dismissBackdropFocus;

  /// Show animation duration.
  final Duration? showDuration;

  /// Dismiss animation duration.
  final Duration? dismissDuration;

  /// Custom barrier configuration.
  final OverlayBarrier? overlayBarrier;

  /// Creates a [MenuConfiguration].
  const MenuConfiguration({
    this.alignment = Alignment.center,
    this.position,
    this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.key,
    this.rootOverlay = true,
    this.modal = true,
    this.barrierDismissable = true,
    this.clipBehavior = Clip.none,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin,
    this.follow = true,
    this.consumeOutsideTaps = true,
    this.onTickFollow,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.dismissBackdropFocus = true,
    this.showDuration,
    this.dismissDuration,
    this.overlayBarrier,
  });

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    if (isMobile(Theme.of(context).platform)) {
      return SheetConfiguration(
        position: OverlayPosition.bottom,
        barrierDismissible: barrierDismissable,
        draggable: barrierDismissable,
        transformBackdrop: false,
        useSafeArea: true,
      ).show<T>(context, builder);
    }
    return PopoverConfiguration(
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
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
    ).show<T>(context, builder);
  }
}

/// [OverlayConfiguration] that presents its content as a tooltip.
///
/// Presents as a real popover (`modal: false`) on desktop platforms and as a
/// simplified, non-follow, fixed-position overlay on mobile platforms
/// (matching the historical `FixedTooltipOverlayHandler`-as-tooltip-handler
/// default under [ShadcnLayer]). [adaptiveConversion] stays the inherited
/// identity conversion — a tooltip should never become a bottom drawer.
class TooltipConfiguration extends OverlayConfiguration {
  /// The [Anchor] to resolve against, if using anchor-based positioning
  /// instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// Tooltip alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Additional position offset.
  final Offset? offset;

  /// Whether the tooltip follows the anchor if it moves. Only honored on
  /// desktop platforms — the mobile presentation never follows.
  final bool follow;

  /// Widget key for the tooltip overlay.
  final Key? key;

  /// Show animation duration. Defaults to [kDefaultDuration].
  final Duration? showDuration;

  /// Dismiss animation duration. Defaults to 100ms.
  final Duration? dismissDuration;

  /// Creates a [TooltipConfiguration].
  const TooltipConfiguration({
    this.anchor,
    this.alignment = Alignment.center,
    this.position,
    this.anchorAlignment,
    this.offset,
    this.follow = true,
    this.key,
    this.showDuration,
    this.dismissDuration,
  });

  @override
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder) {
    if (isMobile(Theme.of(context).platform)) {
      return _showFixed<T>(context, builder);
    }
    return PopoverConfiguration(
      anchor: anchor,
      modal: false,
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      offset: offset,
      follow: follow,
      key: key,
      dismissBackdropFocus: false,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
    ).show<T>(context, builder);
  }

  /// The simplified, non-follow, fixed-position mobile presentation
  /// (absorbed from the historical `FixedTooltipOverlayHandler`): no barrier,
  /// no anchor-following, a fixed margin around the viewport edges.
  OverlayCompleter<T?> _showFixed<T>(
      BuildContext context, WidgetBuilder builder) {
    Widget wrappedBuilder(BuildContext innerContext) {
      return Data<OverlayConfiguration>.inherit(
        data: this,
        child: Builder(builder: builder),
      );
    }

    final Anchor resolvedAnchor =
        (anchor ?? const ContextAnchor()).resolve(context);
    final BuildContext resolvedContext = _resolveAnchorContext(
      context,
      resolvedAnchor,
    );

    final subscription = resolvedAnchor.subscribe();
    if (!subscription.isVisible) {
      final popoverEntry = OverlayPopoverEntry<T>();
      popoverEntry.completer.complete();
      popoverEntry.animationCompleter.complete();
      return popoverEntry;
    }

    final TextDirection textDirection = Directionality.of(resolvedContext);
    final Alignment resolvedAlignment = alignment.resolve(textDirection);
    final AlignmentGeometry effectiveAnchorAlignment =
        anchorAlignment ?? alignment * -1;
    final Alignment resolvedAnchorAlignment =
        effectiveAnchorAlignment.resolve(textDirection);
    final OverlayState overlay =
        Overlay.of(resolvedContext, rootOverlay: true);
    final themes =
        InheritedTheme.capture(from: resolvedContext, to: overlay.context);
    final data = Data.capture(from: resolvedContext, to: overlay.context);

    ValueNotifier<bool> isClosed = ValueNotifier(false);
    late OverlayEntry overlayEntry;
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry();
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: FocusScope(
            autofocus: false,
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
                            isClosed.value = true;
                            completer.complete();
                          },
                          key: key,
                          anchor: resolvedAnchor,
                          position: position,
                          alignment: resolvedAlignment,
                          themes: themes,
                          builder: wrappedBuilder,
                          anchorAlignment: resolvedAnchorAlignment,
                          widthConstraint: PopoverConstraint.flexible,
                          heightConstraint: PopoverConstraint.flexible,
                          offset: offset,
                          transitionAlignment: Alignment.center,
                          margin: EdgeInsets.all(
                              theme.density.baseContentPadding *
                                  theme.scaling *
                                  3),
                          follow: false,
                          consumeOutsideTaps: false,
                          allowInvertHorizontal: true,
                          allowInvertVertical: true,
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
                          completer: popoverEntry,
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

/// Adapts a plain [Future]-based result (as returned by [Navigator.push]) to
/// the [OverlayCompleter] interface expected by [OverlayConfiguration.show].
///
/// [remove] and [dispose] are no-ops since a [Future] alone doesn't expose a
/// way to imperatively dismiss the underlying route.
class _FutureOverlayCompleter<T> extends OverlayCompleter<T?> {
  @override
  final Future<T?> future;

  bool _completed = false;

  _FutureOverlayCompleter(this.future) {
    future.whenComplete(() => _completed = true);
  }

  @override
  Future<void> get animationFuture => future.then((_) {});

  @override
  bool get isCompleted => _completed;

  @override
  bool get isAnimationCompleted => _completed;

  @override
  void remove() {}

  @override
  void dispose() {}
}

/// A controller for managing a single overlay's lifecycle, driven by
/// [OverlayConfiguration] instead of popover-specific parameters.
///
/// If [show] is called again with the same configuration type (still a
/// [PopoverConfiguration], say, just with a different
/// [PopoverConfiguration.alignment]), the open overlay is updated in place
/// through [OverlayCompleter.config] rather than being closed and reopened.
/// A different configuration type, or no overlay currently open, always
/// closes whatever is open and starts fresh.
///
/// Field meanings like "alignment" or "margin" aren't interpreted here.
/// Each [OverlayCompleter] implementation, for example the one
/// [PopoverConfiguration.show] returns, reads whatever configuration it's
/// assigned through [OverlayCompleter.config] on its own terms.
///
/// Example:
/// ```dart
/// class _MyWidgetState extends State<MyWidget> {
///   final OverlayController _controller = OverlayController();
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   void _showMenu() async {
///     await _controller.show(
///       context,
///       PopoverConfiguration(
///         anchor: LinkedAnchor(#myAnchor),
///         alignment: Alignment.bottomStart,
///       ),
///       builder: (context) => MyPopoverContent(),
///     );
///   }
/// }
/// ```
class OverlayController extends ChangeNotifier {
  bool _disposed = false;
  OverlayCompleter? _completer;
  OverlayConfiguration? _config;

  /// The configuration of the currently-open overlay, or `null` if nothing
  /// is open. There's no setter: use [show] to open or update an overlay,
  /// since assigning [config] directly has no [BuildContext] to anchor to.
  OverlayConfiguration? get config => _config;

  /// Whether there's an open overlay that hasn't completed.
  bool get hasOpenOverlay => _completer != null && !_completer!.isCompleted;

  /// Whether there's a mounted overlay with an animation in progress.
  bool get hasMountedOverlay =>
      _completer != null && !_completer!.isAnimationCompleted;

  /// Shows an overlay using the given [configuration], anchored to [context],
  /// with [builder] as its content.
  ///
  /// If an overlay managed by this controller is already open with a
  /// configuration of the exact same runtime type as [configuration], it's
  /// updated in place via [OverlayCompleter.config] (see class docs);
  /// otherwise it's closed and the new configuration is opened fresh.
  /// [adaptive] is forwarded to [OverlayConfiguration.adaptiveConversion].
  Future<T?> show<T>(
    BuildContext context,
    OverlayConfiguration configuration, {
    required WidgetBuilder builder,
    bool adaptive = true,
  }) {
    final resolved =
        adaptive ? configuration.adaptiveConversion(context) : configuration;

    final currentCompleter = _completer;
    final currentConfig = _config;
    if (currentCompleter != null &&
        !currentCompleter.isCompleted &&
        currentConfig != null &&
        resolved.runtimeType == currentConfig.runtimeType) {
      currentCompleter.config = resolved;
      _config = resolved;
      notifyListeners();
      return currentCompleter.future as Future<T?>;
    }

    close();
    final completer = resolved.show<T>(context, builder);
    _completer = completer;
    _config = resolved;
    notifyListeners();
    completer.future.whenComplete(() {
      if (identical(_completer, completer)) {
        _completer = null;
        _config = null;
        if (!_disposed) {
          notifyListeners();
        }
      }
    });
    return completer.future;
  }

  /// Closes the managed overlay, if any.
  ///
  /// Parameters:
  /// - [immediate] (bool, default: false): Skip closing animations when true.
  void close([bool immediate = false]) {
    final completer = _completer;
    if (completer == null) return;
    completer.close(immediate);
    _completer = null;
    _config = null;
    notifyListeners();
  }

  /// Schedules closure of the managed overlay for the next frame.
  void closeLater() {
    final completer = _completer;
    if (completer == null) return;
    completer.closeLater();
    _completer = null;
    _config = null;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    closeLater();
    super.dispose();
  }
}
