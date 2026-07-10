import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates composing validators with operators.
///
/// Validators can be combined using:
///   & (AND) — all must pass
///   | (OR)  — any one passing is enough
///   ~ (NOT) — negates a validator
///
/// This example shows a password field that requires both minimum length
/// AND password complexity, combined with & operator.
class FormExample5 extends StatelessWidget {
  const FormExample5({super.key});

  static const _passwordKey = TextFieldKey('password');
  static const _confirmKey = TextFieldKey('confirm');

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
                title: const Text('Success'),
                content: const Text('Password is valid!'),
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
                FormField<String>(
                  key: _passwordKey,
                  label: const Text('Password'),
                  // Compose validators with & (AND): both must pass.
                  validator: const LengthValidator(min: 8) &
                      const SafePasswordValidator(
                        requireSpecialChar: false,
                        requireUppercase: false,
                        requireLowercase: false,
                      ),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: const TextField(obscureText: true),
                ),
                const FormField<String>(
                  key: _confirmKey,
                  label: Text('Confirm'),
                  // Cross-field validation: must equal the password field.
                  // CompareWith automatically re-validates when the
                  // referenced field (_passwordKey) changes.
                  validator: CompareWith.equal(
                    _passwordKey,
                    message: 'Passwords do not match',
                  ),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
              ],
            ),
            const Gap(24),
            const SubmitButton(child: Text('Validate')),
          ],
        ),
      ),
    );
  }
}
