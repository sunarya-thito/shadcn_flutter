---
title: "Class: FormEntryState"
description: "Reference for FormEntryState"
---

```dart
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
