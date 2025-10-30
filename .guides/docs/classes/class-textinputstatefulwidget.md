---
title: "Class: TextInputStatefulWidget"
description: "Abstract base class for stateful text input widgets."
---

```dart
/// Abstract base class for stateful text input widgets.
///
/// Combines [StatefulWidget] with [TextInput] mixin to provide a base
/// for implementing text input components with state.
abstract class TextInputStatefulWidget extends StatefulWidget with TextInput {
  final Object groupId;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Widget? placeholder;
  final CrossAxisAlignment crossAxisAlignment;
  final String? clearButtonSemanticLabel;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final TapRegionCallback? onTapOutside;
  final TapRegionCallback? onTapUpOutside;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius cursorRadius;
  final bool cursorOpacityAnimates;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final GestureTapCallback? onTap;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool stylusHandwritingEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final String? initialValue;
  final String? hintText;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final bool? filled;
  final WidgetStatesController? statesController;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final UndoHistoryController? undoController;
  final List<InputFeature> features;
  final List<TextInputFormatter>? submitFormatters;
  final bool skipInputFeatureFocusTraversal;
  /// Creates a stateful text input widget with comprehensive configuration options.
  ///
  /// This constructor accepts all properties defined in the [TextInput] mixin,
  /// providing extensive control over text input behavior, appearance, and interactions.
  ///
  /// Most parameters mirror Flutter's [EditableText] widget while adding custom
  /// features like input features, decorations, and form integration.
  ///
  /// Key parameters include:
  /// - [controller]: Text editing controller, created automatically if null
  /// - [focusNode]: Focus node for keyboard interaction
  /// - [decoration]: Box decoration for the input container
  /// - [padding]: Inner padding around the text field
  /// - [placeholder]: Widget shown when field is empty
  /// - [enabled]: Whether input accepts user interaction, defaults to true
  /// - [readOnly]: Whether text can be edited, defaults to false
  /// - [obscureText]: Whether to hide input (for passwords), defaults to false
  /// - [maxLines]: Maximum number of lines, defaults to 1
  /// - [features]: List of input features (e.g., clear button, character count)
  ///
  /// See [TextInput] mixin documentation for full parameter details.
  const TextInputStatefulWidget({super.key, this.groupId = EditableText, this.controller, this.focusNode, this.decoration, this.padding, this.placeholder, this.crossAxisAlignment = CrossAxisAlignment.center, this.clearButtonSemanticLabel, this.keyboardType, this.textInputAction, this.textCapitalization = TextCapitalization.none, this.style, this.strutStyle, this.textAlign = TextAlign.start, this.textAlignVertical, this.textDirection, this.readOnly = false, this.showCursor, this.autofocus = false, this.obscuringCharacter = '•', this.obscureText = false, this.autocorrect = true, this.smartDashesType = SmartDashesType.enabled, this.smartQuotesType = SmartQuotesType.enabled, this.enableSuggestions = true, this.maxLines = 1, this.minLines, this.expands = false, this.maxLength, this.maxLengthEnforcement, this.onChanged, this.onEditingComplete, this.onSubmitted, this.onTapOutside, this.onTapUpOutside, this.inputFormatters, this.enabled = true, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius = const Radius.circular(2.0), this.cursorOpacityAnimates = true, this.cursorColor, this.selectionHeightStyle = ui.BoxHeightStyle.tight, this.selectionWidthStyle = ui.BoxWidthStyle.tight, this.keyboardAppearance, this.scrollPadding = const EdgeInsets.all(20.0), this.enableInteractiveSelection = true, this.selectionControls, this.dragStartBehavior = DragStartBehavior.start, this.scrollController, this.scrollPhysics, this.onTap, this.autofillHints = const [], this.clipBehavior = Clip.hardEdge, this.restorationId, this.stylusHandwritingEnabled = EditableText.defaultStylusHandwritingEnabled, this.enableIMEPersonalizedLearning = true, this.contentInsertionConfiguration, this.contextMenuBuilder, this.initialValue, this.hintText, this.border, this.borderRadius, this.filled, this.statesController, this.magnifierConfiguration, this.spellCheckConfiguration, this.undoController, this.features = const [], this.submitFormatters = const [], this.skipInputFeatureFocusTraversal = false});
  /// Creates a copy of this text field with the given properties replaced.
  ///
  /// All parameters are optional and allow selective property replacement.
  TextField copyWith({ValueGetter<Key?>? key, ValueGetter<Object>? groupId, ValueGetter<TextEditingController?>? controller, ValueGetter<String?>? initialValue, ValueGetter<FocusNode?>? focusNode, ValueGetter<UndoHistoryController?>? undoController, ValueGetter<BoxDecoration?>? decoration, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Widget?>? placeholder, ValueGetter<CrossAxisAlignment>? crossAxisAlignment, ValueGetter<String?>? clearButtonSemanticLabel, ValueGetter<TextInputType?>? keyboardType, ValueGetter<TextInputAction?>? textInputAction, ValueGetter<TextCapitalization>? textCapitalization, ValueGetter<TextStyle?>? style, ValueGetter<StrutStyle?>? strutStyle, ValueGetter<TextAlign>? textAlign, ValueGetter<TextAlignVertical?>? textAlignVertical, ValueGetter<TextDirection?>? textDirection, ValueGetter<bool>? readOnly, ValueGetter<bool?>? showCursor, ValueGetter<bool>? autofocus, ValueGetter<String>? obscuringCharacter, ValueGetter<bool>? obscureText, ValueGetter<bool>? autocorrect, ValueGetter<SmartDashesType>? smartDashesType, ValueGetter<SmartQuotesType>? smartQuotesType, ValueGetter<bool>? enableSuggestions, ValueGetter<int?>? maxLines, ValueGetter<int?>? minLines, ValueGetter<bool>? expands, ValueGetter<int?>? maxLength, ValueGetter<MaxLengthEnforcement?>? maxLengthEnforcement, ValueGetter<ValueChanged<String>?>? onChanged, ValueGetter<VoidCallback?>? onEditingComplete, ValueGetter<ValueChanged<String>?>? onSubmitted, ValueGetter<TapRegionCallback?>? onTapOutside, ValueGetter<TapRegionCallback?>? onTapUpOutside, ValueGetter<List<TextInputFormatter>?>? inputFormatters, ValueGetter<bool>? enabled, ValueGetter<double>? cursorWidth, ValueGetter<double?>? cursorHeight, ValueGetter<Radius>? cursorRadius, ValueGetter<bool>? cursorOpacityAnimates, ValueGetter<Color?>? cursorColor, ValueGetter<ui.BoxHeightStyle>? selectionHeightStyle, ValueGetter<ui.BoxWidthStyle>? selectionWidthStyle, ValueGetter<Brightness?>? keyboardAppearance, ValueGetter<EdgeInsets>? scrollPadding, ValueGetter<bool>? enableInteractiveSelection, ValueGetter<TextSelectionControls?>? selectionControls, ValueGetter<DragStartBehavior>? dragStartBehavior, ValueGetter<ScrollController?>? scrollController, ValueGetter<ScrollPhysics?>? scrollPhysics, ValueGetter<GestureTapCallback?>? onTap, ValueGetter<Iterable<String>?>? autofillHints, ValueGetter<Clip>? clipBehavior, ValueGetter<String?>? restorationId, ValueGetter<bool>? stylusHandwritingEnabled, ValueGetter<bool>? enableIMEPersonalizedLearning, ValueGetter<ContentInsertionConfiguration?>? contentInsertionConfiguration, ValueGetter<EditableTextContextMenuBuilder?>? contextMenuBuilder, ValueGetter<String?>? hintText, ValueGetter<Border?>? border, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? filled, ValueGetter<WidgetStatesController?>? statesController, ValueGetter<TextMagnifierConfiguration?>? magnifierConfiguration, ValueGetter<SpellCheckConfiguration?>? spellCheckConfiguration, ValueGetter<List<InputFeature>>? features, ValueGetter<List<TextInputFormatter>?>? submitFormatters, ValueGetter<bool>? skipInputFeatureFocusTraversal});
}
```
