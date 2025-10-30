---
title: "Class: InputAutoCompleteFeature"
description: "Adds autocomplete functionality to the input field."
---

```dart
/// Adds autocomplete functionality to the input field.
///
/// Displays a popover with suggestions as the user types. Suggestions are
/// provided by the [querySuggestions] callback and can be selected to fill
/// the input.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputAutoCompleteFeature(
///       querySuggestions: (query) async {
///         return ['apple', 'apricot', 'avocado']
///             .where((s) => s.startsWith(query));
///       },
///       child: const Text('Fruits'),
///     ),
///   ],
/// )
/// ```
class InputAutoCompleteFeature extends InputFeature {
  /// Callback to provide suggestions for a given query.
  final SuggestionBuilder querySuggestions;
  /// Child widget displayed in the suggestion list.
  final Widget child;
  /// Constraints for the popover size.
  final BoxConstraints? popoverConstraints;
  /// Width constraint for the popover.
  final PopoverConstraint? popoverWidthConstraint;
  /// Anchor alignment for the popover.
  final AlignmentDirectional? popoverAnchorAlignment;
  /// Popover alignment relative to the anchor.
  final AlignmentDirectional? popoverAlignment;
  /// Autocomplete mode (e.g., popover or inline).
  final AutoCompleteMode mode;
  /// Creates an [InputAutoCompleteFeature].
  ///
  /// Parameters:
  /// - [querySuggestions] (`SuggestionBuilder`, required): Provides suggestions.
  /// - [child] (`Widget`, required): Content for suggestion items.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints.
  /// - [popoverWidthConstraint] (`PopoverConstraint?`, optional): Width constraint.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): Popover alignment.
  /// - [mode] (`AutoCompleteMode`, required): Autocomplete display mode.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAutoCompleteFeature({super.visibility, super.skipFocusTraversal, required this.querySuggestions, required this.child, this.popoverConstraints, this.popoverWidthConstraint, this.popoverAnchorAlignment, this.popoverAlignment, this.mode = AutoCompleteMode.replaceWord});
  InputFeatureState createState();
}
```
