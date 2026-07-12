import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_column.dart';

class GenFormSchema extends GenSchema {
  late final GenField<Widget> child;
  late final GenField<GenActionDispatcher?> onSubmit;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    child = descriptor.widget(
      'child',
      label: 'Form content',
      example: ColumnSchema.new,
    );
    onSubmit = descriptor.optionalAction(
      'onSubmit',
      label:
          'Triggered once every field in this form passes validation, '
          'reached by a nested action containing {"submitForm": {}}',
      example: const EventExample('submitted'),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final dispatcher = onSubmit[context];
    return Form(
      onSubmit: (formContext, values) => dispatcher?.call(context),
      child: child[context],
    );
  }
}

const genForm = GenCatalogItem(
  name: 'Form',
  label: 'Groups fields together so their validation can be checked as a whole before submitting.',
  schema: GenFormSchema.new,
);
