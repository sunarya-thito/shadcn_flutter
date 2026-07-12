import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

class GenSliderSchema extends GenSchema {
  static final newValueParam = const GenDecimalParameter(
    'value',
    description: 'The current value while dragging',
  ).map<SliderValue>((v) => v.value);
  static final finalValueParam = const GenDecimalParameter(
    'value',
    description: 'The value once dragging ends',
  ).map<SliderValue>((v) => v.value);

  late final GenField<double> value;
  late final GenField<double> min;
  late final GenField<double> max;
  late final GenField<GenValueActionDispatcher<SliderValue>?> onChanged;
  late final GenField<GenValueActionDispatcher<SliderValue>?> onChangeEnd;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Current value', example: 0.5);
    min = descriptor.decimal('min', label: 'Minimum value', example: 0.0);
    max = descriptor.decimal('max', label: 'Maximum value', example: 1.0);
    onChanged = descriptor.optionalValueAction<SliderValue>(
      'onChanged',
      label: 'Triggered continuously while dragging',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
    onChangeEnd = descriptor.optionalValueAction<SliderValue>(
      'onChangeEnd',
      label: 'Triggered once the user finishes dragging (acts as submission)',
      parameter: finalValueParam,
      example: const EventExample('changed', context: {'value': {'var': 'value'}}),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final field = Slider(
      value: SliderValue.single(value[context]),
      min: min[context],
      max: max[context],
      onChanged: onChanged[context].toValueCallback(context),
      onChangeEnd: onChangeEnd[context].toValueCallback(context),
    );
    return wrapFormEntry<SliderValue>(
      context: context,
      validator: null,
      field: field,
    );
  }
}

const genSlider = GenCatalogItem(
  name: 'Slider',
  label: 'A draggable slider for picking a numeric value within a min/max range.',
  schema: GenSliderSchema.new,
);
