---
title: "Class: NavigationLabel"
description: "Non-interactive label widget for navigation sections."
---

```dart
/// Non-interactive label widget for navigation sections.
///
/// Displays text headers or section labels within navigation bars or sidebars.
/// Supports different overflow behaviors and can be configured as floating or
/// pinned when used in sidebars.
///
/// Example:
/// ```dart
/// NavigationLabel(
///   child: Text('Main Menu').semiBold(),
///   padding: EdgeInsets.all(8),
/// )
/// ```
class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  /// Content widget to display as the label.
  final Widget child;
  /// Alignment of the label content.
  final AlignmentGeometry? alignment;
  /// Padding around the label.
  final EdgeInsetsGeometry? padding;
  /// How to handle text overflow.
  final NavigationOverflow overflow;
  /// Whether the label floats when scrolling (sidebar only).
  final bool floating;
  /// Whether the label is pinned when scrolling (sidebar only).
  final bool pinned;
  /// Creates a navigation label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Label content
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [floating] (bool): Floating behavior, defaults to false
  /// - [pinned] (bool): Pinned behavior, defaults to false
  /// - [overflow] (NavigationOverflow): Overflow handling, defaults to clip
  /// - [padding] (EdgeInsetsGeometry?): Label padding
  const NavigationLabel({super.key, this.alignment, this.floating = false, this.pinned = false, this.overflow = NavigationOverflow.clip, this.padding, required this.child});
  bool get selectable;
  Widget build(BuildContext context);
  /// Builds the child widget with visibility and overflow handling.
  ///
  /// Wraps the child with [Hidden] widget that responds to expansion state
  /// and applies overflow handling based on the overflow property.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns the wrapped child widget.
  Widget buildChild(BuildContext context, NavigationControlData? data);
  /// Builds the label for box-based navigation containers.
  ///
  /// Creates a centered, padded container with the label text.
  /// Appropriate for use in navigation bars and rails.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns widget for box-based navigation.
  Widget buildBox(BuildContext context, NavigationControlData? data);
  /// Builds the label for sliver-based navigation containers (sidebars).
  ///
  /// Creates a persistent header that can be configured as floating or pinned.
  /// Animates based on expansion state and supports scrolling behaviors.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [data] (NavigationControlData?): Navigation control data
  ///
  /// Returns sliver widget for sidebar navigation.
  Widget buildSliver(BuildContext context, NavigationControlData? data);
}
```
