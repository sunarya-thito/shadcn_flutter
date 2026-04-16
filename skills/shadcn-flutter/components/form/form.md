# Form

A widget that provides form management capabilities for collecting and validating user input.

## Usage

### Form Example
```dart
import 'package:docs/pages/docs/components/form/form_example_3.dart';
import 'package:docs/pages/docs/components/form/form_example_4.dart';
import 'package:docs/pages/docs/components/form/form_example_5.dart';
import 'package:docs/pages/docs/components/form/form_example_6.dart';
import 'package:docs/pages/docs/components/form/form_example_7.dart';
import 'package:docs/pages/docs/components/form/form_example_8.dart';
import 'package:docs/pages/docs/components/form/form_example_9.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'form/form_example_1.dart';
import 'form/form_example_2.dart';

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final OnThisPage overviewKey = OnThisPage();
  final OnThisPage formKeysKey = OnThisPage();
  final OnThisPage keyReferenceKey = OnThisPage();
  final OnThisPage validationKey = OnThisPage();
  final OnThisPage showErrorsKey = OnThisPage();
  final OnThisPage submittingKey = OnThisPage();
  final OnThisPage controlledKey = OnThisPage();
  final OnThisPage ignoreFormKey = OnThisPage();
  final OnThisPage pitfallsKey = OnThisPage();
  final OnThisPage example1Key = OnThisPage();
  final OnThisPage example2Key = OnThisPage();
  final OnThisPage example3Key = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'form',
      onThisPage: {
        'Overview': overviewKey,
        'Form Keys': formKeysKey,
        'Key Reference': keyReferenceKey,
        'Validation': validationKey,
        'Show Errors vs Validation Mode': showErrorsKey,
        'Submitting': submittingKey,
        'Controlled Variants': controlledKey,
        'IgnoreForm': ignoreFormKey,
        'Common Pitfalls': pitfallsKey,
        'Example: Table Layout': example1Key,
        'Example: Column Layout': example2Key,
        'Example: Async Validation': example3Key,
      },
      navigationItems: [
        TextButton(
          density: ButtonDensity.compact,
          onPressed: () {
            context.pushNamed('components');
          },
          child: const Text('Components'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Form').h1(),
          const Text(
            'A helper widget that makes it easy to build and validate forms '
            'with typed field keys, composable validators, and flexible error display.',
          ).lead(),

          // ── Overview ──
          const Text('Overview').h2().anchored(overviewKey),
          const Text(
            'The Form widget provides a structured way to collect, validate, and '
            'submit user input. Unlike Material\'s built-in form system, shadcn_flutter '
            'uses typed FormKey objects to identify each field and carry its value type. '
            'This gives you compile-time type safety when reading submitted values.',
          ).p(),
          const Text(
            'A typical form setup involves three parts:',
          ).p(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Form — the container widget that manages state and handles submission.',
              ).li(),
              const Text(
                'FormField / FormInline — wraps each input with a label, validator, and error display.',
              ).li(),
              const Text(
                'FormKey — a typed key that uniquely identifies a field and its value type.',
              ).li(),
            ],
          ).p(),
          const Text(
            'The following example shows a form with multiple field types '
            '(TextField, Checkbox, DatePicker, Switch), each using the correct '
            'typed FormKey alias. Notice how the keys\' generic types (String, '
            'CheckboxState, DateTime, bool) match each widget\'s reported value.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_4.dart',
            child: FormExample4(),
          ),

          // ── Form Keys ──
          const Text('Form Keys').h2().anchored(formKeysKey),
          const Text(
            'Every form field must have a FormKey whose generic type matches '
            'the value type reported by the widget. This is the most important '
            'thing to get right — using the wrong key type will cause validation '
            'to silently fail or produce runtime errors.',
          ).p(),
          const Alert(
            leading: Icon(Icons.warning_amber_rounded),
            title: Text('Use typed key aliases, not generic FormKey'),
            content: Text(
              'A TextField reports String values. If you use FormKey<int>(\'name\') '
              'instead of TextFieldKey(\'name\'), the form system will fail with an '
              'assertion error because the value type does not match. Always use the '
              'correct typed alias for each component.',
            ),
          ).p,
          const Text(
            'Each form-capable widget (TextField, Checkbox, DatePicker, etc.) internally '
            'reports its value through the form system. The FormKey\'s generic type must '
            'match what the widget reports. For example, TextFieldKey is just a typedef '
            'for FormKey<String>, and CheckboxKey is FormKey<CheckboxState>. Using a '
            'plain FormKey or one with the wrong generic type will not work.',
          ).p(),
          const Text(
            'Keys must also be declared with const to preserve identity across rebuilds. '
            'A non-const key creates a new instance on every build, which breaks '
            'form state tracking.',
          ).p(),

          // ── Key Reference Table ──
          const Text('Key Reference').h2().anchored(keyReferenceKey),
          const Text(
            'Below is a complete reference of all typed FormKey aliases and '
            'which widget they pair with.',
          ).p(),
          _buildKeyReferenceTable(context),

          // ── Validation ──
          const Text('Validation').h2().anchored(validationKey),
          const Text(
            'Validators are composable objects that check field values and return '
            'a ValidationResult (or null if valid). You can combine validators '
            'with operators:',
          ).p(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('& (AND) — all validators must pass').li(),
              const Text('| (OR) — any validator passing is enough').li(),
              const Text('~ (NOT) — negates a validator').li(),
            ],
          ).p(),
          const Text(
            'Built-in validators include LengthValidator, NotEmptyValidator, '
            'NonNullValidator, EmailValidator, URLValidator, RegexValidator, '
            'SafePasswordValidator, MinValidator, MaxValidator, RangeValidator, '
            'CompareTo, CompareWith, and ConditionalValidator (supports async). '
            'CompareWith enables cross-field validation and automatically '
            're-validates when the referenced field changes.',
          ).p(),
          _buildValidatorTable(context),
          const Text(
            'The following example shows validator composition with & (AND) '
            'and cross-field validation with CompareWith.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_5.dart',
            child: FormExample5(),
          ),

          // ── showErrors vs ValidationMode ──
          const Text('Show Errors vs Validation Mode')
              .h2()
              .anchored(showErrorsKey),
          const Text(
            'These two concepts are easy to confuse but serve different purposes:',
          ).p(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ValidationMode — controls WHEN a validator RUNS '
                '(initial load, on change, or on submit).',
              ).li(),
              const Text(
                'showErrors — controls WHEN error messages are VISIBLE in the UI.',
              ).li(),
            ],
          ).p(),
          const Text(
            'A validator wrapped in ValidationMode will only execute during the '
            'specified modes. The showErrors parameter on FormField filters which '
            'validation results are displayed — even if a validator ran and '
            'produced an error, it won\'t show unless the mode is in showErrors.',
          ).p(),
          const Text('FormValidationMode has three values:').p(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'initial — runs when the field first registers its value with '
                'the form (e.g. on build). Useful for showing errors on fields '
                'that are pre-filled with invalid data.',
              ).li(),
              const Text(
                'changed — runs on every subsequent value change (typing, '
                'toggling, selecting). This is the most common mode for '
                'real-time feedback as the user interacts.',
              ).li(),
              const Text(
                'submitted — runs only when context.submitForm() is called. '
                'Use this for expensive checks like async network validation '
                'that should not run on every keystroke.',
              ).li(),
            ],
          ).p(),
          const Text(
            'The following example demonstrates an async "email already taken" '
            'check that only runs on submit (ValidationMode), while error '
            'messages are hidden until the user interacts (showErrors).',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_6.dart',
            child: FormExample6(),
          ),

          // ── Submitting ──
          const Text('Submitting').h2().anchored(submittingKey),
          const Text(
            'Call context.submitForm() to trigger submission. This re-runs all '
            'validators in submitted mode, awaits any async validators, and if '
            'all pass, calls the Form\'s onSubmit callback with a typed value map.',
          ).p(),
          const Text(
            'You can build a manual submit button with FormErrorBuilder (which '
            'rebuilds whenever validation state changes), or use the built-in '
            'SubmitButton widget which automatically handles loading and error '
            'states. SubmitButton disables itself while async validators are '
            'pending and shows the loadingTrailing widget as a spinner.',
          ).p(),
          const Text(
            'The following example shows both approaches side by side.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_8.dart',
            child: FormExample8(),
          ),

          // ── Controlled Variants ──
          const Text('Controlled Variants').h2().anchored(controlledKey),
          const Text(
            'Most form inputs have a Controlled variant (e.g. ControlledCheckbox, '
            'ControlledDatePicker, ControlledSwitch) that manages its own state '
            'internally. Instead of declaring a state variable and wiring up '
            'onChanged yourself, you can use the Controlled variant and let the '
            'widget handle it. This is especially useful inside forms where the '
            'FormController already tracks the value — you just need the widget '
            'to render correctly without manual setState calls.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_9.dart',
            child: FormExample9(),
          ),
          _buildControlledTable(context),

          // ── IgnoreForm ──
          const Text('IgnoreForm').h2().anchored(ignoreFormKey),
          const Text(
            'Any form-capable widget (TextField, Checkbox, etc.) placed inside '
            'a Form will automatically register with the FormController, even '
            'without a FormField wrapper. If you have a search bar, filter '
            'checkbox, or any other input that should NOT participate in form '
            'validation or submission, wrap it in IgnoreForm.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_7.dart',
            child: FormExample7(),
          ),

          // ── Common Pitfalls ──
          const Text('Common Pitfalls').h2().anchored(pitfallsKey),
          _buildPitfalls(),

          // ── Full Examples ──
          const Text('Example: Table Layout').h2().anchored(example1Key),
          const Text(
            'A basic registration form using FormTableLayout with cross-field '
            'password confirmation.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_1.dart',
            child: FormExample1(),
          ),
          const Text('Example: Column Layout').h2().anchored(example2Key),
          const Text(
            'Same form in a column layout with a checkbox agreement field '
            'using FormInline, and showErrors to only display validation '
            'messages after the user interacts.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_2.dart',
            child: FormExample2(),
          ),
          const Text('Example: Async Validation').h2().anchored(example3Key),
          const Text(
            'Demonstrates async validation (simulated network check for '
            'username availability) combined with SubmitButton for automatic '
            'loading state handling.',
          ).p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/components/form/form_example_3.dart',
            child: FormExample3(),
          ),
        ],
      ),
    );
  }

  TableCell _padded(Widget child) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }

  TableCell _headerCell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text).muted().semiBold(),
      ),
    );
  }

  Widget _buildKeyReferenceTable(BuildContext context) {
    return Table(
      rows: [
        TableHeader(cells: [
          _headerCell('Key Alias'),
          _headerCell('Value Type'),
          _headerCell('Widget'),
        ]),
        ..._keyEntries.map(
          (e) => TableRow(cells: [
            _padded(Text(e.$1)),
            _padded(Text(e.$2)),
            _padded(Text(e.$3)),
          ]),
        ),
      ],
    ).p();
  }

  static const _keyEntries = <(String, String, String)>[
    ('TextFieldKey', 'String', 'TextField'),
    ('TextAreaKey', 'String', 'TextArea'),
    ('InputKey', 'String', 'Generic text input'),
    ('AutoCompleteKey', 'String', 'AutoComplete'),
    ('CheckboxKey', 'CheckboxState', 'Checkbox'),
    ('SwitchKey', 'bool', 'Switch'),
    ('ToggleKey', 'bool', 'Toggle'),
    ('SliderKey', 'SliderValue', 'Slider'),
    ('StarRatingKey', 'double', 'StarRating'),
    ('SelectKey<T>', 'T', 'Select'),
    ('MultiSelectKey<T>', 'Iterable<T>', 'MultiSelect'),
    ('RadioGroupKey', 'int', 'RadioGroup'),
    ('RadioCardKey', 'int', 'RadioCard'),
    ('DatePickerKey', 'DateTime', 'DatePicker'),
    ('DateInputKey', 'DateTime', 'DateInput'),
    ('TimePickerKey', 'TimeOfDay', 'TimePicker'),
    ('TimeInputKey', 'TimeOfDay', 'TimeInput'),
    ('DurationPickerKey', 'Duration', 'DurationPicker'),
    ('DurationInputKey', 'Duration', 'DurationInput'),
    ('ColorPickerKey', 'Color', 'ColorPicker'),
    ('PhoneInputKey', 'PhoneNumber', 'PhoneInput'),
    ('InputOTPKey', 'List<int?>', 'InputOTP'),
    ('ChipInputKey<T>', 'List<T>', 'ChipInput'),
    ('NumberInputKey', 'num', 'NumberInput'),
  ];

  Widget _buildControlledTable(BuildContext context) {
    return Table(
      rows: [
        TableHeader(cells: [
          _headerCell('Standard Widget'),
          _headerCell('Controlled Variant'),
          _headerCell('Managed State'),
        ]),
        ..._controlledEntries.map(
          (e) => TableRow(cells: [
            _padded(Text(e.$1)),
            _padded(Text(e.$2)),
            _padded(Text(e.$3)),
          ]),
        ),
      ],
    ).p();
  }

  static const _controlledEntries = <(String, String, String)>[
    ('Checkbox', 'ControlledCheckbox', 'CheckboxState'),
    ('Switch', 'ControlledSwitch', 'bool'),
    ('Toggle', 'ControlledToggle', 'bool'),
    ('DatePicker', 'ControlledDatePicker', 'DateTime?'),
    ('TimePicker', 'ControlledTimePicker', 'TimeOfDay?'),
    ('Slider', 'ControlledSlider', 'SliderValue'),
    ('StarRating', 'ControlledStarRating', 'double'),
    ('Select<T>', 'ControlledSelect<T>', 'T?'),
    ('MultiSelect<T>', 'ControlledMultiSelect<T>', 'List<T>'),
    ('RadioGroup<T>', 'ControlledRadioGroup<T>', 'T?'),
    ('ColorInput', 'ControlledColorInput', 'Color?'),
  ];

  Widget _buildPitfalls() {
    return Accordion(
      items: [
        const AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Using the wrong FormKey type'),
          ),
          content: Text(
            'Each widget reports a specific value type. If your FormKey\'s '
            'generic type doesn\'t match, validation will fail silently or '
            'throw an assertion error. For example, TextField reports String, '
            'so you must use TextFieldKey (which is FormKey<String>). Using '
            'a plain FormKey or FormKey<int> will not work. See the Key '
            'Reference table above for the complete mapping.',
          ),
        ),
        const AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Confusing showErrors with ValidationMode'),
          ),
          content: Text(
            'ValidationMode controls when a validator RUNS. showErrors on '
            'FormField controls when errors are DISPLAYED. Even if a validator '
            'runs on initial mode and finds an error, the error won\'t show if '
            'showErrors only contains {changed, submitted}. These are independent '
            'settings that work together. See the "Show Errors vs Validation '
            'Mode" section above for a detailed example.',
          ),
        ),
        const AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Form-capable widgets inside Form without FormField'),
          ),
          content: Text(
            'Any form-capable widget (TextField, Checkbox, etc.) placed inside '
            'a Form will automatically try to register with the FormController, '
            'even without a FormField wrapper. If you have a search TextField '
            'or a filter Checkbox that should NOT participate in form validation '
            'or submission, wrap it in IgnoreForm. See the "IgnoreForm" section '
            'above for an example.',
          ),
        ),
        const AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Cross-field validation not re-running'),
          ),
          content: Text(
            'By default, changing one field does not re-validate other fields. '
            'Use CompareWith for cross-field validators — it automatically '
            're-validates when the referenced field changes. For custom '
            'cross-field validators, override shouldRevalidate(FormKey source) '
            'to return true when the dependent field changes.',
          ),
        ),
        const AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Using Symbols vs Strings as key identifiers'),
          ),
          content: Text(
            'FormKey accepts any Object as its identifier. Both Strings '
            '(TextFieldKey(\'username\')) and Symbols (TextFieldKey(#username)) '
            'work, but Symbols are not JSON-serializable. If you plan to encode '
            'form values as JSON with jsonEncode, use String identifiers. When '
            'encoding, access the underlying identifier via key.key: '
            '\'values.map((key, value) => MapEntry(key.key, value))\'.',
          ),
        ),
        AccordionItem(
          trigger: const AccordionTrigger(
            child: Text('Validators may return valid for empty strings'),
          ),
          content: const Text(
                  'Some validators (like EmailValidator, RegexValidator, URLValidator, etc.) '
                  'will return valid if the string is empty. This means a blank field will pass '
                  'validation unless you also add NotEmptyValidator. Always combine NotEmptyValidator '
                  'with these to ensure empty values are rejected. For example: ')
              .thenInlineCode('NotEmptyValidator() & EmailValidator()'),
        ),
      ],
    );
  }

  Widget _buildValidatorTable(BuildContext context) {
    return Table(
      rows: [
        TableHeader(cells: [
          _headerCell('Validator'),
          _headerCell('Description'),
        ]),
        ..._validatorEntries.map(
          (e) => TableRow(cells: [
            _padded(Text(e.$1)),
            _padded(Text(e.$2)),
          ]),
        ),
      ],
    ).p();
  }

  static const _validatorEntries = <(String, String)>[
    (
      'NonNullValidator',
      'Fails if the value is null. Used to require a value.'
    ),
    ('NotEmptyValidator', 'Fails if the string is null or empty.'),
    (
      'LengthValidator',
      'Checks if a string\'s length is within min/max bounds.'
    ),
    ('RegexValidator', 'Checks if a string matches a regular expression.'),
    ('EmailValidator', 'Checks if a string is a valid email address.'),
    ('URLValidator', 'Checks if a string is a valid URL.'),
    (
      'SafePasswordValidator',
      'Checks password for digits, upper/lowercase, special chars.'
    ),
    (
      'MinValidator',
      'Checks if a number is greater than (or equal to) a minimum.'
    ),
    (
      'MaxValidator',
      'Checks if a number is less than (or equal to) a maximum.'
    ),
    ('RangeValidator', 'Checks if a number is within a min/max range.'),
    ('CompareTo', 'Compares a value to a static value (>, <, ==, etc).'),
    (
      'CompareWith',
      'Compares a value to another field\'s value (cross-field).'
    ),
    (
      'ConditionalValidator',
      'Runs only if a predicate returns true (supports async).'
    ),
    ('ValidationMode', 'Wraps another validator to control when it runs.'),
    ('CompositeValidator', 'Combines multiple validators (all must pass).'),
    ('OrValidator', 'Combines validators (at least one must pass).'),
    ('NotValidator', 'Negates another validator (passes if it fails).'),
    ('ValidatorBuilder', 'Custom inline validator using a function.'),
  ];
}

```

