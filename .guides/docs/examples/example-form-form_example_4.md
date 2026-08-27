---
title: "Example: components/form/form_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates using the correct typed FormKey for each widget.
///
/// Every form-capable widget reports a specific value type. The FormKey's
/// generic type must match — use the typed alias (TextFieldKey, CheckboxKey,
/// DatePickerKey, SwitchKey, etc.) instead of the generic FormKey.
class FormExample4 extends StatefulWidget {
  const FormExample4({super.key});

  @override
  State<FormExample4> createState() => _FormExample4State();
}

enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  final String displayName;
  const Gender(this.displayName);
}

class _FormExample4State extends State<FormExample4> {
  final _nameKey = const TextFieldKey('name'); // TextField → String
  final _agreeKey = const CheckboxKey('agree'); // Checkbox → CheckboxState
  final _birthdayKey = const DatePickerKey('birthday'); // DatePicker → DateTime
  final _genderKey =
      const SelectKey<Gender>('gender'); // Select → T (Gender in this case)
  final _notifyKey = const SwitchKey('notify'); // Switch → bool

  CheckboxState _agreeState = CheckboxState.unchecked;
  bool _notifyState = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          // Read values with full type safety — no casting needed.
          String? name = _nameKey[values];
          CheckboxState? agree = _agreeKey[values];
          DateTime? birthday = _birthdayKey[values];
          Gender? gender = _genderKey[values];
          bool? notify = _notifyKey[values];
          showOverlay(
            context,
            DialogConfiguration(),
            builder: (context) {
              return AlertDialog(
                title: const Text('Form Values'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name'),
                    Text('Agree: $agree'),
                    Text('Birthday: $birthday'),
                    Text('Gender: $gender'),
```
