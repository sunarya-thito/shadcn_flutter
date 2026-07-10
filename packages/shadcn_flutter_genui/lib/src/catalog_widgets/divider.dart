import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'A thin horizontal or vertical line used to separate content.',
  properties: {
    'axis': S.string(enumValues: ['horizontal', 'vertical']),
  },
);

extension type _DividerData.fromMap(JsonMap _json) {
  String? get axis => _json['axis'] as String?;
}

/// A thin horizontal or vertical line used to separate content, styled with
/// shadcn_flutter's [Divider].
///
/// ## Parameters:
///
/// - `axis`: The direction of the divider. Can be `horizontal` or `vertical`.
///   Defaults to `horizontal`.
final divider = CatalogItem(
  name: 'Divider',
  dataSchema: _schema,
  widgetBuilder: (itemContext) {
    final data = _DividerData.fromMap(itemContext.data as JsonMap);
    if (data.axis == 'vertical') {
      return const VerticalDivider();
    }
    return const Divider();
  },
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "Divider"
        }
      ]
    ''',
  ],
);
