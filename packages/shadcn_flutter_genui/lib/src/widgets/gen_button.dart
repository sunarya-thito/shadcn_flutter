import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_text.dart';

class GenButtonSchema extends GenSchema {
  late final GenField<Widget> child;
  late final GenField<GenActionDispatcher?> onPressed;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    child = descriptor.widget(
      'child',
      label: 'Button content',
      example: TextSchema.new.withExample((s) => s.text.example = 'Press me'),
    );
    onPressed = descriptor.optionalAction(
      'onPressed',
      label: 'Triggered when the button is pressed',
      example: const EventExample('pressed'),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Button.primary(
      onPressed: onPressed[context].toVoidCallback(context),
      child: child[context],
    );
  }
}

const genButton = GenCatalogItem(
  name: 'Button',
  label: 'A clickable button that triggers an action when pressed.',
  schema: GenButtonSchema.new,
);
