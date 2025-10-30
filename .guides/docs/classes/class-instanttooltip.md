---
title: "Class: InstantTooltip"
description: "A tooltip that shows immediately on hover without delay."
---

```dart
/// A tooltip that shows immediately on hover without delay.
///
/// Unlike [Tooltip], this widget displays the tooltip instantly when the
/// mouse enters the child widget area. It's useful for situations where
/// immediate feedback is desired, such as toolbar buttons or icon-only
/// controls where labels need to be visible right away.
///
/// The tooltip automatically closes when the mouse leaves the widget.
class InstantTooltip extends StatefulWidget {
  /// The widget that triggers the tooltip on hover.
  final Widget child;
  /// How to behave during hit testing.
  final HitTestBehavior behavior;
  /// Builder function for the tooltip content.
  final WidgetBuilder tooltipBuilder;
  /// Alignment of the tooltip relative to the anchor.
  final AlignmentGeometry tooltipAlignment;
  /// Alignment point on the child widget where tooltip anchors.
  final AlignmentGeometry? tooltipAnchorAlignment;
  /// Creates an [InstantTooltip].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget that triggers the tooltip.
  /// - [tooltipBuilder] (`WidgetBuilder`, required): Builder for tooltip content.
  /// - [behavior] (`HitTestBehavior`, default: `HitTestBehavior.translucent`): Hit test behavior.
  /// - [tooltipAlignment] (`AlignmentGeometry`, default: `Alignment.bottomCenter`): Tooltip position.
  /// - [tooltipAnchorAlignment] (`AlignmentGeometry?`, optional): Anchor point on child.
  ///
  /// Example:
  /// ```dart
  /// InstantTooltip(
  ///   tooltipBuilder: (context) => Text('Help text'),
  ///   child: Icon(Icons.help),
  /// )
  /// ```
  const InstantTooltip({super.key, required this.child, required this.tooltipBuilder, this.behavior = HitTestBehavior.translucent, this.tooltipAlignment = Alignment.bottomCenter, this.tooltipAnchorAlignment});
  State<InstantTooltip> createState();
}
```
