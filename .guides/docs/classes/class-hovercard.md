---
title: "Class: HoverCard"
description: "A widget that displays a popover when hovered or long-pressed."
---

```dart
/// A widget that displays a popover when hovered or long-pressed.
///
/// Shows contextual information or actions when the user hovers over the
/// child widget or performs a long press. Includes intelligent timing
/// controls to prevent flickering and provides smooth user interactions.
///
/// Features:
/// - Hover-based popover display with timing controls
/// - Long-press support for touch devices
/// - Configurable positioning and alignment
/// - Debounce timing to prevent flicker
/// - Custom overlay handlers support
/// - Theme integration
///
/// The hover card automatically manages show/hide timing based on mouse
/// enter/exit events, with configurable delays to provide a smooth UX.
///
/// Example:
/// ```dart
/// HoverCard(
///   hoverBuilder: (context) => Card(
///     child: Padding(
///       padding: EdgeInsets.all(12),
///       child: Text('Additional info appears on hover'),
///     ),
///   ),
///   child: Icon(Icons.help_outline),
/// )
/// ```
class HoverCard extends StatefulWidget {
  /// The child widget that triggers the hover card.
  final Widget child;
  /// Duration to wait before hiding after mouse exit.
  final Duration? debounce;
  /// Duration to wait before showing after mouse enter.
  final Duration? wait;
  /// Builder function that creates the hover card content.
  final WidgetBuilder hoverBuilder;
  /// Alignment of the popover relative to its anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment point on the anchor widget.
  final AlignmentGeometry? anchorAlignment;
  /// Offset of the popover from its calculated position.
  final Offset? popoverOffset;
  /// Hit test behavior for mouse interactions.
  final HitTestBehavior? behavior;
  /// Controller to programmatically manage the popover.
  final PopoverController? controller;
  /// Custom overlay handler for popover display.
  final OverlayHandler? handler;
  /// Creates a [HoverCard].
  ///
  /// The [child] and [hoverBuilder] parameters are required.
  ///
  /// Parameters:
  /// - [child] (Widget, required): widget that triggers the hover card
  /// - [hoverBuilder] (WidgetBuilder, required): builds the hover card content
  /// - [debounce] (Duration?, optional): delay before hiding, defaults to 500ms
  /// - [wait] (Duration?, optional): delay before showing, defaults to 500ms
  /// - [popoverAlignment] (AlignmentGeometry?, optional): popover alignment, defaults to topCenter
  /// - [anchorAlignment] (AlignmentGeometry?, optional): anchor alignment, defaults to bottomCenter
  /// - [popoverOffset] (Offset?, optional): offset from position, defaults to (0, 8)
  /// - [behavior] (HitTestBehavior?, optional): hit test behavior, defaults to deferToChild
  /// - [controller] (PopoverController?, optional): controller for programmatic control
  /// - [handler] (OverlayHandler?, optional): custom overlay handler
  ///
  /// Example:
  /// ```dart
  /// HoverCard(
  ///   debounce: Duration(milliseconds: 300),
  ///   hoverBuilder: (context) => Tooltip(message: 'Help text'),
  ///   child: Icon(Icons.info),
  /// )
  /// ```
  const HoverCard({super.key, required this.child, required this.hoverBuilder, this.debounce, this.wait, this.popoverAlignment, this.anchorAlignment, this.popoverOffset, this.behavior, this.controller, this.handler});
  State<HoverCard> createState();
}
```
