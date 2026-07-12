import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_text.dart';

class GenAlertSchema extends GenSchema {
  late final GenField<Widget> title;
  late final GenField<Widget> content;
  late final GenField<bool> destructive;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    title = descriptor.widget(
      'title',
      label: 'Alert title',
      example: TextSchema.new.withExample((s) => s.text.example = 'Low battery'),
    );
    content = descriptor.widget(
      'content',
      label: 'Alert content',
      example: TextSchema.new.withExample(
        (s) => s.text.example = 'Save your work.',
      ),
    );
    destructive = descriptor.boolean(
      'destructive',
      label: 'Use destructive styling',
      example: true,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Alert(
      title: title[context],
      content: content[context],
      destructive: destructive[context],
    );
  }
}

const genAlert = GenCatalogItem(
  name: 'Alert',
  label: 'A titled message box for drawing attention to important information.',
  schema: GenAlertSchema.new,
);
