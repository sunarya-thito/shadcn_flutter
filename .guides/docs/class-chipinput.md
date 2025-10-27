---
title: "Class: ChipInput"
description: "Reference for ChipInput"
---

```dart
class ChipInput<T> extends TextInputStatefulWidget {
  static bool isChipUnicode(int codeUnit);
  static bool isChipCharacter(String character);
  final ChipWidgetBuilder<T> chipBuilder;
  final ChipSubmissionCallback<T> onChipSubmitted;
  final ValueChanged<List<T>>? onChipsChanged;
  final bool? useChips;
  final List<T>? initialChips;
  final bool autoInsertSuggestion;
  const ChipInput({super.key, super.groupId, ChipEditingController<T>? super.controller, super.focusNode, super.decoration, super.padding, super.placeholder, super.crossAxisAlignment, super.clearButtonSemanticLabel, super.keyboardType, super.textInputAction, super.textCapitalization, super.style, super.strutStyle, super.textAlign, super.textAlignVertical, super.textDirection, super.readOnly, super.showCursor, super.autofocus, super.obscuringCharacter, super.obscureText, super.autocorrect, super.smartDashesType, super.smartQuotesType, super.enableSuggestions, super.maxLines, super.minLines, super.expands, super.maxLength, super.maxLengthEnforcement, super.onChanged, super.onEditingComplete, super.onSubmitted, super.onTapOutside, super.onTapUpOutside, super.inputFormatters, super.enabled, super.cursorWidth, super.cursorHeight, super.cursorRadius, super.cursorOpacityAnimates, super.cursorColor, super.selectionHeightStyle, super.selectionWidthStyle, super.keyboardAppearance, super.scrollPadding, super.enableInteractiveSelection, super.selectionControls, super.dragStartBehavior, super.scrollController, super.scrollPhysics, super.onTap, super.autofillHints, super.clipBehavior, super.restorationId, super.stylusHandwritingEnabled, super.enableIMEPersonalizedLearning, super.contentInsertionConfiguration, super.contextMenuBuilder, super.initialValue, super.hintText, super.border, super.borderRadius, super.filled, super.statesController, super.magnifierConfiguration, super.spellCheckConfiguration, super.undoController, super.features, super.submitFormatters, super.skipInputFeatureFocusTraversal, required this.chipBuilder, required this.onChipSubmitted, this.autoInsertSuggestion = true, this.onChipsChanged, this.useChips, this.initialChips});
  ChipEditingController<T>? get controller;
  State<ChipInput<T>> createState();
}
```
