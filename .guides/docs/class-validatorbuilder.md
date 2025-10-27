---
title: "Class: ValidatorBuilder"
description: "Reference for ValidatorBuilder"
---

```dart
class ValidatorBuilder<T> extends Validator<T> {
  final ValidatorBuilderFunction<T> builder;
  final List<FormKey> dependencies;
  const ValidatorBuilder(this.builder, {this.dependencies = const []});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey<dynamic> source);
  void operator ==(Object other);
  int get hashCode;
}
```
