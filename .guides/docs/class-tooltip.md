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
  final Widget child;
  final WidgetBuilder tooltip;
  final AlignmentGeometry alignment;
  final AlignmentGeometry anchorAlignment;
  final Duration waitDuration;
  final Duration showDuration;
  final Duration minDuration;
  const Tooltip({super.key, required this.child, required this.tooltip, this.alignment = Alignment.topCenter, this.anchorAlignment = Alignment.bottomCenter, this.waitDuration = const Duration(milliseconds: 500), this.showDuration = const Duration(milliseconds: 200), this.minDuration = const Duration(milliseconds: 0)});
  State<Tooltip> createState();
}
```
