import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/gen_schema_validators.dart';

class GenRadioGroupSchema extends GenSchema {
  static const newValueParam = GenStringParameter(
    'value',
    description: 'The newly selected option id',
  );

  late final GenField<String?> value;
  late final GenField<Map<String, String>> options;
  late final GenField<GenValueActionDispatcher<String>?> onChanged;
  late final GenField<Validator<String>?> valueValidators;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.optionalString(
      'value',
      label: 'Selected option id',
      example: 'b',
    );
    options = descriptor.map(
      'options',
      label: 'Available options',
      key: descriptor.string('optionId', label: 'Option id'),
      value: descriptor.string('optionName', label: 'Option display name'),
      example: {'a': 'Apple', 'b': 'Banana', 'c': 'Cherry'},
    );
    onChanged = descriptor.optionalValueAction<String>(
      'onChanged',
      label: 'Triggered when a different option is selected',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
    valueValidators = descriptor.validators<String>(
      'value',
      available: [GenNotEmptyValidator()],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final opts = options[context];
    final field = RadioGroup<String>(
      value: value[context],
      onChanged: onChanged[context].toValueCallback(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final entry in opts.entries)
            RadioItem<String>(value: entry.key, trailing: Text(entry.value)),
        ],
      ),
    );
    return wrapFormEntry<String>(
      context: context,
      validator: valueValidators[context],
      field: field,
    );
  }
}

const genRadioGroup = GenCatalogItem(
  name: 'RadioGroup',
  label: 'A set of mutually exclusive options shown all at once, one of which is selected.',
  schema: GenRadioGroupSchema.new,
);
