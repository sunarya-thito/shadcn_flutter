---
title: "Example: components/form/form_example_7.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:convert';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates IgnoreForm to exclude widgets from form participation.
///
/// Any form-capable widget (TextField, Checkbox, etc.) placed inside a Form
/// will automatically register with the FormController. Wrap non-form inputs
/// in IgnoreForm to prevent them from participating in validation or submission.
///
/// In this example the search field at the top is excluded from the form,
/// while the name and email fields participate normally.
class FormExample7 extends StatelessWidget {
  const FormExample7({super.key});

  static const _nameKey = TextFieldKey('name');
  static const _emailKey = TextFieldKey('email');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          String json = jsonEncode(values.map((key, value) {
            return MapEntry(key.key, value);
          }));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Submitted Values'),
                content: Text(json),
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
            const Gap(16),
            FormTableLayout(
              rows: [
                const FormField<String>(
                  key: TextFieldKey('search'),
                  label: Text('Search (ignored)'),
                  // This TextField is wrapped in IgnoreForm, so it does NOT
                  // participate in form validation or submission.
                  child: IgnoreForm(
                    child: TextField(
                      placeholder: Text('Type to search...'),
                    ),
                  ),
```