### Form Example 1
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
              rows: [
                FormField(
                  key: _usernameKey,
                  label: const Text('Username'),
                  hint: const Text('This is your public display name'),
                  validator: const LengthValidator(min: 4),
                  child: const TextField(
                    initialValue: 'sunarya-thito',
                  ),
                ),
                FormField(
                  key: _passwordKey,
                  label: const Text('Password'),
                  validator: const LengthValidator(min: 8),
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
                FormField(
                  key: _confirmPasswordKey,
                  label: const Text('Confirm Password'),
                  validator: CompareWith.equal(_passwordKey,
                      message: 'Passwords do not match'),
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const Gap(24),
            FormErrorBuilder(
              builder: (context, errors, child) {
                // Disable the submit button while there are validation errors.
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

```

### Form Example 2
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

```

### Form Example 3
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
                      ValidationMode(
                        ConditionalValidator((value) async {
                          // simulate a network delay for example purpose
                          await Future.delayed(const Duration(seconds: 1));
                          return !_dummyData.contains(value);
                        }, message: 'Username already taken'),
                        // only validate when the form is submitted
                        mode: {FormValidationMode.submitted},
                      ),
                  child: const TextField(
                    initialValue: 'sunarya-thito',
                  ),
                ),
                FormField(
                  key: _passwordKey,
                  label: const Text('Password'),
                  validator: const LengthValidator(min: 8),
                  showErrors: const {
                    FormValidationMode.submitted,
                    FormValidationMode.changed
                  },
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
                FormField<String>(
                  key: _confirmPasswordKey,
                  label: const Text('Confirm Password'),
                  showErrors: const {
                    FormValidationMode.submitted,
                    FormValidationMode.changed
                  },
                  validator: CompareWith.equal(_passwordKey,
                      message: 'Passwords do not match'),
                  child: const TextField(
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const Gap(24),
            const SubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  onSurface: true,
                ),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Form Example 4
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

class _FormExample4State extends State<FormExample4> {
  // ✅ Each key uses the correct typed alias for the widget it pairs with.
  //    Always use const to preserve key identity across rebuilds.
  final _nameKey = const TextFieldKey('name'); // TextField → String
  final _agreeKey = const CheckboxKey('agree'); // Checkbox → CheckboxState
  final _birthdayKey = const DatePickerKey('birthday'); // DatePicker → DateTime
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

```

### Form Example 5
```dart
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

```

### Form Example 6
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates the difference between showErrors and ValidationMode.
///
/// - ValidationMode controls WHEN a validator RUNS.
/// - showErrors controls WHEN error messages are VISIBLE in the UI.
///
/// In this example the email field uses ValidationMode to only run the
/// async "already taken" check on submit, while showErrors hides all
/// error messages until the user interacts or submits.
class FormExample6 extends StatelessWidget {
  const FormExample6({super.key});

  static const _emailKey = TextFieldKey('email');
  static const _takenEmails = ['admin@example.com', 'user@example.com'];

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
                title: const Text('Submitted'),
                content: Text('Email: ${_emailKey[values]}'),
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
                  key: _emailKey,
                  label: const Text('Email'),
                  hint: const Text('Try admin@example.com to see async error'),
                  // Validator composition:
                  //  1. EmailValidator always runs (on initial, change, submit)
                  //  2. "Already taken" check only runs on submit
                  validator: const EmailValidator() &
                      ValidationMode(
                        ConditionalValidator((value) async {
                          await Future.delayed(const Duration(seconds: 1));
                          return !_takenEmails.contains(value);
                        }, message: 'Email already taken'),
                        // This validator only RUNS on submit
                        mode: {FormValidationMode.submitted},
                      ),
                  // Error messages only VISIBLE after change or submit
                  // (not on initial load, so the form starts clean)
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: const TextField(),
                ),
              ],
            ),
            const Gap(24),
            const SubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(onSurface: true),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Form Example 7
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
                ),
                // These fields participate in the form normally.
                const FormField<String>(
                  key: _nameKey,
                  label: Text('Name'),
                  validator: LengthValidator(min: 2),
                  child: TextField(),
                ),
                FormField<String>(
                  key: _emailKey,
                  label: const Text('Email'),
                  validator: const EmailValidator() & const NotEmptyValidator(),
                  child: const TextField(),
                ),
              ],
            ),
            const Gap(24),
            const SubmitButton(child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}

```

### Form Example 8
```dart
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

```

### Form Example 9
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Compares standard vs Controlled component boilerplate.
///
/// The left column uses standard widgets that require manual state
/// management (StatefulWidget, setState, value/onChanged wiring).
/// The right column uses Controlled variants that handle state
/// internally — no StatefulWidget or setState needed.
class FormExample9 extends StatefulWidget {
  const FormExample9({super.key});

  @override
  State<FormExample9> createState() => _FormExample9State();
}

class _FormExample9State extends State<FormExample9> {
  // ── Standard widgets need manual state ──
  CheckboxState _checkboxState = CheckboxState.unchecked;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Standard: you manage the state ──
          const Text('Standard (manual state)').semiBold,
          const Gap(24),
          Checkbox(
            state: _checkboxState,
            onChanged: (value) {
              setState(() {
                _checkboxState = value;
              });
            },
            trailing: const Text('Accept terms'),
          ),
          const Gap(8),
          Switch(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
            trailing: const Text('Dark mode'),
          ),
          const Gap(32),
          const Divider(),
          const Gap(32),
          // ── Controlled: zero boilerplate ──
          const Text('Controlled (no manual state)').semiBold,
          const Gap(24),
          const ControlledCheckbox(
            trailing: Text('Accept terms'),
          ),
          const Gap(8),
          const ControlledSwitch(
            trailing: Text('Dark mode'),
          ),
        ],
      ),
    );
  }
}

```

### Form Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../form/form_example_1.dart';

class FormTile extends StatelessWidget implements IComponentPage {
  const FormTile({super.key});

  @override
  String get title => 'Form';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'form',
      title: 'Form',
      example: Card(child: FormExample1()),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `controller` | `FormController?` | Optional controller for programmatic form management.  When provided, this controller manages form state externally and allows programmatic access to form values, validation states, and submission. If null, the Form creates and manages its own internal controller. |
| `child` | `Widget` | The widget subtree containing form fields.  This child widget should contain the form fields and other UI elements that participate in the form. Form fields within this subtree automatically register with this Form instance. |
| `onSubmit` | `FormSubmitCallback?` | Callback invoked when the form is submitted.  This callback receives a map of form values keyed by their [FormKey] identifiers. It is called when [FormController.submit] is invoked and all form validations pass successfully.  The callback can return a Future for asynchronous submission processing. |
