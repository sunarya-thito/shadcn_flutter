---
title: "Class: NavigationCollapsible"
description: "A navigation item that can expand to reveal nested navigation items.   Provides a labeled header row that toggles visibility of sub-items. Intended  for hierarchical navigation structures, especially in vertical sidebars or  rails."
---

```dart
/// A navigation item that can expand to reveal nested navigation items.
///
/// Provides a labeled header row that toggles visibility of sub-items. Intended
/// for hierarchical navigation structures, especially in vertical sidebars or
/// rails.
class NavigationCollapsible extends StatefulWidget {
  /// Optional leading widget for the group header.
  final Widget? leading;
  /// Label widget for the group header.
  final Widget label;
  /// The nested navigation items for this group.
  final List<Widget> children;
  /// Whether the group is expanded (controlled mode).
  final bool? expanded;
  /// Initial expanded state when uncontrolled.
  final bool initialExpanded;
  /// Callback when expansion state changes.
  final ValueChanged<bool>? onExpandedChanged;
  /// Custom style when the group header is selected.
  final AbstractButtonStyle? selectedStyle;
  /// Whether the group header is currently selected.
  final bool? selected;
  /// Callback when header selection changes.
  final ValueChanged<bool>? onChanged;
  /// Optional button style for the header.
  final AbstractButtonStyle? style;
  /// Optional custom trailing widget for the expand indicator.
  final Widget? trailing;
  /// Indentation applied to nested items.
  final double? childIndent;
  /// Branch line style for connecting group items.
  final BranchLine? branchLine;
  /// Spacing between leading widget and label.
  final double? spacing;
  /// Content alignment within the header button.
  final AlignmentGeometry? alignment;
  /// Whether the header is enabled for interaction.
  final bool? enabled;
  /// How to handle label overflow.
  final NavigationOverflow overflow;
  /// Creates a [NavigationCollapsible].
  const NavigationCollapsible({super.key, this.leading, required this.label, required this.children, this.expanded, this.initialExpanded = false, this.onExpandedChanged, this.selectedStyle, this.selected, this.onChanged, this.style, this.trailing, this.childIndent, this.branchLine, this.spacing, this.alignment, this.enabled, this.overflow = NavigationOverflow.marquee});
  State<NavigationCollapsible> createState();
}
```
