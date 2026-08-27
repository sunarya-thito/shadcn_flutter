---
title: "Class: OverlayConfiguration"
description: "Describes *what* overlay to show and *how*, independent of the specific  mechanism (popover, drawer, sheet, dialog, menu, tooltip).   Each concrete subclass ([PopoverConfiguration], [DrawerConfiguration],  [SheetConfiguration], [DialogConfiguration], [MenuConfiguration],  [TooltipConfiguration]) owns its own presentation mechanism directly —  there is no separate handler/manager indirection to plug into. Each knows  how to present itself via [show], and how to adapt itself for the current  platform via [adaptiveConversion].   The content to show is *not* part of the configuration — it's supplied  separately as the [WidgetBuilder] argument to [show]/[showOverlay], so a  configuration object (and every knob it carries: alignment, margin,  width constraint, ...) can be built, overridden, or passed around  independently of what it's going to display. Result typing (`T`) belongs  to [show] itself, not the configuration — nothing about *how* an overlay  presents depends on what type its result will be.   Use [showOverlay] to present a configuration.   Example:  ```dart  showOverlay(    context,    PopoverConfiguration(      alignment: Alignment.topCenter,    ),    builder: (context) => const Text('Popover content'),  );  ```"
---

```dart
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
  OverlayConfiguration adaptiveConversion(BuildContext context);
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
  OverlayConfiguration get nonAdaptive;
  /// Finds the [OverlayConfiguration] responsible for presenting the overlay
  /// [context] is inside of, if any.
  ///
  /// Every `show()` implementation publishes itself into its content's
  /// subtree, so code inside an overlay's content can ask "what kind of
  /// overlay am I in" without each configuration hand-rolling its own marker
  /// — e.g. `OverlayConfiguration.maybeOf(context) is SheetConfiguration` or
  /// `is DialogConfiguration`.
  static OverlayConfiguration? maybeOf(BuildContext context);
}
```
