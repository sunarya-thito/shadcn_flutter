---
title: "Class: Tooltip"
description: "An interactive tooltip widget that displays contextual information on hover."
---

```dart
/// An interactive tooltip widget that displays contextual information on hover.
///
/// [Tooltip] provides contextual help and information by displaying a small overlay
/// when users hover over or interact with the child widget. It supports configurable
/// positioning, timing, and custom content through builder functions, making it
/// ideal for providing additional context without cluttering the interface.
///
/// Key features:
/// - Hover-activated tooltip display with configurable delays
/// - Flexible positioning with alignment and anchor point control
/// - Custom content through builder functions
/// - Duration controls for show/hide timing and minimum display time
/// - Smooth animations and transitions
/// - Integration with the overlay system for proper z-ordering
/// - Theme support for consistent styling
/// - Automatic positioning adjustment to stay within screen bounds
///
/// Timing behavior:
/// - Wait duration: Time to wait before showing tooltip on hover
/// - Show duration: Animation time for tooltip appearance
/// - Min duration: Minimum time tooltip stays visible once shown
/// - Auto-hide: Tooltip disappears when hover ends (after min duration)
///
/// The tooltip uses a popover-based implementation that ensures proper layering
/// and positioning relative to the trigger widget. The positioning system
/// automatically adjusts to keep tooltips within the viewport.
///
/// Example:
/// ```dart
/// Tooltip(
///   tooltip: (context) => TooltipContainer(
///     child: Text('This button performs a critical action'),
///   ),
///   waitDuration: Duration(milliseconds: 800),
///   showDuration: Duration(milliseconds: 150),
///   alignment: Alignment.topCenter,
///   anchorAlignment: Alignment.bottomCenter,
///   child: IconButton(
///     icon: Icon(Icons.warning),
///     onPressed: () => _handleCriticalAction(),
///   ),
/// );
/// ```
class Tooltip extends StatefulWidget {
  /// The widget that triggers the tooltip on hover.
  final Widget child;
  /// Builder function for the tooltip content.
  final WidgetBuilder tooltip;
  /// Alignment of the tooltip relative to the anchor.
  final AlignmentGeometry alignment;
  /// Alignment point on the child widget where tooltip anchors.
  final AlignmentGeometry anchorAlignment;
  /// Time to wait before showing the tooltip on hover.
  final Duration waitDuration;
  /// Duration of the tooltip show animation.
  final Duration showDuration;
  /// Minimum time the tooltip stays visible once shown.
  final Duration minDuration;
  /// Creates a [Tooltip].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers the tooltip.
  /// - [tooltip] (`WidgetBuilder`, required): Builder for tooltip content.
  /// - [alignment] (`AlignmentGeometry`, default: `Alignment.topCenter`): Tooltip position.
  /// - [anchorAlignment] (`AlignmentGeometry`, default: `Alignment.bottomCenter`): Anchor point on child.
  /// - [waitDuration] (`Duration`, default: 500ms): Delay before showing.
  /// - [showDuration] (`Duration`, default: 200ms): Animation duration.
  /// - [minDuration] (`Duration`, default: 0ms): Minimum visible time.
  const Tooltip({super.key, required this.child, required this.tooltip, this.alignment = Alignment.topCenter, this.anchorAlignment = Alignment.bottomCenter, this.waitDuration = const Duration(milliseconds: 500), this.showDuration = const Duration(milliseconds: 200), this.minDuration = const Duration(milliseconds: 0)});
  State<Tooltip> createState();
}
```
