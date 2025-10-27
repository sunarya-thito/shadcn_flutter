---
title: "Class: CollapsibleTrigger"
description: "A trigger widget that controls the expansion state of its parent [Collapsible]."
---

```dart
/// A trigger widget that controls the expansion state of its parent [Collapsible].
///
/// [CollapsibleTrigger] provides a consistent interface for toggling collapsible
/// content. It automatically displays the appropriate expand/collapse icon and
/// handles user interaction to trigger state changes.
///
/// ## Features
/// - **Automatic Icons**: Shows different icons for expanded/collapsed states
/// - **Integrated Button**: Uses [GhostButton] for consistent interaction styling
/// - **Responsive Layout**: Automatically sizes and spaces content and icon
/// - **Theme Integration**: Respects [CollapsibleTheme] configuration
///
/// The trigger must be used as a direct child of a [Collapsible] widget to
/// function properly, as it relies on inherited state data.
///
/// Example:
/// ```dart
/// CollapsibleTrigger(
///   child: Row(
///     children: [
///       Icon(Icons.folder),
///       SizedBox(width: 8),
///       Text('Project Files'),
///       Spacer(),
///       Badge(child: Text('12')),
///     ],
///   ),
/// );
/// ```
class CollapsibleTrigger extends StatelessWidget {
  /// The content widget to display within the trigger.
  ///
  /// Typically contains text, icons, or other UI elements that describe what
  /// will be expanded or collapsed. The child is automatically styled and
  /// positioned alongside the expand/collapse icon.
  final Widget child;
  /// Creates a [CollapsibleTrigger] with the specified child content.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The content to display in the trigger.
  ///
  /// The trigger automatically provides:
  /// - Expand/collapse icon based on current state
  /// - Click handling to toggle the parent collapsible
  /// - Proper spacing and layout with theme-aware styling
  /// - Integration with parent [Collapsible] state
  ///
  /// Example:
  /// ```dart
  /// CollapsibleTrigger(
  ///   child: Text('Click to toggle content'),
  /// );
  /// ```
  const CollapsibleTrigger({super.key, required this.child});
  Widget build(BuildContext context);
}
```
