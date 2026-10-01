import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

import 'action.dart';
import 'bound_text_input.dart';

/// The canonical A2UI catalog identifier for this package.
const shadcnFlutterCatalogId = 'dev.shadcn_flutter.genui';

const _catalogRules = r'''
Use the A2UI v0.9 message format. Create a surface with catalogId
"dev.shadcn_flutter.genui", then send its components in updateComponents.
The root component must have id "root". Do not put components inside
createSurface.

Input values are two-way bindings. Prefer {"path":"/fieldName"} for the
value of TextField, CheckBox, ChoicePicker, Slider, DateTimeInput, Switch, and
Tabs. User edits are written to that path automatically; do not invent an
onChanged action to synchronize input state. Actions are only for user events
or client function calls.
''';

String _pathFor(CatalogItemContext context, Object? reference) {
  if (reference is Map && reference['path'] is String) {
    return reference['path']! as String;
  }
  return '${context.id}.value';
}

JsonMap _data(CatalogItemContext context) => context.data as JsonMap;

Widget _withValidation(
  CatalogItemContext context,
  Object? checks,
  Widget child, {
  String? localError,
}) {
  final definitions = (checks as List?)?.whereType<JsonMap>().toList();
  if ((definitions == null || definitions.isEmpty) && localError == null) {
    return child;
  }
  return StreamBuilder<String?>(
    stream: ValidationHelper.validateStream(definitions, context.dataContext),
    builder: (buildContext, snapshot) {
      final error = snapshot.data ?? localError;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                error,
                style: TextStyle(
                  color: shad.Theme.of(buildContext).colorScheme.destructive,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    },
  );
}

final _text = CatalogItem(
  name: 'Text',
  dataSchema: BasicCatalogItems.text.dataSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    final field = BoundString(
      dataContext: context.dataContext,
      value: data['text'],
      builder: (buildContext, value) {
        final style = switch (data['variant']) {
          'h1' => const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          'h2' => const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          'h3' => const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          'h4' => const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          'h5' => const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          'caption' => const TextStyle(fontSize: 12),
          _ => null,
        };
        return Text(value ?? '', style: style);
      },
    );
    return field;
  },
  exampleData: BasicCatalogItems.text.exampleData,
);

final _button = CatalogItem(
  name: 'Button',
  dataSchema: BasicCatalogItems.button.dataSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    final action = data['action'] as JsonMap;
    Future<void> callback() => dispatchA2uiAction(context, action);
    final checks = (data['checks'] as List?)?.whereType<JsonMap>().toList();
    return StreamBuilder<String?>(
      stream: ValidationHelper.validateStream(checks, context.dataContext),
      builder: (buildContext, validation) {
        final onPressed = validation.data == null ? callback : null;
        return switch (data['variant']) {
          'borderless' => shad.Button.ghost(
            onPressed: onPressed,
            child: context.buildChild(data['child']! as String),
          ),
          'primary' => shad.Button.primary(
            onPressed: onPressed,
            child: context.buildChild(data['child']! as String),
          ),
          _ => shad.Button.outline(
            onPressed: onPressed,
            child: context.buildChild(data['child']! as String),
          ),
        };
      },
    );
  },
  exampleData: BasicCatalogItems.button.exampleData,
);

final _card = CatalogItem(
  name: 'Card',
  dataSchema: BasicCatalogItems.card.dataSchema,
  widgetBuilder: (context) {
    final child = _data(context)['child']! as String;
    return shad.Card(child: context.buildChild(child));
  },
  exampleData: BasicCatalogItems.card.exampleData,
);

final _checkBox = CatalogItem(
  name: 'CheckBox',
  dataSchema: BasicCatalogItems.checkBox.dataSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    final field = BoundString(
      dataContext: context.dataContext,
      value: data['label'],
      builder: (buildContext, label) => BoundBool(
        dataContext: context.dataContext,
        value: {'path': path},
        builder: (buildContext, boundValue) {
          final literal = reference is bool ? reference : false;
          return shad.Checkbox(
            state: (boundValue ?? literal)
                ? shad.CheckboxState.checked
                : shad.CheckboxState.unchecked,
            trailing: Text(label ?? ''),
            onChanged: (state) => context.dataContext.update(
              DataPath(path),
              state == shad.CheckboxState.checked,
            ),
          );
        },
      ),
    );
    return _withValidation(context, data['checks'], field);
  },
  exampleData: BasicCatalogItems.checkBox.exampleData,
);

