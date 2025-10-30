---
title: "Class: AutoComplete"
description: "Intelligent autocomplete functionality with customizable suggestion handling."
---

```dart
/// Intelligent autocomplete functionality with customizable suggestion handling.
///
/// Provides real-time autocomplete suggestions in a popover overlay when used
/// with text input widgets. Supports multiple text replacement modes, keyboard
/// navigation, and theming customization. The widget wraps a child (typically
/// a text field) and displays filtered suggestions based on user input.
///
/// ## Features
///
/// - **Multiple completion modes**: append, replace word, or replace all text
/// - **Keyboard navigation**: arrow keys to navigate, tab/enter to accept
/// - **Customizable presentation**: popover positioning, sizing, and constraints
/// - **Smart suggestion filtering**: automatically manages suggestion visibility
/// - **Accessibility support**: proper focus management and keyboard shortcuts
///
/// The autocomplete behavior is controlled by the [mode] property and can be
/// customized per-instance or globally through [AutoCompleteTheme].
///
/// Example:
/// ```dart
/// AutoComplete(
///   suggestions: ['apple', 'apricot', 'banana', 'cherry'],
///   mode: AutoCompleteMode.replaceWord,
///   child: TextField(
///     decoration: InputDecoration(
///       hintText: 'Type to search fruits...',
///     ),
///   ),
/// )
/// ```
class AutoComplete extends StatefulWidget {
  /// List of suggestions to display in the autocomplete popover.
  ///
  /// When non-empty, triggers the popover to appear with selectable options.
  /// The suggestions are filtered and managed externally - this widget only
  /// handles the presentation and selection logic.
  final List<String> suggestions;
  /// The child widget that receives autocomplete functionality.
  ///
  /// Typically a [TextField] or similar text input widget. The autocomplete
  /// popover will be positioned relative to this widget, and keyboard actions
  /// will be applied to the focused text field within this child tree.
  final Widget child;
  /// Constraints applied to the autocomplete popover container.
  ///
  /// Overrides the theme default. Controls maximum/minimum dimensions of the
  /// suggestion list. When null, uses theme value or framework default.
  final BoxConstraints? popoverConstraints;
  /// Width constraint strategy for the autocomplete popover.
  ///
  /// Overrides the theme default. Determines how popover width relates to
  /// the anchor widget. When null, uses theme value or matches anchor width.
  final PopoverConstraint? popoverWidthConstraint;
  /// Alignment point on the anchor widget for popover attachment.
  ///
  /// Overrides the theme default. Specifies which edge/corner of the child
  /// widget the popover aligns to. When null, uses theme or bottom-start.
  final AlignmentDirectional? popoverAnchorAlignment;
  /// Alignment point on the popover for anchor attachment.
  ///
  /// Overrides the theme default. Specifies which edge/corner of the popover
  /// aligns with the anchor point. When null, uses theme or top-start.
  final AlignmentDirectional? popoverAlignment;
  /// Text replacement strategy when a suggestion is selected.
  ///
  /// Overrides the theme default. Controls how selected suggestions modify
  /// the text field content. When null, uses theme or [AutoCompleteMode.replaceWord].
  final AutoCompleteMode? mode;
  /// Function to customize suggestion text before application.
  ///
  /// Called when a suggestion is selected, allowing modification of the final
  /// text inserted into the field. Useful for adding prefixes, suffixes, or
  /// formatting. Defaults to returning the suggestion unchanged.
  final AutoCompleteCompleter completer;
  /// Creates an [AutoComplete] widget.
  ///
  /// Wraps the provided [child] with autocomplete functionality using the
  /// given [suggestions] list. The popover appearance and behavior can be
  /// customized through the optional positioning and constraint parameters.
  ///
  /// Parameters:
  /// - [suggestions] (`List<String>`, required): available autocomplete options
  /// - [child] (Widget, required): widget to receive autocomplete functionality
  /// - [popoverConstraints] (BoxConstraints?, optional): popover size limits
  /// - [popoverWidthConstraint] (PopoverConstraint?, optional): width strategy
  /// - [popoverAnchorAlignment] (AlignmentDirectional?, optional): anchor point
  /// - [popoverAlignment] (AlignmentDirectional?, optional): popover align point
  /// - [mode] (AutoCompleteMode?, optional): text replacement strategy
  /// - [completer] (AutoCompleteCompleter, default: identity): suggestion processor
  ///
  /// Example:
  /// ```dart
  /// AutoComplete(
  ///   suggestions: suggestions,
  ///   mode: AutoCompleteMode.append,
  ///   completer: (text) => '$text ',
  ///   child: TextField(),
  /// )
  /// ```
  const AutoComplete({super.key, required this.suggestions, required this.child, this.popoverConstraints, this.popoverWidthConstraint, this.popoverAnchorAlignment, this.popoverAlignment, this.mode, this.completer = _defaultCompleter});
  State<AutoComplete> createState();
}
```
