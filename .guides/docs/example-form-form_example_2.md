---
title: "Example: components/form/form_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:convert';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormExample2 extends StatefulWidget {
  const FormExample2({super.key});

  @override
  State<FormExample2> createState() => _FormExample2State();
}

class _FormExample2State extends State<FormExample2> {
  final _usernameKey = const TextFieldKey(#username);
  final _passwordKey = const TextFieldKey(#password);
  final _confirmPasswordKey = const TextFieldKey(#confirmPassword);
  final _agreeKey = const CheckboxKey(#agree);
  CheckboxState state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          // Get the values individually
          String? username = _usernameKey[values];
          String? password = _passwordKey[values];
          String? confirmPassword = _confirmPasswordKey[values];
          CheckboxState? agree = _agreeKey[values];
          // or just encode the whole map to JSON directly
          String json = jsonEncode(values.map((key, value) {
            return MapEntry(key.key, value);
          }));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Form Values'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username: $username'),
                    Text('Password: $password'),
                    Text('Confirm Password: $confirmPassword'),
                    Text('Agree: $agree'),
                    Text('JSON: $json'),
                  ],
                ),
                actions: [
                  PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
```