final _textField = CatalogItem(
  name: 'TextField',
  dataSchema: BasicCatalogItems.textField.dataSchema,
  isImplicitlyFlexible: true,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    return BoundString(
      dataContext: context.dataContext,
      value: {'path': path},
      builder: (buildContext, boundValue) => BoundString(
        dataContext: context.dataContext,
        value: data['label'],
        builder: (buildContext, label) {
          final literal = reference is String ? reference : '';
          final variant = data['variant'] as String?;
          String? formatError;
          final regexp = data['validationRegexp'];
          final currentValue = boundValue ?? literal;
          if (regexp is String && currentValue.isNotEmpty) {
            try {
              if (!RegExp('^(?:$regexp)\$').hasMatch(currentValue)) {
                formatError = 'Invalid format';
              }
            } on FormatException {
              formatError = 'Invalid validation pattern';
            }
          }
          final field = BoundShadcnTextInput(
            value: boundValue ?? literal,
            label: label,
            multiline: variant == 'longText',
            obscureText: variant == 'obscured',
            keyboardType: variant == 'number'
                ? const TextInputType.numberWithOptions(decimal: true)
                : null,
            inputFormatters: variant == 'number'
                ? [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))]
                : null,
            onChanged: (value) =>
                context.dataContext.update(DataPath(path), value),
            onSubmitted: (value) {
              context.dataContext.update(DataPath(path), value);
              final action = data['onSubmittedAction'];
              if (action is JsonMap) dispatchA2uiAction(context, action);
            },
          );
          return _withValidation(
            context,
            data['checks'],
            field,
            localError: formatError,
          );
        },
      ),
    );
  },
  exampleData: BasicCatalogItems.textField.exampleData,
);

final _slider = CatalogItem(
  name: 'Slider',
  dataSchema: BasicCatalogItems.slider.dataSchema,
  isImplicitlyFlexible: true,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    final min = (data['min'] as num?)?.toDouble() ?? 0;
    final max = (data['max'] as num?)?.toDouble() ?? 1;
    final field = BoundNumber(
      dataContext: context.dataContext,
      value: {'path': path},
      builder: (buildContext, boundValue) {
        final literal = reference is num ? reference.toDouble() : min;
        final value = (boundValue?.toDouble() ?? literal).clamp(min, max);
        return shad.Slider(
          value: shad.SliderValue.single(value),
          min: min,
          max: max,
          onChanged: (value) =>
              context.dataContext.update(DataPath(path), value.value),
        );
      },
    );
    return _withValidation(context, data['checks'], field);
  },
  exampleData: BasicCatalogItems.slider.exampleData,
);

final _tabs = CatalogItem(
  name: 'Tabs',
  dataSchema: BasicCatalogItems.tabs.dataSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    final tabs = (data['tabs'] as List).cast<JsonMap>();
    if (tabs.isEmpty) return const SizedBox.shrink();
    final reference = data['activeTab'];
    final path = _pathFor(context, reference);
    return BoundNumber(
      dataContext: context.dataContext,
      value: {'path': path},
      builder: (buildContext, boundValue) {
        final literal = reference is num ? reference.toInt() : 0;
        final index = (boundValue?.toInt() ?? literal).clamp(
          0,
          tabs.length - 1,
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shad.Tabs(
              index: index,
              onChanged: (value) =>
                  context.dataContext.update(DataPath(path), value),
              children: [
                for (final tab in tabs)
                  shad.TabItem(
                    child: BoundString(
                      dataContext: context.dataContext,
                      value: tab['label'],
                      builder: (context, value) => Text(value ?? ''),
                    ),
                  ),
              ],
            ),
            IndexedStack(
              index: index,
              children: [
                for (final tab in tabs)
                  context.buildChild(tab['content']! as String),
              ],
            ),
          ],
        );
      },
    );
  },
  exampleData: BasicCatalogItems.tabs.exampleData,
);

final _choicePicker = CatalogItem(
  name: 'ChoicePicker',
  dataSchema: BasicCatalogItems.choicePicker.dataSchema,
  isImplicitlyFlexible: true,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    final field = StreamBuilder<Object?>(
      stream: context.dataContext.resolve(reference),
      builder: (buildContext, snapshot) {
        final rawValue = snapshot.data ?? reference;
        final selected = rawValue is List
            ? rawValue.whereType<String>().toSet()
            : rawValue is String
            ? {rawValue}
            : <String>{};
        return BoundList(
          dataContext: context.dataContext,
          value: data['options'],
          builder: (buildContext, options) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data['label'] != null)
                BoundString(
                  dataContext: context.dataContext,
                  value: data['label'],
                  builder: (context, value) => Text(value ?? ''),
                ),
              for (final option in options ?? const <Object?>[])
                if (option is JsonMap && option['value'] is String)
                  BoundString(
                    dataContext: context.dataContext,
                    value: option['label'],
                    builder: (buildContext, label) {
                      final value = option['value']! as String;
                      return shad.Checkbox(
                        state: selected.contains(value)
                            ? shad.CheckboxState.checked
                            : shad.CheckboxState.unchecked,
                        trailing: Text(label ?? value),
                        onChanged: (state) {
                          final next = <String>{...selected};
                          if (data['variant'] == 'mutuallyExclusive') {
                            next
                              ..clear()
                              ..add(value);
                          } else if (state == shad.CheckboxState.checked) {
                            next.add(value);
                          } else {
                            next.remove(value);
                          }
                          context.dataContext.update(
                            DataPath(path),
                            data['variant'] == 'mutuallyExclusive'
                                ? next.firstOrNull
                                : next.toList(),
                          );
                        },
                      );
                    },
                  ),
            ],
          ),
        );
      },
    );
    return _withValidation(context, data['checks'], field);
  },
  exampleData: BasicCatalogItems.choicePicker.exampleData,
);

