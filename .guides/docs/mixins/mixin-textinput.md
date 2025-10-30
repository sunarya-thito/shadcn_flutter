---
title: "Mixin: TextInput"
description: "Mixin defining the interface for text input widgets."
---

```dart
/// Mixin defining the interface for text input widgets.
///
/// Provides a comprehensive set of properties that text input widgets
/// must implement, ensuring consistency across [TextField], [ChipInput],
/// [TextArea], and similar components. This mixin helps avoid missing
/// properties when implementing custom text input widgets.
///
/// Properties are organized into categories:
/// - Basic configuration: groupId, controller, focusNode
/// - Visual styling: decoration, padding, placeholder, border, borderRadius
/// - Text configuration: style, strutStyle, textAlign, textDirection
/// - Input behavior: keyboardType, textInputAction, autocorrect, enableSuggestions
/// - Cursor styling: cursorWidth, cursorHeight, cursorRadius, cursorColor
/// - Selection: enableInteractiveSelection, selectionControls, selectionHeightStyle
/// - Callbacks: onChanged, onSubmitted, onEditingComplete, onTap
/// - Features: features, inputFormatters, submitFormatters
mixin TextInput on Widget {
  /// Group identifier for related text inputs.
  Object get groupId;
  /// Text editing controller for the input.
  TextEditingController? get controller;
  /// Focus node for keyboard focus management.
  FocusNode? get focusNode;
  /// Box decoration for the input container.
  BoxDecoration? get decoration;
  /// Padding inside the input.
  EdgeInsetsGeometry? get padding;
  /// Placeholder widget shown when empty.
  Widget? get placeholder;
  /// Cross-axis alignment for content.
  CrossAxisAlignment get crossAxisAlignment;
  /// Semantic label for the clear button.
  String? get clearButtonSemanticLabel;
  /// Type of keyboard to show.
  TextInputType? get keyboardType;
  /// Action button on the keyboard.
  TextInputAction? get textInputAction;
  /// Text capitalization behavior.
  TextCapitalization get textCapitalization;
  /// Text style for input content.
  TextStyle? get style;
  /// Strut style for text layout.
  StrutStyle? get strutStyle;
  /// Horizontal text alignment.
  TextAlign get textAlign;
  /// Vertical text alignment.
  TextAlignVertical? get textAlignVertical;
  /// Text direction.
  TextDirection? get textDirection;
  /// Whether the input is read-only.
  bool get readOnly;
  /// Whether to show the cursor.
  bool? get showCursor;
  /// Whether to auto-focus on mount.
  bool get autofocus;
  /// Character used for obscuring text.
  String get obscuringCharacter;
  /// Whether to obscure text (password fields).
  bool get obscureText;
  /// Whether to enable autocorrection.
  bool get autocorrect;
  /// Smart dashes behavior.
  SmartDashesType get smartDashesType;
  /// Smart quotes behavior.
  SmartQuotesType get smartQuotesType;
  /// Whether to enable suggestions.
  bool get enableSuggestions;
  /// Maximum number of lines.
  int? get maxLines;
  /// Minimum number of lines.
  int? get minLines;
  /// Whether the input should expand to fill available space.
  bool get expands;
  /// Maximum character length.
  int? get maxLength;
  /// How to enforce max length.
  MaxLengthEnforcement? get maxLengthEnforcement;
  /// Callback when text changes.
  ValueChanged<String>? get onChanged;
  /// Callback when editing is complete.
  VoidCallback? get onEditingComplete;
  /// Callback when text is submitted.
  ValueChanged<String>? get onSubmitted;
  /// Callback when tapped outside.
  TapRegionCallback? get onTapOutside;
  /// Callback when tap up occurs outside.
  TapRegionCallback? get onTapUpOutside;
  /// Input formatters for text.
  List<TextInputFormatter>? get inputFormatters;
  /// Whether the input is enabled.
  bool get enabled;
  /// Width of the cursor.
  double get cursorWidth;
  /// Height of the cursor.
  double? get cursorHeight;
  /// Radius of the cursor.
  Radius get cursorRadius;
  /// Whether cursor opacity animates.
  bool get cursorOpacityAnimates;
  /// Color of the cursor.
  Color? get cursorColor;
  /// Selection height style.
  ui.BoxHeightStyle get selectionHeightStyle;
  /// Selection width style.
  ui.BoxWidthStyle get selectionWidthStyle;
  /// Keyboard appearance brightness.
  Brightness? get keyboardAppearance;
  /// Scroll padding for keyboard avoidance.
  EdgeInsets get scrollPadding;
  /// Whether interactive selection is enabled.
  bool get enableInteractiveSelection;
  /// Controls for text selection.
  TextSelectionControls? get selectionControls;
  /// Drag start behavior.
  DragStartBehavior get dragStartBehavior;
  /// Scroll controller.
  ScrollController? get scrollController;
  /// Scroll physics.
  ScrollPhysics? get scrollPhysics;
  /// Callback when tapped.
  GestureTapCallback? get onTap;
  /// Autofill hints for the platform.
  Iterable<String>? get autofillHints;
  /// Clip behavior.
  Clip get clipBehavior;
  /// Restoration ID for state restoration.
  String? get restorationId;
  /// Whether stylus handwriting is enabled.
  bool get stylusHandwritingEnabled;
  /// Whether IME personalized learning is enabled.
  bool get enableIMEPersonalizedLearning;
  /// Content insertion configuration.
  ContentInsertionConfiguration? get contentInsertionConfiguration;
  /// Context menu builder.
  EditableTextContextMenuBuilder? get contextMenuBuilder;
  /// Initial value for the input.
  String? get initialValue;
  /// Hint text displayed when empty.
  String? get hintText;
  /// Border styling.
  Border? get border;
  /// Border radius.
  BorderRadiusGeometry? get borderRadius;
  /// Whether the input has a filled background.
  bool? get filled;
  /// Widget states controller.
  WidgetStatesController? get statesController;
  /// Magnifier configuration.
  TextMagnifierConfiguration? get magnifierConfiguration;
  /// Spell check configuration.
  SpellCheckConfiguration? get spellCheckConfiguration;
  /// Undo history controller.
  UndoHistoryController? get undoController;
  /// List of input features.
  List<InputFeature> get features;
  /// Input formatters applied on submit.
  List<TextInputFormatter>? get submitFormatters;
  /// Whether to skip focus traversal for input features.
  bool get skipInputFeatureFocusTraversal;
}
```
