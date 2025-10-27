---
title: "Class: CollapsibleTheme"
description: "Theme configuration for [Collapsible], [CollapsibleTrigger], and [CollapsibleContent] widgets."
---

```dart
/// Theme configuration for [Collapsible], [CollapsibleTrigger], and [CollapsibleContent] widgets.
///
/// [CollapsibleTheme] provides styling options for collapsible components including
/// padding, iconography, and layout alignment. It enables consistent collapsible
/// styling across an application while allowing per-instance customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<CollapsibleTheme>(
///   data: CollapsibleTheme(
///     padding: 12.0,
///     iconExpanded: Icons.keyboard_arrow_up,
///     iconCollapsed: Icons.keyboard_arrow_down,
///     iconGap: 8.0,
///     crossAxisAlignment: CrossAxisAlignment.start,
///   ),
///   child: MyCollapsibleWidget(),
/// );
/// ```
class CollapsibleTheme {
  /// Horizontal padding applied around [CollapsibleTrigger] content.
  ///
  /// Controls the internal spacing within the trigger area. If null,
  /// defaults to 16 logical pixels scaled by theme.
  final double? padding;
  /// Icon displayed in the trigger when the collapsible is expanded.
  ///
  /// If null, defaults to [Icons.unfold_less].
  final IconData? iconExpanded;
  /// Icon displayed in the trigger when the collapsible is collapsed.
  ///
  /// If null, defaults to [Icons.unfold_more].
  final IconData? iconCollapsed;
  /// Cross-axis alignment for children in the [Collapsible] column.
  ///
  /// Controls how children are aligned perpendicular to the main axis.
  /// If null, defaults to [CrossAxisAlignment.stretch].
  final CrossAxisAlignment? crossAxisAlignment;
  /// Main-axis alignment for children in the [Collapsible] column.
  ///
  /// Controls how children are aligned along the main axis.
  /// If null, defaults to [MainAxisAlignment.start].
  final MainAxisAlignment? mainAxisAlignment;
  /// Horizontal spacing between trigger content and expand/collapse icon.
  ///
  /// Controls the gap between the trigger child and the action button.
  /// If null, defaults to 16 logical pixels scaled by theme.
  final double? iconGap;
  /// Creates a [CollapsibleTheme] with the specified styling options.
  ///
  /// All parameters are optional and will fall back to component defaults
  /// when not specified.
  ///
  /// Parameters:
  /// - [padding] (double?, optional): Horizontal padding for trigger content.
  /// - [iconExpanded] (IconData?, optional): Icon shown when expanded.
  /// - [iconCollapsed] (IconData?, optional): Icon shown when collapsed.
  /// - [crossAxisAlignment] (CrossAxisAlignment?, optional): Cross-axis alignment of children.
  /// - [mainAxisAlignment] (MainAxisAlignment?, optional): Main-axis alignment of children.
  /// - [iconGap] (double?, optional): Space between trigger content and icon.
  const CollapsibleTheme({this.padding, this.iconExpanded, this.iconCollapsed, this.crossAxisAlignment, this.mainAxisAlignment, this.iconGap});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   padding: () => 20.0,
  ///   iconGap: () => 12.0,
  /// );
  /// ```
  CollapsibleTheme copyWith({ValueGetter<double?>? padding, ValueGetter<IconData?>? iconExpanded, ValueGetter<IconData?>? iconCollapsed, ValueGetter<CrossAxisAlignment?>? crossAxisAlignment, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<double?>? iconGap});
  bool operator ==(Object other);
  int get hashCode;
}
```