final _dateTimeInput = CatalogItem(
  name: 'DateTimeInput',
  dataSchema: BasicCatalogItems.dateTimeInput.dataSchema,
  isImplicitlyFlexible: true,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    final field = BoundString(
      dataContext: context.dataContext,
      value: {'path': path},
      builder: (buildContext, boundValue) {
        final literal = reference is String ? reference : null;
        final rawValue = boundValue ?? literal ?? '';
        final value =
            DateTime.tryParse(rawValue) ??
            DateTime.tryParse('1970-01-01T$rawValue');
        final variant = data['variant'] as String? ?? 'datetime';
        final min = DateTime.tryParse(data['min'] as String? ?? '');
        final max = DateTime.tryParse(data['max'] as String? ?? '');

        void update(DateTime? next) {
          if (next == null) {
            context.dataContext.update(DataPath(path), null);
            return;
          }
          final formatted = switch (variant) {
            'date' => next.toIso8601String().split('T').first,
            'time' =>
              '${next.hour.toString().padLeft(2, '0')}:'
                  '${next.minute.toString().padLeft(2, '0')}:00',
            _ => next.toIso8601String(),
          };
          context.dataContext.update(DataPath(path), formatted);
        }

        final placeholder = BoundString(
          dataContext: context.dataContext,
          value: data['label'],
          builder: (context, label) => Text(
            label ?? (variant == 'time' ? 'Choose a time' : 'Choose a date'),
          ),
        );
        final datePicker = shad.DatePicker(
          value: value,
          placeholder: placeholder,
          stateBuilder: (date) {
            if ((min != null && date.isBefore(min)) ||
                (max != null && date.isAfter(max))) {
              return shad.DateState.disabled;
            }
            return shad.DateState.enabled;
          },
          onChanged: (date) {
            if (date == null) return update(null);
            update(
              DateTime(
                date.year,
                date.month,
                date.day,
                value?.hour ?? 0,
                value?.minute ?? 0,
              ),
            );
          },
        );
        final timePicker = shad.TimePicker(
          value: value == null ? null : shad.TimeOfDay.fromDateTime(value),
          placeholder: placeholder,
          showSeconds: true,
          onChanged: (time) {
            if (time == null) return update(null);
            final date = value ?? DateTime.now();
            update(
              DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
                time.second,
              ),
            );
          },
        );
        return switch (variant) {
          'date' => datePicker,
          'time' => timePicker,
          _ => Column(
            mainAxisSize: MainAxisSize.min,
            children: [datePicker, const SizedBox(height: 8), timePicker],
          ),
        };
      },
    );
    return _withValidation(context, data['checks'], field);
  },
  exampleData: BasicCatalogItems.dateTimeInput.exampleData,
);

final _divider = CatalogItem(
  name: 'Divider',
  dataSchema: BasicCatalogItems.divider.dataSchema,
  widgetBuilder: (context) => _data(context)['axis'] == 'vertical'
      ? const shad.VerticalDivider()
      : const shad.Divider(),
  exampleData: BasicCatalogItems.divider.exampleData,
);

final _icon = CatalogItem(
  name: 'Icon',
  dataSchema: BasicCatalogItems.icon.dataSchema,
  widgetBuilder: (context) => BoundString(
    dataContext: context.dataContext,
    value: _data(context)['name'],
    builder: (context, name) =>
        Icon(_icons[name] ?? shad.LucideIcons.circleHelp),
  ),
  exampleData: BasicCatalogItems.icon.exampleData,
);

