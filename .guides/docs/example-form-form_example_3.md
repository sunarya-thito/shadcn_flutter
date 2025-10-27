---
title: "Example: components/form/form_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:convert';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormExample3 extends StatefulWidget {
  const FormExample3({super.key});

  @override
  State<FormExample3> createState() => _FormExample3State();
}

class _FormExample3State extends State<FormExample3> {
  final _dummyData = [
    'sunarya-thito',
    'septogeddon',
    'shadcn',
  ];

  final _usernameKey = const TextFieldKey('username');
  final _passwordKey = const TextFieldKey('password');
  final _confirmPasswordKey = const TextFieldKey('confirmPassword');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Form Values'),
                content: Text(jsonEncode(values.map(
                  (key, value) {
                    return MapEntry(key.key, value);
                  },
                ))),
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
              rows: [
                FormField(
                  key: _usernameKey,
                  label: const Text('Username'),
                  hint: const Text('This is your public display name'),
                  // Combine validators: length + async availability check,
                  // but only run the async validator on submit.
                  validator: const LengthValidator(min: 4) &
```
