---
title: "Class: MenuConfiguration"
description: "[OverlayConfiguration] that presents its content as a menu.   Presents as a real anchored popover on desktop platforms and as a bottom  sheet on mobile platforms (matching the historical default menu behavior  under [ShadcnLayer]) — this platform branch happens directly inside  [show], so [adaptiveConversion] stays the inherited identity conversion."
---

```dart
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
  const MenuConfiguration({this.alignment = Alignment.center, this.position, this.anchorAlignment, this.widthConstraint = PopoverConstraint.flexible, this.heightConstraint = PopoverConstraint.flexible, this.key, this.rootOverlay = true, this.modal = true, this.barrierDismissable = true, this.clipBehavior = Clip.none, this.regionGroupId, this.offset, this.transitionAlignment, this.margin, this.follow = true, this.consumeOutsideTaps = true, this.onTickFollow, this.allowInvertHorizontal = true, this.allowInvertVertical = true, this.dismissBackdropFocus = true, this.showDuration, this.dismissDuration, this.overlayBarrier});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
