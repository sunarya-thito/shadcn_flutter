---
title: "Mixin: OverlayHandlerStateMixin"
description: "Mixin providing overlay state management methods."
---

```dart
/// Mixin providing overlay state management methods.
///
/// Defines the interface for overlay state classes, including methods for
/// closing overlays and updating overlay configuration dynamically.
///
/// Used by overlay implementations to provide consistent lifecycle management
/// and configuration update capabilities.
mixin OverlayHandlerStateMixin<T extends StatefulWidget> on State<T> {
  /// Closes the overlay.
  ///
  /// Parameters:
  /// - [immediate] (bool): If true, closes immediately without animation
  ///
  /// Returns a [Future] that completes when closed.
  Future<void> close([bool immediate = false]);
  /// Schedules overlay closure for the next frame.
  ///
  /// Useful for closing overlays from callbacks where immediate closure
  /// might cause issues with the widget tree.
  void closeLater();
  /// Closes the overlay with a result value.
  ///
  /// Parameters:
  /// - [value] (X?): Optional result to return
  ///
  /// Returns a [Future] that completes when closed.
  Future<void> closeWithResult<X>([X? value]);
  /// Updates the anchor context for positioning.
  set anchorContext(BuildContext value);
  /// Updates the overlay alignment.
  set alignment(AlignmentGeometry value);
  /// Updates the anchor alignment.
  set anchorAlignment(AlignmentGeometry value);
  /// Updates the width constraint.
  set widthConstraint(PopoverConstraint value);
  /// Updates the height constraint.
  set heightConstraint(PopoverConstraint value);
  /// Updates the margin.
  set margin(EdgeInsets value);
  /// Updates whether the overlay follows the anchor.
  set follow(bool value);
  /// Updates the position offset.
  set offset(Offset? value);
  /// Updates horizontal inversion permission.
  set allowInvertHorizontal(bool value);
  /// Updates vertical inversion permission.
  set allowInvertVertical(bool value);
}
```
