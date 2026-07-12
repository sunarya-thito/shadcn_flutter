import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

class GenSwitchSchema extends GenSchema {
  static const newValueParam = GenBoolParameter(
    'value',
    description: 'The new on/off state',
  );

  late final GenField<bool> value;
  late final GenField<GenValueActionDispatcher<bool>?> onChanged;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.boolean('value', label: 'On/off state', example: true);
    onChanged = descriptor.optionalValueAction<bool>(
      'onChanged',
      label: 'Triggered when the switch is toggled',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final field = Switch(
      value: value[context],
      onChanged: onChanged[context].toValueCallback(context),
    );
    return wrapFormEntry<bool>(context: context, validator: null, field: field);
  }
}

const genSwitch = GenCatalogItem(
  name: 'Switch',
  label: 'An on/off toggle for a single boolean setting.',
  schema: GenSwitchSchema.new,
);
