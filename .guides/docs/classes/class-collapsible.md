---
title: "Class: Collapsible"
description: "A container widget that can show or hide its content with a collapsible interface."
---

```dart
/// A container widget that can show or hide its content with a collapsible interface.
///
/// [Collapsible] provides a simple expand/collapse pattern where content can be
/// toggled between visible and hidden states. Unlike [Accordion], multiple
/// collapsible widgets can be expanded simultaneously, making them ideal for
/// independent sections that users might want to view concurrently.
///
/// ## Key Features
/// - **Independent State**: Each collapsible manages its own expansion state
/// - **Flexible Control**: Can be controlled or uncontrolled
/// - **Custom Layout**: Configurable alignment for trigger and content
/// - **Instant Toggle**: Uses visibility toggling rather than animated transitions
/// - **Composable**: Works with [CollapsibleTrigger] and [CollapsibleContent]
///
/// ## Usage Patterns
/// The collapsible can operate in two modes:
/// - **Uncontrolled**: Manages its own state internally
/// - **Controlled**: State managed externally via [onExpansionChanged]
///
/// Example:
/// ```dart
/// Collapsible(
///   isExpanded: false,
///   children: [
///     CollapsibleTrigger(
///       child: Row(
///         children: [
///           Icon(Icons.settings),
///           SizedBox(width: 8),
///           Text('Advanced Settings'),
///         ],
///       ),
///     ),
///     CollapsibleContent(
///       child: Padding(
///         padding: EdgeInsets.all(16),
///         child: Column(
///           children: [
///             CheckboxListTile(title: Text('Option 1'), value: false, onChanged: null),
///             CheckboxListTile(title: Text('Option 2'), value: true, onChanged: null),
///           ],
///         ),
///       ),
///     ),
///   ],
/// );
/// ```
///
/// For more information, visit: https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
class Collapsible extends StatefulWidget {
  /// The child widgets to display in the collapsible container.
  ///
  /// Typically includes a [CollapsibleTrigger] as the first child, followed by
  /// one or more [CollapsibleContent] widgets. The widgets are arranged in
  /// a vertical column with configurable alignment.
  final List<Widget> children;
  /// Initial expansion state when operating in uncontrolled mode.
  ///
  /// If null, defaults to false (collapsed). This value is only used when
  /// [onExpansionChanged] is null, indicating uncontrolled mode.
  final bool? isExpanded;
  /// Callback invoked when the expansion state should change.
  ///
  /// When provided, the collapsible operates in controlled mode and the parent
  /// widget is responsible for managing the expansion state. Called with the
  /// current expansion state when the user triggers a state change.
  final ValueChanged<bool>? onExpansionChanged;
  /// Creates a [Collapsible] widget with the specified children.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): Widgets to display in the collapsible container.
  /// - [isExpanded] (bool?, optional): Initial expansion state for uncontrolled mode.
  /// - [onExpansionChanged] (`ValueChanged<bool>?`, optional): Callback for controlled mode.
  ///
  /// ## Mode Selection
  /// - **Uncontrolled Mode**: When [onExpansionChanged] is null, the widget manages
  ///   its own state using [isExpanded] as the initial value.
  /// - **Controlled Mode**: When [onExpansionChanged] is provided, the parent must
  ///   manage state and update [isExpanded] accordingly.
  ///
  /// Example (Uncontrolled):
  /// ```dart
  /// Collapsible(
  ///   isExpanded: true,
  ///   children: [
  ///     CollapsibleTrigger(child: Text('Toggle Me')),
  ///     CollapsibleContent(child: Text('Hidden content')),
  ///   ],
  /// );
  /// ```
  ///
  /// Example (Controlled):
  /// ```dart
  /// bool _expanded = false;
  /// 
  /// Collapsible(
  ///   isExpanded: _expanded,
  ///   onExpansionChanged: (expanded) => setState(() => _expanded = !_expanded),
  ///   children: [
  ///     CollapsibleTrigger(child: Text('Toggle Me')),
  ///     CollapsibleContent(child: Text('Hidden content')),
  ///   ],
  /// );
  /// ```
  ///
  /// For more information, visit: https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
  const Collapsible({super.key, required this.children, this.isExpanded, this.onExpansionChanged});
  State<Collapsible> createState();
}
```
