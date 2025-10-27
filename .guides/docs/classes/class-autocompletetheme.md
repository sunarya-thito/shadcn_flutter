---
title: "Class: AutoCompleteTheme"
description: "Theme configuration for [AutoComplete] widget styling and behavior."
---

```dart
/// Theme configuration for [AutoComplete] widget styling and behavior.
///
/// Defines the visual appearance and positioning of the autocomplete popover
/// that displays suggestions. All properties are optional and will fall back
/// to sensible defaults when not specified.
///
/// This theme can be applied globally through [ComponentTheme] or passed
/// directly to individual [AutoComplete] widgets for per-instance customization.
class AutoCompleteTheme {
  /// Constraints applied to the autocomplete popover container.
  ///
  /// Controls the maximum/minimum dimensions of the suggestion list popover.
  /// Defaults to a maximum height of 300 logical pixels when null.
  final BoxConstraints? popoverConstraints;
  /// Width constraint strategy for the autocomplete popover.
  ///
  /// Determines how the popover width relates to its anchor (the text field).
  /// Options include matching anchor width, flexible sizing, or fixed dimensions.
  final PopoverConstraint? popoverWidthConstraint;
  /// Alignment point on the anchor widget where the popover attaches.
  ///
  /// Specifies which edge/corner of the text field the popover should align to.
  /// Defaults to bottom-start (bottom-left in LTR, bottom-right in RTL).
  final AlignmentDirectional? popoverAnchorAlignment;
  /// Alignment point on the popover that aligns with the anchor point.
  ///
  /// Specifies which edge/corner of the popover aligns with the anchor alignment.
  /// Defaults to top-start (top-left in LTR, top-right in RTL).
  final AlignmentDirectional? popoverAlignment;
  /// Default mode for how suggestions are applied to text fields.
  ///
  /// Controls the text replacement strategy when a suggestion is selected.
  /// Defaults to [AutoCompleteMode.replaceWord] when null.
  final AutoCompleteMode? mode;
  /// Creates an [AutoCompleteTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  const AutoCompleteTheme({this.popoverConstraints, this.popoverWidthConstraint, this.popoverAnchorAlignment, this.popoverAlignment, this.mode});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  AutoCompleteTheme copyWith({ValueGetter<BoxConstraints?>? popoverConstraints, ValueGetter<PopoverConstraint?>? popoverWidthConstraint, ValueGetter<AlignmentDirectional?>? popoverAnchorAlignment, ValueGetter<AlignmentDirectional?>? popoverAlignment, ValueGetter<AutoCompleteMode?>? mode});
  bool operator ==(Object other);
  int get hashCode;
}
```
