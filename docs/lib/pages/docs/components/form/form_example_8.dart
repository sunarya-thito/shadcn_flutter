import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates the two ways to build a submit button.
///
/// Option 1: FormErrorBuilder — full manual control over button state.
///   Rebuilds whenever validation errors change. Lets you customize
///   the button appearance for error, loading, and valid states.
///
/// Option 2: SubmitButton — automatic handling of loading and error states.
///   Disables while async validators are pending, shows a loading indicator,
///   and disables while validation errors exist.
class FormExample8 extends StatelessWidget {
  const FormExample8({super.key});

  static const _nameKey = TextFieldKey('name');
  static const _emailKey = TextFieldKey('email');

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
                content: Text('Name: ${_nameKey[values]}\n'
                    'Email: ${_emailKey[values]}'),
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
                const FormField<String>(
                  key: _nameKey,
                  label: Text('Name'),
                  validator: LengthValidator(min: 2),
                  child: TextField(),
                ),
                FormField<String>(
                  key: _emailKey,
                  label: const Text('Email'),
                  // Async validator only runs on submit
                  validator: const EmailValidator() &
                      ValidationMode(
                        ConditionalValidator((value) async {
                          await Future.delayed(const Duration(seconds: 1));
                          return true; // always passes (demo)
                        }, message: 'Checking email...'),
                        mode: {FormValidationMode.submitted},
                      ),
                  child: const TextField(),
                ),
              ],
            ),
            const Gap(24),
            // Option 1: Manual submit with FormErrorBuilder
            FormErrorBuilder(
              builder: (context, errors, child) {
                return PrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Manual Submit'),
                );
              },
            ),
            const Gap(8),
            // Option 2: Automatic submit with SubmitButton
            const SubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(onSurface: true),
              ),
              child: Text('Auto Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
