---
title: "Class: TextFieldState"
description: "State class for [TextField] widget."
---

```dart
/// State class for [TextField] widget.
///
/// Manages the text field's state including text editing, selection,
/// input features, form integration, and restoration.
class TextFieldState extends State<TextField> with RestorationMixin, AutomaticKeepAliveClientMixin<TextField>, FormValueSupplier<String, TextField>, TickerProviderStateMixin implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  /// The effective text editing controller for this text field.
  ///
  /// Returns the widget's controller or the internally created controller.
  TextEditingController get effectiveController;
  bool get forcePressEnabled;
  final GlobalKey<EditableTextState> editableTextKey;
  bool get selectionEnabled;
  void initState();
  void didChangeDependencies();
  void didUpdateWidget(TextField oldWidget);
  void restoreState(RestorationBucket? oldBucket, bool initialRestore);
  String? get restorationId;
  void dispose();
  bool get wantKeepAlive;
  TextField get widget;
  String get autofillId;
  void autofill(TextEditingValue newEditingValue);
  TextInputConfiguration get textInputConfiguration;
  Widget build(BuildContext context);
  void didReplaceFormValue(String value);
}
```
