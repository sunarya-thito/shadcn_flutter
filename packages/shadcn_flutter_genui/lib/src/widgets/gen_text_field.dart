import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/gen_schema_validators.dart';

class GenTextFieldSchema extends GenSchema {
  static const newValueParam = GenStringParameter(
    'value',
    description: 'The new text, on every keystroke',
  );
  static const submittedValueParam = GenStringParameter(
    'value',
    description: 'The submitted text',
  );

  late final GenField<String> value;
  late final GenField<String?> label;
  late final GenField<GenValueActionDispatcher<String>?> onChanged;
  late final GenField<GenValueActionDispatcher<String>?> onSubmitted;
  late final GenField<Validator<String>?> valueValidators;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.string(
      'value',
      label: 'Text value',
      example: 'Hello World',
    );
    label = descriptor.optionalString(
      'label',
      label: 'Placeholder label',
      example: 'Greeting',
    );
    onChanged = descriptor.optionalValueAction<String>(
      'onChanged',
      label: 'Triggered on every keystroke',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
    onSubmitted = descriptor.optionalValueAction<String>(
      'onSubmitted',
      label: 'Triggered when the user submits (presses Enter)',
      parameter: submittedValueParam,
      example: const EventExample('submitted', context: {'text': {'var': 'value'}}),
    );
    valueValidators = descriptor.validators<String>(
      'value',
      available: [
        GenNotEmptyValidator(),
        GenLengthValidator(),
        GenRegexValidator(),
        GenEmailValidator(),
        GenUrlValidator(),
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final placeholderText = label[context];
    final field = TextField(
      initialValue: value[context],
      placeholder: placeholderText == null ? null : Text(placeholderText),
      onChanged: onChanged[context].toValueCallback(context),
      onSubmitted: onSubmitted[context].toValueCallback(context),
    );
    return wrapFormEntry<String>(
      context: context,
      validator: valueValidators[context],
      field: field,
    );
  }
}

const genTextField = GenCatalogItem(
  name: 'TextField',
  label: 'A single-line text input for short free-form text, e.g. a name or search query.',
  schema: GenTextFieldSchema.new,
);
