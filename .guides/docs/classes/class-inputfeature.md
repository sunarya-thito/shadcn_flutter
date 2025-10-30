---
title: "Class: InputFeature"
description: "Abstract factory for creating input field feature components."
---

```dart
/// Abstract factory for creating input field feature components.
///
/// Provides factory constructors for common text field features like password
/// toggles, clear buttons, hints, autocomplete, and spinners. Features can be
/// conditionally shown based on field state using [InputFeatureVisibility].
///
/// Example:
/// ```dart
/// TextField(
///   leading: [
///     InputFeature.hint(
///       popupBuilder: (context) => Text('Enter email'),
///     ),
///   ],
///   trailing: [
///     InputFeature.clear(),
///     InputFeature.passwordToggle(),
///   ],
/// )
/// ```
abstract class InputFeature {
  /// Creates a hint/tooltip feature for the input field.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show hint.
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint popup content.
  /// - [icon] (`Widget?`, optional): Icon to display for the hint trigger.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place the hint.
  /// - [enableShortcuts] (`bool`, default: true): Enable keyboard shortcuts.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.hint({InputFeatureVisibility visibility, required WidgetBuilder popupBuilder, Widget? icon, InputFeaturePosition position, bool enableShortcuts, bool skipFocusTraversal});
  /// Creates a password visibility toggle feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show toggle.
  /// - [mode] (`PasswordPeekMode`, default: toggle): Toggle or peek mode.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place toggle.
  /// - [icon] (`Widget?`, optional): Icon when password is hidden.
  /// - [iconShow] (`Widget?`, optional): Icon when password is visible.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.passwordToggle({InputFeatureVisibility visibility, PasswordPeekMode mode, InputFeaturePosition position, Widget? icon, Widget? iconShow, bool skipFocusTraversal});
  /// Creates a clear text button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show clear button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom clear icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.clear({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  /// Creates a revalidate button feature.
  ///
  /// Triggers form validation when clicked.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom revalidate icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.revalidate({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  /// Creates an autocomplete feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: focused): When to show autocomplete.
  /// - [querySuggestions] (`SuggestionBuilder`, required): Builds suggestion list.
  /// - [child] (`Widget`, required): Child widget in the autocomplete popup.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints for popup.
  /// - [popoverWidthConstraint] (`PopoverConstraint?`, optional): Width constraint mode.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): Popup alignment.
  /// - [mode] (`AutoCompleteMode`, default: popup): Display mode.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.autoComplete({InputFeatureVisibility visibility, required SuggestionBuilder querySuggestions, required Widget child, BoxConstraints? popoverConstraints, PopoverConstraint? popoverWidthConstraint, AlignmentDirectional? popoverAnchorAlignment, AlignmentDirectional? popoverAlignment, AutoCompleteMode mode, bool skipFocusTraversal});
  /// Creates a numeric spinner feature for incrementing/decrementing values.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show spinner.
  /// - [step] (`double`, default: 1): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: true): Enable drag gestures.
  /// - [invalidValue] (`double?`, optional): Value to use when input is invalid.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.spinner({InputFeatureVisibility visibility, double step, bool enableGesture, double? invalidValue, bool skipFocusTraversal});
  /// Creates a copy to clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show copy button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom copy icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.copy({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  /// Creates a paste from clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show paste button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom paste icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.paste({InputFeatureVisibility visibility, InputFeaturePosition position, Widget? icon, bool skipFocusTraversal});
  /// Creates a custom leading widget feature.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to display.
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show widget.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  factory InputFeature.leading(Widget child, {InputFeatureVisibility visibility, bool skipFocusTraversal});
  /// Creates a custom trailing widget feature.
  factory InputFeature.trailing(Widget child, {InputFeatureVisibility visibility, bool skipFocusTraversal});
  /// Visibility mode for this input feature.
  final InputFeatureVisibility visibility;
  /// Whether to skip this feature in focus traversal.
  final bool skipFocusTraversal;
  /// Creates an input feature.
  const InputFeature({this.visibility = InputFeatureVisibility.always, this.skipFocusTraversal = true});
  /// Creates the state for this input feature.
  InputFeatureState createState();
  /// Checks if an old feature can be updated to a new feature.
  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature);
}
```
