import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'A slider for selecting a value from a range.',
  properties: {
    'value': A2uiSchemas.numberReference(),
    'min': S.number(description: 'The minimum value. Defaults to 0.0.'),
    'max': S.number(description: 'The maximum value. Defaults to 1.0.'),
    'label': A2uiSchemas.stringReference(
      description: 'The label for the slider.',
    ),
    'checks': A2uiSchemas.checkable(),
  },
  required: ['value'],
);

extension type _SliderData.fromMap(JsonMap _json) {
  Object get value => _json['value'] as Object;
  double get min => (_json['min'] as num?)?.toDouble() ?? 0.0;
  double get max => (_json['max'] as num?)?.toDouble() ?? 1.0;
  List<JsonMap>? get checks => (_json['checks'] as List?)?.cast<JsonMap>();

  String? get label {
    final val = _json['label'];
    if (val is String) return val;
    if (val is Map && val.containsKey('value')) {
      return val['value'] as String?;
    }
    return null;
  }
}

/// A slider for selecting a value from a range, rendered with
/// shadcn_flutter's [Slider].
///
/// ## Parameters:
///
/// - `value`: The current value of the slider.
/// - `min`: The minimum value of the slider. Defaults to 0.0.
/// - `max`: The maximum value of the slider. Defaults to 1.0.
/// - `label`: The label for the slider.
final slider = CatalogItem(
  name: 'Slider',
  dataSchema: _schema,
  widgetBuilder: (itemContext) {
    final data = _SliderData.fromMap(itemContext.data as JsonMap);
    final Object valueRef = data.value;
    final path = (valueRef is Map && valueRef.containsKey('path'))
        ? valueRef['path'] as String
        : '${itemContext.id}.value';

    return BoundNumber(
      dataContext: itemContext.dataContext,
      value: {'path': path},
      builder: (context, value) {
        var effectiveValue = value;
        if (effectiveValue == null && valueRef is num) {
          effectiveValue = valueRef;
        }
        final current = (effectiveValue ?? data.min).toDouble();

        final sliderWidget = Row(
          children: [
            Expanded(
              child: Slider(
                value: SliderValue.single(current),
                min: data.min,
                max: data.max,
                onChanged: (newValue) {
                  itemContext.dataContext.update(
                    DataPath(path),
                    newValue.value,
                  );
                },
              ),
            ),
            Gap(8),
            Text(current.toStringAsFixed(0)),
          ],
        );

        return BoundString(
          dataContext: itemContext.dataContext,
          value: data.label,
          builder: (context, label) {
            return StreamBuilder<bool>(
              stream: itemContext.dataContext.evaluateConditionStream(
                checksToExpression(data.checks),
              ),
              initialData: true,
              builder: (context, snapshot) {
                final isError = !(snapshot.data ?? true);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (label != null) Text(label).small.medium,
                    sliderWidget,
                    if (isError)
                      Text('Invalid value').small(
                        color: Theme.of(context).colorScheme.destructive,
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  },
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "Slider",
          "min": 0,
          "max": 10,
          "value": {
            "path": "/myValue"
          }
        }
      ]
    ''',
  ],
);
