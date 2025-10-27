---
title: "Mixin: FormFieldHandle"
description: "Reference for FormFieldHandle"
---

```dart
mixin FormFieldHandle {
  bool get mounted;
  FormKey get formKey;
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);
  FutureOr<ValidationResult?> revalidate();
  ValueListenable<ValidationResult?>? get validity;
}
```
