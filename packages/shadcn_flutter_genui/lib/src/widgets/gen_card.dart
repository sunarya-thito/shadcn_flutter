import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_text.dart';

class GenCardSchema extends GenSchema {
  late final GenField<Widget> child;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    child = descriptor.widget(
      'child',
      label: 'Card body',
      example: TextSchema.new.withExample((s) => s.text.example = 'Card body'),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Card(child: child[context]);
  }
}

const genCard = GenCatalogItem(
  name: 'Card',
  label: 'A bordered container that visually groups its child content.',
  schema: GenCardSchema.new,
);
