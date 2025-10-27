---
title: "Class: FormValidityNotification"
description: "Reference for FormValidityNotification"
---

```dart
class FormValidityNotification extends Notification {
  final ValidationResult? oldValidity;
  final ValidationResult? newValidity;
  const FormValidityNotification(this.newValidity, this.oldValidity);
}
```
