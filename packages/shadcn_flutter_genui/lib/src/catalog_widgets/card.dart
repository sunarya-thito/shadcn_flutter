import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'A visual container (card) that groups a single child widget.',
  properties: {'child': A2uiSchemas.componentReference()},
  required: ['child'],
);

extension type _CardData.fromMap(JsonMap _json) {
  String get child {
    final Object? val = _json['child'];
    if (val is String) return val;
    throw ArgumentError('Invalid child: $val');
  }
}

/// A shadcn_flutter card, a container for related information and actions.
///
/// ## Parameters:
///
/// - `child`: The ID of a child widget to display inside the card.
final card = CatalogItem(
  name: 'Card',
  dataSchema: _schema,
  widgetBuilder: (itemContext) {
    final data = _CardData.fromMap(itemContext.data as JsonMap);
    return Card(child: itemContext.buildChild(data.child));
  },
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "Card",
          "child": "text"
        },
        {
          "id": "text",
          "component": "Text",
          "text": "This is a card."
        }
      ]
    ''',
  ],
);
