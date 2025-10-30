---
title: "Class: Scrollbar"
description: "A customizable scrollbar widget for shadcn_flutter."
---

```dart
/// A customizable scrollbar widget for shadcn_flutter.
///
/// [Scrollbar] provides a themeable scrollbar that can be attached to any
/// scrollable widget. It supports both vertical and horizontal orientations,
/// configurable appearance, and interactive dragging.
///
/// Example:
/// ```dart
/// Scrollbar(
///   controller: scrollController,
///   thumbVisibility: true,
///   thickness: 8,
///   child: ListView.builder(
///     controller: scrollController,
///     itemCount: 100,
///     itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///   ),
/// )
/// ```
class Scrollbar extends StatelessWidget {
  /// Creates a [Scrollbar] widget.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The scrollable widget to attach the scrollbar to
  /// - [controller] (ScrollController?, optional): Controller for the scrollable content
  /// - [thumbVisibility] (bool?, optional): Whether the scrollbar thumb is always visible
  /// - [trackVisibility] (bool?, optional): Whether the scrollbar track is always visible
  /// - [thickness] (double?, optional): Thickness of the scrollbar
  /// - [radius] (Radius?, optional): Border radius for the scrollbar thumb
  /// - [color] (Color?, optional): Color of the scrollbar thumb
  /// - [interactive] (bool?, optional): Whether the scrollbar can be dragged
  /// - [notificationPredicate] (ScrollNotificationPredicate?, optional): Predicate for scroll notifications
  /// - [scrollbarOrientation] (ScrollbarOrientation?, optional): Orientation of the scrollbar
  const Scrollbar({super.key, required this.child, this.controller, this.thumbVisibility, this.trackVisibility, this.thickness, this.radius, this.color, this.notificationPredicate, this.interactive, this.scrollbarOrientation});
  /// The scrollable widget to attach the scrollbar to.
  final Widget child;
  /// Optional scroll controller for the scrollable content.
  ///
  /// If not provided, the scrollbar will use the nearest [Scrollable]'s controller.
  final ScrollController? controller;
  /// Whether the scrollbar thumb is always visible.
  ///
  /// When `true`, the thumb remains visible even when not scrolling.
  /// When `false` or `null`, the thumb fades out after scrolling stops.
  final bool? thumbVisibility;
  /// Whether the scrollbar track is always visible.
  ///
  /// When `true`, the track (background) remains visible.
  /// When `false` or `null`, only the thumb is shown.
  final bool? trackVisibility;
  /// The thickness of the scrollbar in logical pixels.
  final double? thickness;
  /// The border radius of the scrollbar thumb.
  final Radius? radius;
  /// The color of the scrollbar thumb.
  final Color? color;
  /// Whether the scrollbar can be dragged to scroll.
  ///
  /// When `true`, users can click and drag the scrollbar thumb to scroll.
  final bool? interactive;
  /// Predicate to determine which scroll notifications trigger scrollbar updates.
  final ScrollNotificationPredicate? notificationPredicate;
  /// The orientation of the scrollbar (vertical or horizontal).
  final ScrollbarOrientation? scrollbarOrientation;
  Widget build(BuildContext context);
}
```
