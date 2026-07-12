import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

class GenCheckboxSchema extends GenSchema {
  static final newValueParam = const GenBoolParameter(
    'value',
    description: 'The new checked state',
  ).map<CheckboxState>((state) => state == CheckboxState.checked);

  late final GenField<bool> value;
  late final GenField<String?> label;
  late final GenField<GenValueActionDispatcher<CheckboxState>?> onChanged;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.boolean('value', label: 'Checked state', example: false);
    label = descriptor.optionalString(
      'label',
      label: 'Label',
      example: 'Check me',
    );
    onChanged = descriptor.optionalValueAction<CheckboxState>(
      'onChanged',
      label: 'Triggered when the checkbox is toggled',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final labelText = label[context];
    final field = Checkbox(
      state: value[context] ? CheckboxState.checked : CheckboxState.unchecked,
      trailing: labelText == null ? null : Text(labelText),
      onChanged: onChanged[context].toValueCallback(context),
    );
    return wrapFormEntry<CheckboxState>(
      context: context,
      validator: null,
      field: field,
    );
  }
}

const genCheckbox = GenCatalogItem(
  name: 'CheckBox',
  label: 'A checkable box for a single yes/no choice, with an optional label.',
  schema: GenCheckboxSchema.new,
);
