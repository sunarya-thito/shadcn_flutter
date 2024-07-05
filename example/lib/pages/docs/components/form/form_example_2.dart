import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormExample2 extends StatefulWidget {
  @override
  State<FormExample2> createState() => _FormExample2State();
}

class _FormExample2State extends State<FormExample2> {
  final _usernameKey = const FormKey<String>(#username);
  final _passwordKey = const FormKey<String>(#password);
  final _confirmPasswordKey = const FormKey<String>(#confirmPassword);
  final _agreeKey = const FormKey<CheckboxState>(#agree);
  CheckboxState state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: AlertDialog(
                  title: Text('Form Values'),
                  content: Text(values.toString()),
                  actions: [
                    PrimaryButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'),
                    ),
                  ],
                ),
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
                FormRow<String>(
                  key: _usernameKey,
                  label: Text('Username'),
                  hint: Text('This is your public display name'),
                  validator: LengthValidator(min: 4),
                  child: TextField(),
                ),
                FormRow<String>(
                  key: _passwordKey,
                  label: Text('Password'),
                  validator: LengthValidator(min: 8),
                  child: TextField(
                    obscureText: true,
                  ),
                ),
                FormRow<String>(
                  key: _confirmPasswordKey,
                  label: Text('Confirm Password'),
                  validator: CompareWith.equal(_passwordKey,
                      message: 'Passwords do not match'),
                  child: TextField(
                    obscureText: true,
                  ),
                ),
                FormInline<CheckboxState>(
                  key: _agreeKey,
                  label: Text('I agree to the terms and conditions'),
                  validator: CompareTo.equal(CheckboxState.checked,
                      message: 'You must agree to the terms and conditions'),
                  child: Align(
                    alignment: Alignment.centerRight,
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
            gap(24),
            FormErrorBuilder(
              builder: (context, errors, child) {
                return PrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: Text('Submit'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
