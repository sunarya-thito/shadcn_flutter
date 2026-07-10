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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormField(
                  key: _usernameKey,
                  label: const Text('Username'),
                  hint: const Text('This is your public display name'),
                  validator: const LengthValidator(min: 4),
                  // Show validation messages when the value changes and after submit.
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted
                  },
                  child: const TextField(),
                ),
                FormField(
                  key: _passwordKey,
                  label: const Text('Password'),
                  validator: const LengthValidator(min: 8),
                  // Same validation visibility behavior for password.
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted
                  },
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
                FormField(
                  key: _confirmPasswordKey,
                  label: const Text('Confirm Password'),
                  validator: CompareWith.equal(_passwordKey,
                      message: 'Passwords do not match'),
                  // Mirror validation visibility on confirm.
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted
                  },
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
                FormInline(
                  key: _agreeKey,
                  label: const Text('I agree to the terms and conditions'),
                  validator: const CompareTo.equal(CheckboxState.checked,
                      message: 'You must agree to the terms and conditions'),
                  // Inline field with a trailing checkbox and same visibility behavior.
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Checkbox(
                        state: state,
                        onChanged: (value) {
                          setState(() {
                            state = value;
                          });
                        }),
                  ),
                ),
              ],
            ).gap(24),
            const Gap(24),
            FormErrorBuilder(
              builder: (context, errors, child) {
                return PrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Submit'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
