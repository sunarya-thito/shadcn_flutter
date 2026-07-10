import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'A selectable checkbox used for boolean toggles with a label.',
  properties: {
    'label': A2uiSchemas.stringReference(),
    'value': A2uiSchemas.booleanReference(),
    'checks': A2uiSchemas.checkable(),
  },
  required: ['label', 'value'],
);

extension type _CheckBoxData.fromMap(JsonMap _json) {
  Object get label => _json['label'] as Object;
  Object get value => _json['value'] as Object;
  List<JsonMap>? get checks => (_json['checks'] as List?)?.cast<JsonMap>();
}

/// A checkbox with a label, rendered with shadcn_flutter's [Checkbox].
///
/// ## Parameters:
///
/// - `label`: The text to display next to the checkbox.
/// - `value`: The boolean value of the checkbox.
final checkBox = CatalogItem(
  name: 'CheckBox',
  dataSchema: _schema,
  isImplicitlyFlexible: true,
  widgetBuilder: (itemContext) {
    final data = _CheckBoxData.fromMap(itemContext.data as JsonMap);
    final Object valueRef = data.value;
    final path = (valueRef is Map && valueRef.containsKey('path'))
        ? valueRef['path'] as String
        : '${itemContext.id}.value';

    return BoundString(
      dataContext: itemContext.dataContext,
      value: data.label,
      builder: (context, label) {
        return StreamBuilder<String?>(
          stream: ValidationHelper.validateStream(
            data.checks,
            itemContext.dataContext,
          ),
          builder: (context, snapshot) {
            final errorText = snapshot.data;

            return BoundBool(
              dataContext: itemContext.dataContext,
              value: {'path': path},
              builder: (context, value) {
                final checkboxWidget = Checkbox(
                  state: (value ?? false)
                      ? CheckboxState.checked
                      : CheckboxState.unchecked,
                  trailing: Text(label ?? ''),
                  onChanged: (newState) {
                    itemContext.dataContext.update(
                      DataPath(path),
                      newState == CheckboxState.checked,
                    );
                  },
                );

                if (errorText == null) {
                  return checkboxWidget;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    checkboxWidget,
                    Text(
                      errorText,
                    ).small(color: Theme.of(context).colorScheme.destructive),
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
          "component": "CheckBox",
          "label": "Check me",
          "value": {
            "path": "/myValue"
          }
        }
      ]
    ''',
  ],
);
