---
title: "Class: OverlayHandler"
description: "Abstract handler for managing overlay presentation and lifecycle."
---

```dart
/// Abstract handler for managing overlay presentation and lifecycle.
///
/// Provides common interface for different overlay types (popover, sheet, dialog)
/// with customizable display, positioning, and interaction behavior.
abstract class OverlayHandler {
  /// Default popover overlay handler.
  static const OverlayHandler popover = PopoverOverlayHandler();
  /// Default sheet overlay handler.
  static const OverlayHandler sheet = SheetOverlayHandler();
  /// Default dialog overlay handler.
  static const OverlayHandler dialog = DialogOverlayHandler();
  /// Creates an [OverlayHandler].
  const OverlayHandler();
  /// Shows an overlay with the specified configuration.
  ///
  /// Displays an overlay (popover, sheet, or dialog) with extensive customization
  /// options for positioning, sizing, behavior, and appearance.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [alignment] (AlignmentGeometry, required): Overlay alignment
  /// - [builder] (WidgetBuilder, required): Overlay content builder
  /// - [position] (Offset?): Explicit position (overrides alignment)
  /// - [anchorAlignment] (AlignmentGeometry?): Anchor alignment
  /// - [widthConstraint] (PopoverConstraint): Width constraint, defaults to flexible
  /// - [heightConstraint] (PopoverConstraint): Height constraint, defaults to flexible
  /// - [key] (Key?): Widget key
  /// - [rootOverlay] (bool): Use root overlay, defaults to true
  /// - [modal] (bool): Modal behavior, defaults to true
  /// - [barrierDismissable] (bool): Dismissible by tapping barrier, defaults to true
  /// - [clipBehavior] (Clip): Clipping behavior, defaults to none
  /// - [regionGroupId] (Object?): Region group ID
  /// - [offset] (Offset?): Position offset
  /// - [transitionAlignment] (AlignmentGeometry?): Transition alignment
  /// - [margin] (EdgeInsetsGeometry?): Overlay margin
  /// - [follow] (bool): Follow anchor on move, defaults to true
  /// - [consumeOutsideTaps] (bool): Consume outside taps, defaults to true
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`): Follow tick callback
  /// - [allowInvertHorizontal] (bool): Allow horizontal inversion, defaults to true
  /// - [allowInvertVertical] (bool): Allow vertical inversion, defaults to true
  /// - [dismissBackdropFocus] (bool): Dismiss on backdrop focus, defaults to true
  /// - [showDuration] (Duration?): Show animation duration
  /// - [dismissDuration] (Duration?): Dismiss animation duration
  /// - [overlayBarrier] (OverlayBarrier?): Custom barrier configuration
  /// - [layerLink] (LayerLink?): Layer link for positioning
  ///
  /// Returns an [OverlayCompleter] for managing the overlay lifecycle.
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
