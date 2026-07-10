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
