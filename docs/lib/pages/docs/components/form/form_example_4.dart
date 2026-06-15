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
          showDialog(
            context: context,
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
                    Text('Notify: $notify'),
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
                FormField<String>(
                  key: _nameKey,
                  label: const Text('Name'),
                  validator: const LengthValidator(min: 2),
                  child: const TextField(
                    initialValue: 'Jane Doe',
                  ),
                ),
                FormInline<CheckboxState>(
                  key: _agreeKey,
                  label: const Text('I agree to the terms'),
                  validator: const CompareTo.equal(CheckboxState.checked,
                      message: 'You must agree'),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Checkbox(
                      state: _agreeState,
                      onChanged: (value) {
                        setState(() {
                          _agreeState = value;
                        });
                      },
                    ),
                  ),
                ),
                FormField<DateTime>(
                  key: _birthdayKey,
                  label: const Text('Birthday'),
                  validator:
                      const NonNullValidator(message: 'Please select a date'),
                  child: const ControlledDatePicker(),
                ),
                FormField<Gender>(
                  key: _genderKey,
                  label: const Text('Gender'),
                  validator:
                      const NonNullValidator(message: 'Please select a gender'),
                  child: ControlledSelect<Gender>(
                    popup: SelectPopup(
                      items: SelectItemList(children: [
                        for (var gender in Gender.values)
                          SelectItemButton(
                            value: gender,
                            child: Text(gender.displayName),
                          ),
                      ]),
                    ),
                    itemBuilder: (BuildContext context, Gender value) {
                      return Text(value.displayName);
                    },
                  ),
                ),
                FormInline<bool>(
                  key: _notifyKey,
                  label: const Text('Email notifications'),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Switch(
                      value: _notifyState,
                      onChanged: (value) {
                        setState(() {
                          _notifyState = value;
                        });
                      },
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
