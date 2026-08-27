---
title: "Class: PopoverConfiguration"
description: "[OverlayConfiguration] that presents its content as a popover.   On mobile platforms, [adaptiveConversion] converts this into a  [DrawerConfiguration] sliding up from the bottom, matching the historical  default behavior under [ShadcnLayer]. Pass `adaptive: false` to  [showOverlay] (or call [show] directly) to always get a real popover  regardless of platform.   While shown, [OverlayController] can update this overlay in place (new  alignment, margin, etc.) by assigning a new [PopoverConfiguration] to the  live overlay's [OverlayCompleter.config]."
---

```dart
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
  const PopoverConfiguration({this.anchor, required this.alignment, this.position, this.anchorAlignment, this.widthConstraint = PopoverConstraint.flexible, this.heightConstraint = PopoverConstraint.flexible, this.key, this.rootOverlay = true, this.modal = true, this.barrierDismissable = true, this.clipBehavior = Clip.none, this.regionGroupId, this.offset, this.transitionAlignment, this.margin, this.follow = true, this.consumeOutsideTaps = true, this.onTickFollow, this.allowInvertHorizontal = true, this.allowInvertVertical = true, this.dismissBackdropFocus = true, this.showDuration, this.dismissDuration, this.overlayBarrier});
  /// Returns a copy of this configuration with the given fields replaced.
  PopoverConfiguration copyWith({ValueGetter<Anchor?>? anchor, ValueGetter<AlignmentGeometry>? alignment, ValueGetter<Offset?>? position, ValueGetter<AlignmentGeometry?>? anchorAlignment, ValueGetter<PopoverConstraint>? widthConstraint, ValueGetter<PopoverConstraint>? heightConstraint, ValueGetter<Key?>? key, ValueGetter<bool>? rootOverlay, ValueGetter<bool>? modal, ValueGetter<bool>? barrierDismissable, ValueGetter<Clip>? clipBehavior, ValueGetter<Object?>? regionGroupId, ValueGetter<Offset?>? offset, ValueGetter<AlignmentGeometry?>? transitionAlignment, ValueGetter<EdgeInsetsGeometry?>? margin, ValueGetter<bool>? follow, ValueGetter<bool>? consumeOutsideTaps, ValueGetter<ValueChanged<PopoverOverlayWidgetState>?>? onTickFollow, ValueGetter<bool>? allowInvertHorizontal, ValueGetter<bool>? allowInvertVertical, ValueGetter<bool>? dismissBackdropFocus, ValueGetter<Duration?>? showDuration, ValueGetter<Duration?>? dismissDuration, ValueGetter<OverlayBarrier?>? overlayBarrier});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
  OverlayConfiguration adaptiveConversion(BuildContext context);
  OverlayConfiguration get nonAdaptive;
  /// Converts this configuration into an equivalent [DrawerConfiguration].
  ///
  /// Used automatically by [adaptiveConversion] on mobile platforms; can also
  /// be called directly for manual conversion.
  DrawerConfiguration toDrawer({OverlayPosition position = OverlayPosition.bottom});
}
```