const _icons = <String, IconData>{
  'add': shad.LucideIcons.plus,
  'arrowBack': shad.LucideIcons.arrowLeft,
  'arrowForward': shad.LucideIcons.arrowRight,
  'calendarToday': shad.LucideIcons.calendar,
  'check': shad.LucideIcons.check,
  'close': shad.LucideIcons.x,
  'delete': shad.LucideIcons.trash,
  'edit': shad.LucideIcons.pencil,
  'help': shad.LucideIcons.circleHelp,
  'home': shad.LucideIcons.house,
  'info': shad.LucideIcons.info,
  'mail': shad.LucideIcons.mail,
  'menu': shad.LucideIcons.menu,
  'person': shad.LucideIcons.user,
  'search': shad.LucideIcons.search,
  'settings': shad.LucideIcons.settings,
  'star': shad.LucideIcons.star,
  'warning': shad.LucideIcons.triangleAlert,
};

final _modal = CatalogItem(
  name: 'Modal',
  dataSchema: BasicCatalogItems.modal.dataSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => shad.showOverlay<void>(
        context.buildContext,
        const shad.DialogConfiguration(),
        builder: (buildContext) =>
            context.buildChild(data['content']! as String),
      ),
      child: context.buildChild(data['trigger']! as String),
    );
  },
  exampleData: BasicCatalogItems.modal.exampleData,
);

final _switchSchema = S.object(
  description: 'A shadcn switch with a two-way boolean value binding.',
  properties: {
    'label': A2uiSchemas.stringReference(),
    'value': A2uiSchemas.booleanReference(),
  },
  required: ['label', 'value'],
);

final _switchItem = CatalogItem(
  name: 'Switch',
  dataSchema: _switchSchema,
  widgetBuilder: (context) {
    final data = _data(context);
    final reference = data['value'];
    final path = _pathFor(context, reference);
    return BoundBool(
      dataContext: context.dataContext,
      value: {'path': path},
      builder: (buildContext, value) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          shad.Switch(
            value: value ?? (reference is bool ? reference : false),
            onChanged: (value) =>
                context.dataContext.update(DataPath(path), value),
          ),
          const SizedBox(width: 8),
          BoundString(
            dataContext: context.dataContext,
            value: data['label'],
            builder: (context, value) => Text(value ?? ''),
          ),
        ],
      ),
    );
  },
);

final _progressItem = CatalogItem(
  name: 'Progress',
  dataSchema: S.object(
    description: 'A progress indicator.',
    properties: {
      'value': A2uiSchemas.numberReference(),
      'min': S.number(),
      'max': S.number(),
    },
    required: ['value'],
  ),
  widgetBuilder: (context) {
    final data = _data(context);
    final min = (data['min'] as num?)?.toDouble() ?? 0;
    final max = (data['max'] as num?)?.toDouble() ?? 1;
    return BoundNumber(
      dataContext: context.dataContext,
      value: data['value'],
      builder: (context, value) => shad.Progress(
        progress: value?.toDouble().clamp(min, max),
        min: min,
        max: max,
      ),
    );
  },
);

/// Standard A2UI items rendered by shadcn_flutter.
abstract final class GenCatalog {
  GenCatalog._();

  static final CatalogItem text = _text;
  static final CatalogItem button = _button;
  static final CatalogItem card = _card;
  static final CatalogItem checkBox = _checkBox;
  static final CatalogItem choicePicker = _choicePicker;
  static final CatalogItem column = BasicCatalogItems.column;
  static final CatalogItem dateTimeInput = _dateTimeInput;
  static final CatalogItem divider = _divider;
  static final CatalogItem icon = _icon;
  static final CatalogItem list = BasicCatalogItems.list;
  static final CatalogItem modal = _modal;
  static final CatalogItem row = BasicCatalogItems.row;
  static final CatalogItem slider = _slider;
  static final CatalogItem tabs = _tabs;
  static final CatalogItem textField = _textField;
  static final CatalogItem switchItem = _switchItem;
  static final CatalogItem progress = _progressItem;

  static List<CatalogItem> get all => [
    text,
    button,
    card,
    checkBox,
    choicePicker,
    column,
    dateTimeInput,
    divider,
    icon,
    list,
    modal,
    row,
    slider,
    tabs,
    textField,
    switchItem,
    progress,
  ];

  /// Creates a protocol-aligned, Material-independent catalog.
  static Catalog asCatalog({
    List<CatalogItem> items = const [],
    List<ClientFunction> functions = const [],
    List<String> systemPromptFragments = const [],
  }) {
    return Catalog(
      [...all, ...items],
      functions: [...BasicFunctions.all, ...functions],
      catalogId: shadcnFlutterCatalogId,
      catalogIdAliases: const [
        basicCatalogId,
        // ignore: deprecated_member_use
        legacyBasicCatalogId,
      ],
      systemPromptFragments: [_catalogRules, ...systemPromptFragments],
    );
  }
}
