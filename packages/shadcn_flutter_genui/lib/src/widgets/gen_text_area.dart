import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/gen_schema_validators.dart';

class GenTextAreaSchema extends GenSchema {
  static const newValueParam = GenStringParameter(
    'value',
    description: 'The new text, on every keystroke',
  );

  late final GenField<String> value;
  late final GenField<String?> label;
  late final GenField<GenValueActionDispatcher<String>?> onChanged;
  late final GenField<Validator<String>?> valueValidators;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.string(
      'value',
      label: 'Text value',
      example: 'Line one.\nLine two.',
    );
    label = descriptor.optionalString(
      'label',
      label: 'Placeholder label',
      example: 'Notes',
    );
    onChanged = descriptor.optionalValueAction<String>(
      'onChanged',
      label: 'Triggered on every keystroke',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
    valueValidators = descriptor.validators<String>(
      'value',
      available: [GenNotEmptyValidator(), GenLengthValidator()],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final placeholderText = label[context];
    final field = TextArea(
      initialValue: value[context],
      placeholder: placeholderText == null ? null : Text(placeholderText),
      onChanged: onChanged[context].toValueCallback(context),
    );
    return wrapFormEntry<String>(
      context: context,
      validator: valueValidators[context],
      field: field,
    );
  }
}

const genTextArea = GenCatalogItem(
  name: 'TextArea',
  label: 'A multi-line text input for longer free-form text, e.g. notes or a message.',
  schema: GenTextAreaSchema.new,
);
