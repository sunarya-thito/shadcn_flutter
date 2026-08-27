---
title: "Class: TooltipConfiguration"
description: "[OverlayConfiguration] that presents its content as a tooltip.   Presents as a real popover (`modal: false`) on desktop platforms and as a  simplified, non-follow, fixed-position overlay on mobile platforms  (matching the historical `FixedTooltipOverlayHandler`-as-tooltip-handler  default under [ShadcnLayer]). [adaptiveConversion] stays the inherited  identity conversion — a tooltip should never become a bottom drawer."
---

```dart
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
  const TooltipConfiguration({this.anchor, this.alignment = Alignment.center, this.position, this.anchorAlignment, this.offset, this.follow = true, this.key, this.showDuration, this.dismissDuration});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
