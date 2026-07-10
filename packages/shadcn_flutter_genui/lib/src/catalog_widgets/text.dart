import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension type _TextData.fromMap(JsonMap _json) {
  Object get text => _json['text'] as Object;
  String? get variant => _json['variant'] as String?;
}

/// A block of text rendered with shadcn_flutter's typography styles.
///
/// ## Parameters:
///
/// - `text`: The text to display. Supports data-model bindings.
/// - `variant`: A hint for the base text style. One of 'h1', 'h2', 'h3',
///   'h4', 'h5', 'caption', 'body'.
final text = CatalogItem(
  name: 'Text',
  dataSchema: S.object(
    description: 'A block of styled text.',
    properties: {
      'text': A2uiSchemas.stringReference(),
      'variant': S.string(
        description: 'A hint for the base text style.',
        enumValues: ['h1', 'h2', 'h3', 'h4', 'h5', 'caption', 'body'],
      ),
    },
    required: ['text'],
  ),
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "Text",
          "text": "Hello World",
          "variant": "h1"
        }
      ]
    ''',
  ],
  widgetBuilder: (itemContext) {
    final data = _TextData.fromMap(itemContext.data as JsonMap);
    return BoundString(
      dataContext: itemContext.dataContext,
      value: data.text,
      builder: (context, value) {
        final base = Text(value ?? '');
        return switch (data.variant) {
          'h1' => base.h1,
          'h2' => base.h2,
          'h3' => base.h3,
          'h4' => base.h4,
          'h5' => base.large.semiBold,
          'caption' => base.small.muted,
          _ => base,
        };
      },
    );
  },
);
