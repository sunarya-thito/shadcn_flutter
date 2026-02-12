---
title: "Class: NavigationGroup"
description: "Multi-purpose navigation group that organizes children with a label.   Replaces the standalone `NavigationLabel`. In sidebars, it organizes  items into a scrollable group using `SliverMainAxisGroup`, optionally  with a floating or pinned label header."
---

```dart
/// Multi-purpose navigation group that organizes children with a label.
///
/// Replaces the standalone `NavigationLabel`. In sidebars, it organizes
/// items into a scrollable group using `SliverMainAxisGroup`, optionally
/// with a floating or pinned label header.
class NavigationGroup extends StatelessWidget {
  /// Label widget to display for the group.
  final Widget label;
  /// The child items within this group.
  final List<Widget> children;
  /// Position of the label relative to the children.
  final NavigationLabelPosition labelPosition;
  /// Alignment of the label content.
  final AlignmentGeometry? labelAlignment;
  /// Padding around the label.
  final EdgeInsetsGeometry? labelPadding;
  /// How to handle label text overflow.
  final NavigationOverflow labelOverflow;
  /// Whether the label floats when scrolling (sidebar only).
  final bool labelFloating;
  /// Whether the label is pinned when scrolling (sidebar only).
  final bool labelPinned;
  /// Creates a new navigation group.
  const NavigationGroup({super.key, required this.label, this.children = const [], this.labelPosition = NavigationLabelPosition.top, this.labelAlignment, this.labelPadding, this.labelOverflow = NavigationOverflow.clip, this.labelFloating = false, this.labelPinned = true});
  Widget build(BuildContext context);
  /// Builds the label content with appropriate styles and expansion handling.
  Widget buildLabelChild(BuildContext context, NavigationControlData? data);
  /// Builds a SliverPersistentHeader for the label and a SliverMainAxisGroup for the children.
  Widget buildSliverLabelChild(BuildContext context, NavigationControlData? data);
  /// Builds a column with the label and children. (Non-sidebar context)
  Widget buildBox(BuildContext context, NavigationControlData? data);
  /// Builds a SliverMainAxisGroup containing the label and children. (Sidebar/Sliver context)
  Widget buildSliver(BuildContext context, NavigationControlData? data);
}
```
