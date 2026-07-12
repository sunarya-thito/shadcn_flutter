import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_text.dart';

/// Describes genui's own built-in `Column` component. Used only to generate
/// example JSON for `widget()`/`widgetList()` fields that reference a
/// vertical stack of content — `Column` itself is rendered by genui's
/// basics catalog, not this package, so [buildWidget] is never called.
class ColumnSchema extends GenSchema {
  late final GenField<List<Widget>> children;

  @override
  String get componentName => 'Column';

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    children = descriptor.widgetList(
      'children',
      label: 'Column children',
      example: [TextSchema.new],
    );
  }

  @override
  Widget buildWidget(BuildContext context) => throw UnsupportedError(
    'ColumnSchema is example-only; genui renders Column directly',
  );
}
