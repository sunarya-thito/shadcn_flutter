---
title: "Class: FormEntryState"
description: "State class for [FormEntry] widgets."
---

```dart
/// State class for [FormEntry] widgets.
///
/// Manages form field lifecycle and integrates with parent [FormController]
/// for validation and value reporting.
class FormEntryState extends State<FormEntry> with FormFieldHandle {
  FormKey get formKey;
  ValueListenable<ValidationResult?>? get validity;
  void didChangeDependencies();
  void dispose();
  Widget build(BuildContext context);
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);
  FutureOr<ValidationResult?> revalidate();
}
```
