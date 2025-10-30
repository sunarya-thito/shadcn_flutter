---
title: "Class: ChipInput"
description: "A text input widget that supports inline chip elements."
---

```dart
/// A text input widget that supports inline chip elements.
///
/// Allows users to create chip tokens within a text field, useful for
/// tags, email recipients, or any multi-item input scenario.
class ChipInput<T> extends TextInputStatefulWidget {
  /// Checks if a code unit represents a chip character.
  static bool isChipUnicode(int codeUnit);
  /// Checks if a string character is a chip character.
  static bool isChipCharacter(String character);
  /// Builder function for creating chip widgets.
  final ChipWidgetBuilder<T> chipBuilder;
  /// Callback to convert text into a chip object.
  final ChipSubmissionCallback<T> onChipSubmitted;
  /// Callback invoked when the list of chips changes.
  final ValueChanged<List<T>>? onChipsChanged;
  /// Whether to display items as visual chips (defaults to theme setting).
  final bool? useChips;
  /// Initial chips to display in the input.
  final List<T>? initialChips;
  /// Whether to automatically insert autocomplete suggestions as chips.
  final bool autoInsertSuggestion;
  /// Creates a chip input widget.
  const ChipInput({super.key, super.groupId, ChipEditingController<T>? super.controller, super.focusNode, super.decoration, super.padding, super.placeholder, super.crossAxisAlignment, super.clearButtonSemanticLabel, super.keyboardType, super.textInputAction, super.textCapitalization, super.style, super.strutStyle, super.textAlign, super.textAlignVertical, super.textDirection, super.readOnly, super.showCursor, super.autofocus, super.obscuringCharacter, super.obscureText, super.autocorrect, super.smartDashesType, super.smartQuotesType, super.enableSuggestions, super.maxLines, super.minLines, super.expands, super.maxLength, super.maxLengthEnforcement, super.onChanged, super.onEditingComplete, super.onSubmitted, super.onTapOutside, super.onTapUpOutside, super.inputFormatters, super.enabled, super.cursorWidth, super.cursorHeight, super.cursorRadius, super.cursorOpacityAnimates, super.cursorColor, super.selectionHeightStyle, super.selectionWidthStyle, super.keyboardAppearance, super.scrollPadding, super.enableInteractiveSelection, super.selectionControls, super.dragStartBehavior, super.scrollController, super.scrollPhysics, super.onTap, super.autofillHints, super.clipBehavior, super.restorationId, super.stylusHandwritingEnabled, super.enableIMEPersonalizedLearning, super.contentInsertionConfiguration, super.contextMenuBuilder, super.initialValue, super.hintText, super.border, super.borderRadius, super.filled, super.statesController, super.magnifierConfiguration, super.spellCheckConfiguration, super.undoController, super.features, super.submitFormatters, super.skipInputFeatureFocusTraversal, required this.chipBuilder, required this.onChipSubmitted, this.autoInsertSuggestion = true, this.onChipsChanged, this.useChips, this.initialChips});
  ChipEditingController<T>? get controller;
  State<ChipInput<T>> createState();
}
```
