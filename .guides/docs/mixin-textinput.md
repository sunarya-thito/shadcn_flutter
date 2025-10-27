---
title: "Mixin: TextInput"
description: "Mixin widget used to avoid human error (e."
---

```dart
/// Mixin widget used to avoid human error (e.g. missing properties) when
/// implementing a [TextField], [ChipInput], [TextArea], etc.
mixin TextInput on Widget {
  Object get groupId;
  TextEditingController? get controller;
  FocusNode? get focusNode;
  BoxDecoration? get decoration;
  EdgeInsetsGeometry? get padding;
  Widget? get placeholder;
  CrossAxisAlignment get crossAxisAlignment;
  String? get clearButtonSemanticLabel;
  TextInputType? get keyboardType;
  TextInputAction? get textInputAction;
  TextCapitalization get textCapitalization;
  TextStyle? get style;
  StrutStyle? get strutStyle;
  TextAlign get textAlign;
  TextAlignVertical? get textAlignVertical;
  TextDirection? get textDirection;
  bool get readOnly;
  bool? get showCursor;
  bool get autofocus;
  String get obscuringCharacter;
  bool get obscureText;
  bool get autocorrect;
  SmartDashesType get smartDashesType;
  SmartQuotesType get smartQuotesType;
  bool get enableSuggestions;
  int? get maxLines;
  int? get minLines;
  bool get expands;
  int? get maxLength;
  MaxLengthEnforcement? get maxLengthEnforcement;
  ValueChanged<String>? get onChanged;
  VoidCallback? get onEditingComplete;
  ValueChanged<String>? get onSubmitted;
  TapRegionCallback? get onTapOutside;
  TapRegionCallback? get onTapUpOutside;
  List<TextInputFormatter>? get inputFormatters;
  bool get enabled;
  double get cursorWidth;
  double? get cursorHeight;
  Radius get cursorRadius;
  bool get cursorOpacityAnimates;
  Color? get cursorColor;
  ui.BoxHeightStyle get selectionHeightStyle;
  ui.BoxWidthStyle get selectionWidthStyle;
  Brightness? get keyboardAppearance;
  EdgeInsets get scrollPadding;
  bool get enableInteractiveSelection;
  TextSelectionControls? get selectionControls;
  DragStartBehavior get dragStartBehavior;
  ScrollController? get scrollController;
  ScrollPhysics? get scrollPhysics;
  GestureTapCallback? get onTap;
  Iterable<String>? get autofillHints;
  Clip get clipBehavior;
  String? get restorationId;
  bool get stylusHandwritingEnabled;
  bool get enableIMEPersonalizedLearning;
  ContentInsertionConfiguration? get contentInsertionConfiguration;
  EditableTextContextMenuBuilder? get contextMenuBuilder;
  String? get initialValue;
  String? get hintText;
  Border? get border;
  BorderRadiusGeometry? get borderRadius;
  bool? get filled;
  WidgetStatesController? get statesController;
  TextMagnifierConfiguration? get magnifierConfiguration;
  SpellCheckConfiguration? get spellCheckConfiguration;
  UndoHistoryController? get undoController;
  List<InputFeature> get features;
  List<TextInputFormatter>? get submitFormatters;
  bool get skipInputFeatureFocusTraversal;
}
```
