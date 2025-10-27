---
title: "Class: TextFieldState"
description: "Reference for TextFieldState"
---

```dart
class TextFieldState extends State<TextField> with RestorationMixin, AutomaticKeepAliveClientMixin<TextField>, FormValueSupplier<String, TextField>, TickerProviderStateMixin implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
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
