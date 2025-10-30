---
title: "Class: AbstractNavigationButton"
description: "Abstract base class for navigation button widgets."
---

```dart
/// Abstract base class for navigation button widgets.
///
/// Provides common properties and behavior for navigation items and buttons.
/// Subclasses include [NavigationItem] and [NavigationButton].
///
/// Handles layout, labels, styling, and integration with navigation containers.
abstract class AbstractNavigationButton extends StatefulWidget implements NavigationBarItem {
  /// Main content widget (typically an icon).
  final Widget child;
  /// Optional label text widget.
  final Widget? label;
  /// Spacing between icon and label.
  final double? spacing;
  /// Custom button style.
  final AbstractButtonStyle? style;
  /// Content alignment within the button.
  final AlignmentGeometry? alignment;
  /// Whether the button is enabled for interaction.
  final bool? enabled;
  /// How to handle label overflow.
  final NavigationOverflow overflow;
  /// Alignment for margins.
  final AlignmentGeometry? marginAlignment;
  /// Creates an abstract navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content (icon)
  /// - [spacing] (double?): Icon-label spacing
  /// - [label] (Widget?): Label widget
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Enabled state
  /// - [overflow] (NavigationOverflow): Overflow behavior, defaults to marquee
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const AbstractNavigationButton({super.key, this.spacing, this.label, this.style, this.alignment, this.enabled, this.overflow = NavigationOverflow.marquee, this.marginAlignment, required this.child});
  State<AbstractNavigationButton> createState();
}
```
