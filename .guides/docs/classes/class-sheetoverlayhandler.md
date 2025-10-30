---
title: "Class: SheetOverlayHandler"
description: "Overlay handler specialized for sheet-style overlays."
---

```dart
/// Overlay handler specialized for sheet-style overlays.
///
/// Provides a simplified API for showing sheet overlays (bottom sheets,
/// side sheets, etc.) with standard positioning and barrier behavior.
class SheetOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a sheet overlay.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context to check
  ///
  /// Returns true if context is within a sheet overlay, false otherwise.
  static bool isSheetOverlay(BuildContext context);
  /// Position where the sheet appears.
  final OverlayPosition position;
  /// Optional barrier color for the modal backdrop.
  final Color? barrierColor;
  /// Creates a sheet overlay handler.
  ///
  /// Parameters:
  /// - [position] (OverlayPosition): Sheet position, defaults to bottom
  /// - [barrierColor] (Color?): Optional barrier color
  const SheetOverlayHandler({this.position = OverlayPosition.bottom, this.barrierColor});
  bool operator ==(Object other);
  int get hashCode;
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
