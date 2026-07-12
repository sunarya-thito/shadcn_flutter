import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/gen_schema_validators.dart';

class GenDatePickerSchema extends GenSchema {
  static const newValueParam = GenDateTimeParameter(
    'value',
    description: 'The newly selected date, ISO 8601, or null if cleared',
  );

  late final GenField<String?> value;
  late final GenField<GenValueActionDispatcher<DateTime?>?> onChanged;
  late final GenField<Validator<DateTime?>?> valueValidators;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.optionalString(
      'value',
      label: 'Selected date, ISO 8601 (e.g. 2026-07-11)',
      example: '2026-07-11',
    );
    onChanged = descriptor.optionalValueAction<DateTime?>(
      'onChanged',
      label: 'Triggered when a date is picked',
      parameter: newValueParam,
    );
    valueValidators = descriptor.validators<DateTime?>(
      'value',
      available: [GenNonNullValidator<DateTime?>()],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final raw = value[context];
    final date = raw == null ? null : DateTime.tryParse(raw);
    // DatePicker delegates its actual rendering to ObjectFormField
    // internally, which is form-aware (FormValueSupplier), so no manual
    // reporting is needed here.
    final field = DatePicker(
      value: date,
      onChanged: onChanged[context].toValueCallback(context),
    );
    return wrapFormEntry<DateTime?>(
      context: context,
      validator: valueValidators[context],
      field: field,
    );
  }
}

const genDatePicker = GenCatalogItem(
  name: 'DatePicker',
  label: 'A popup calendar for picking a single date.',
  schema: GenDatePickerSchema.new,
);
