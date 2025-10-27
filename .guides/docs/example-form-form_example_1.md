---
title: "Example: components/form/form_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:convert';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormExample1 extends StatefulWidget {
  const FormExample1({super.key});

  @override
  State<FormExample1> createState() => _FormExample1State();
}

class _FormExample1State extends State<FormExample1> {
  final _usernameKey = const TextFieldKey('username');
  final _passwordKey = const TextFieldKey('password');
  final _confirmPasswordKey = const TextFieldKey('confirmPassword');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        // Submit handler receives a typed map of field keys to values.
        onSubmit: (context, values) {
          // Get the values individually
          String? username = _usernameKey[values];
          String? password = _passwordKey[values];
          String? confirmPassword = _confirmPasswordKey[values];
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FormTableLayout(
```
