import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

/// Describes genui's own built-in `Text` component. Used only to generate
/// example JSON for `widget()`/`widgetList()` fields that reference a piece
/// of text (e.g. a button's label) — `Text` itself is rendered by genui's
/// basics catalog, not this package, so [buildWidget] is never called.
class TextSchema extends GenSchema {
  late final GenField<String> text;

  @override
  String get componentName => 'Text';

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    text = descriptor.string(
      'text',
      label: 'Text content',
      example: 'Example text',
    );
  }

  @override
  Widget buildWidget(BuildContext context) => throw UnsupportedError(
    'TextSchema is example-only; genui renders Text directly',
  );
}
