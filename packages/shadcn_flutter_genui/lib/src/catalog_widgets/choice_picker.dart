import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description:
      'A component that allows selecting one or more options from a list.',
  properties: {
    'label': A2uiSchemas.stringReference(
      description: 'The label for the group of options.',
    ),
    'options': A2uiSchemas.listOrReference(
      description: 'The list of available options to choose from.',
      items: S.object(
        properties: {
          'label': A2uiSchemas.stringReference(
            description: 'The text to display for this option.',
          ),
          'value': S.string(
            description: 'The stable value associated with this option.',
          ),
        },
        required: ['label', 'value'],
      ),
    ),
    'value': S.combined(
      oneOf: [
        S.string(),
        S.list(items: S.string()),
        A2uiSchemas.dataBindingSchema(),
        A2uiSchemas.functionCall(),
      ],
      description: 'The list of currently selected values (or single value).',
    ),
    'displayStyle': S.string(
      description: 'The display style of the component.',
      enumValues: ['checkbox', 'chips'],
    ),
    'variant': S.string(
      description:
          'A hint for how the choice picker should be displayed and behave.',
      enumValues: ['multipleSelection', 'mutuallyExclusive'],
    ),
    'checks': A2uiSchemas.checkable(),
  },
  required: ['options', 'value'],
);

extension type _ChoicePickerData.fromMap(JsonMap _json) {
  Object? get label => _json['label'];
  String? get variant => _json['variant'] as String?;
  Object? get options => _json['options'];
  Object get value => _json['value'] as Object;
  String? get displayStyle => _json['displayStyle'] as String?;
  List<JsonMap>? get checks => (_json['checks'] as List?)?.cast<JsonMap>();
}

/// A component that allows selecting one or more options from a list,
/// rendered with shadcn_flutter's [RadioGroup], [Checkbox] and [Chip].
final choicePicker = CatalogItem(
  name: 'ChoicePicker',
  dataSchema: _schema,
  isImplicitlyFlexible: true,
  widgetBuilder: (itemContext) {
    final data = _ChoicePickerData.fromMap(itemContext.data as JsonMap);
    final Object valueRef = data.value;
    final path = (valueRef is Map && valueRef.containsKey('path'))
        ? valueRef['path'] as String
        : '${itemContext.id}.value';

    final isMutuallyExclusive = data.variant == 'mutuallyExclusive';
    final isChips = data.displayStyle == 'chips';

    return StreamBuilder<bool>(
      stream: itemContext.dataContext.evaluateConditionStream(
        checksToExpression(data.checks),
      ),
      initialData: true,
      builder: (context, snapshot) {
        final isError = !(snapshot.data ?? true);

        return BoundList(
          dataContext: itemContext.dataContext,
          value: data.options,
          builder: (context, options) {
            final pickerWidget = _ChoicePicker(
              label: data.label,
              options: options,
              valueRef: valueRef,
              path: path,
              itemContext: itemContext,
              isMutuallyExclusive: isMutuallyExclusive,
              isChips: isChips,
            );

            if (!isError) return pickerWidget;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                pickerWidget,
                Text(
                  'Invalid selection',
                ).small(color: Theme.of(context).colorScheme.destructive),
              ],
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
          "component": "Column",
          "children": ["heading1", "radio", "heading2", "check"]
        },
        { "id": "heading1", "component": "Text", "text": "Mutually Exclusive", "variant": "h4" },
        { "id": "radio", "component": "ChoicePicker", "variant": "mutuallyExclusive", "label": "Choose one", "value": ["A"], "options": [ { "label": "A", "value": "A" }, { "label": "B", "value": "B" } ] },
        { "id": "heading2", "component": "Text", "text": "Multiple Selection", "variant": "h4" },
        { "id": "check", "component": "ChoicePicker", "variant": "multipleSelection", "label": "Choose many", "value": { "path": "/multi" }, "options": [ { "label": "X", "value": "X" }, { "label": "Y", "value": "Y" } ] }
      ]
    ''',
  ],
);

class _ChoicePicker extends StatelessWidget {
  const _ChoicePicker({
    required this.label,
    required this.options,
    required this.valueRef,
    required this.path,
    required this.itemContext,
    required this.isMutuallyExclusive,
    required this.isChips,
  });

  final Object? label;
  final List<Object?>? options;
  final Object valueRef;
  final String path;
  final CatalogItemContext itemContext;
  final bool isMutuallyExclusive;
  final bool isChips;

  void _updateSelection(bool selected, String optionValue, List<String> current) {
    if (isMutuallyExclusive) {
      if (selected) {
        itemContext.dataContext.update(DataPath(path), [optionValue]);
      }
      return;
    }
    final newSelections = List<String>.from(current);
    if (selected) {
      if (!newSelections.contains(optionValue)) {
        newSelections.add(optionValue);
      }
    } else {
      newSelections.remove(optionValue);
    }
    itemContext.dataContext.update(DataPath(path), newSelections);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          BoundString(
            dataContext: itemContext.dataContext,
            value: label!,
            builder: (context, resolvedLabel) {
              if (resolvedLabel == null || resolvedLabel.isEmpty) {
                return const SizedBox.shrink();
              }
              return Text(resolvedLabel).small.medium;
            },
          ),
        BoundObject(
          dataContext: itemContext.dataContext,
          value: {'path': path},
          builder: (context, currentSelections) {
            var effectiveSelections = currentSelections;
            if (effectiveSelections == null) {
              if (valueRef is List) {
                effectiveSelections = valueRef;
              } else if (valueRef is String) {
                effectiveSelections = [valueRef];
              }
            } else if (effectiveSelections is! List) {
              effectiveSelections = [effectiveSelections];
            }
            final current = (effectiveSelections as List?)
                    ?.map((e) => e.toString())
                    .toList() ??
                <String>[];

            if (options == null) return const SizedBox.shrink();
            final castOptions = options!.cast<JsonMap>();

            if (isMutuallyExclusive) {
              return RadioGroup<String>(
                value: current.isNotEmpty ? current.first : null,
                onChanged: (newValue) {
                  itemContext.dataContext.update(DataPath(path), [newValue]);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: castOptions.map((option) {
                    final optionValue = option['value'] as String;
                    return BoundString(
                      dataContext: itemContext.dataContext,
                      value: option['label'],
                      builder: (context, optionLabel) => RadioItem<String>(
                        value: optionValue,
                        trailing: Text(optionLabel ?? ''),
                      ),
                    );
                  }).toList(),
                ),
              );
            }

            if (isChips) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: castOptions.map((option) {
                  final optionValue = option['value'] as String;
                  final selected = current.contains(optionValue);
                  return BoundString(
                    dataContext: itemContext.dataContext,
                    value: option['label'],
                    builder: (context, optionLabel) => Chip(
                      style: selected
                          ? const ButtonStyle.primary()
                          : const ButtonStyle.secondary(),
                      onPressed: () =>
                          _updateSelection(!selected, optionValue, current),
                      child: Text(optionLabel ?? ''),
                    ),
                  );
                }).toList(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: castOptions.map((option) {
                final optionValue = option['value'] as String;
                final selected = current.contains(optionValue);
                return BoundString(
                  dataContext: itemContext.dataContext,
                  value: option['label'],
                  builder: (context, optionLabel) => Checkbox(
                    state: selected
                        ? CheckboxState.checked
                        : CheckboxState.unchecked,
                    trailing: Text(optionLabel ?? ''),
                    onChanged: (newState) => _updateSelection(
                      newState == CheckboxState.checked,
                      optionValue,
                      current,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
