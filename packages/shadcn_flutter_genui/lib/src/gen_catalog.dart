import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/v0_9/basic_catalog.dart' as v0_9;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:json_schema_builder/json_schema_builder.dart'
    hide ValidationResult;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

import 'action.dart';
import 'bound_text_input.dart';

/// The canonical A2UI catalog identifier for this package.
const shadcnFlutterCatalogId = 'dev.shadcn_flutter.genui';

/// The ids of the standard A2UI v0.9 basic catalog, which
/// [GenCatalog.asCatalogs] also registers the catalog under.
const _basicCatalogIds = [
  BasicCatalog.v0_9Id,
  'https://a2ui.org/specification/v0_9/basic_catalog.json',
];

const _catalogRules = r'''
Use the A2UI v0.9 message format. Create a surface with catalogId
"dev.shadcn_flutter.genui", then send its components in updateComponents.
The root component must have id "root". Do not put components inside
createSurface.

Input values are two-way bindings. Prefer {"path":"/fieldName"} for the
value of TextField, CheckBox, ChoicePicker, Slider, DateTimeInput, and
Switch. User edits are written to that path automatically; do not invent an
onChanged action to synchronize input state. Actions are only for user events
or client function calls.
''';

/// Writes a value to the data path that the property [key] is bound to, or
/// is null when [key] holds a literal, which an edit cannot change. A write
/// the data model rejects is reported on the surface.
ValueChanged<Object?>? _writer(
  ComponentNode<ComponentImplementation> node,
  ComponentProps props,
  String key,
) {
  final binding = props.writable(key);
  if (binding == null) return null;
  return (value) {
    try {
      binding.set(value);
    } on A2uiDataError catch (error) {
      final surface = node.context?.surface;
      if (surface == null) return;
      unawaited(
        surface.dispatchError(
          A2uiRendererError(
            code: error.code,
            surfaceId: surface.id,
            message: error.message,
            path: error.path,
          ),
        ),
      );
    }
  };
}

/// The widget of the child that the property [key] references.
Widget _child(ComponentProps props, String key, ChildWidgetBuilder buildChild) {
  final child = props.child(key);
  return child == null ? const SizedBox.shrink() : buildChild(child);
}

Widget _withValidation(
  BuildContext context,
  ComponentProps props,
  Widget child, {
  String? localError,
}) {
  if (props.list('checks').isEmpty && localError == null) {
    return child;
  }
  final error = props.validationErrors.firstOrNull ?? localError;
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
              color: shad.Theme.of(context).colorScheme.destructive,
              fontSize: 12,
            ),
          ),
        ),
    ],
  );
}

final _text = ComponentImplementation(
  name: 'Text',
  schema: v0_9.BasicComponents.text.schema,
  builder: (context, node, props, buildChild) {
    final style = switch (props.string('variant')) {
      'h1' => const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      'h2' => const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      'h3' => const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      'h4' => const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      'h5' => const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      'caption' => const TextStyle(fontSize: 12),
      _ => null,
    };
    return Text(props.string('text') ?? '', style: style);
  },
);

final _button = ComponentImplementation(
  name: 'Button',
  schema: v0_9.BasicComponents.button.schema,
  builder: (context, node, props, buildChild) {
    void callback() => dispatchA2uiAction(context, node, props, 'action');
    final onPressed = props.isValid ? callback : null;
    return switch (props.string('variant')) {
      'borderless' => shad.Button.ghost(
        onPressed: onPressed,
        child: _child(props, 'child', buildChild),
      ),
      'primary' => shad.Button.primary(
        onPressed: onPressed,
        child: _child(props, 'child', buildChild),
      ),
      _ => shad.Button.outline(
        onPressed: onPressed,
        child: _child(props, 'child', buildChild),
      ),
    };
  },
);

final _card = ComponentImplementation(
  name: 'Card',
  schema: v0_9.BasicComponents.card.schema,
  builder: (context, node, props, buildChild) {
    return shad.Card(child: _child(props, 'child', buildChild));
  },
);

final _checkBox = ComponentImplementation(
  name: 'CheckBox',
  schema: v0_9.BasicComponents.checkBox.schema,
  builder: (context, node, props, buildChild) {
    final write = _writer(node, props, 'value');
    final field = shad.Checkbox(
      state: (props.boolean('value') ?? false)
          ? shad.CheckboxState.checked
          : shad.CheckboxState.unchecked,
      trailing: Text(props.string('label') ?? ''),
      onChanged: write == null
          ? null
          : (state) => write(state == shad.CheckboxState.checked),
    );
    return _withValidation(context, props, field);
  },
);

final _textField = ComponentImplementation(
  name: 'TextField',
  schema: v0_9.BasicComponents.textField.schema,
  builder: (context, node, props, buildChild) {
    final write = _writer(node, props, 'value');
    final variant = props.string('variant');
    String? formatError;
    final regexp = props.string('validationRegexp');
    final currentValue = props.string('value') ?? '';
    if (regexp != null && currentValue.isNotEmpty) {
      try {
        if (!RegExp('^(?:$regexp)\$').hasMatch(currentValue)) {
          formatError = 'Invalid format';
        }
      } on FormatException {
        formatError = 'Invalid validation pattern';
      }
    }
    final field = BoundShadcnTextInput(
      value: currentValue,
      label: props.string('label'),
      multiline: variant == 'longText',
      obscureText: variant == 'obscured',
      keyboardType: variant == 'number'
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: variant == 'number'
          ? [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))]
          : null,
      onChanged: (value) => write?.call(value),
      onSubmitted: (value) => write?.call(value),
    );
    return _withValidation(context, props, field, localError: formatError);
  },
);

final _slider = ComponentImplementation(
  name: 'Slider',
  schema: v0_9.BasicComponents.slider.schema,
  builder: (context, node, props, buildChild) {
    final min = props.number('min') ?? 0;
    final max = props.number('max') ?? 1;
    final write = _writer(node, props, 'value');
    final value = (props.number('value') ?? min).clamp(min, max);
    final field = shad.Slider(
      value: shad.SliderValue.single(value),
      min: min,
      max: max,
      onChanged: write == null ? null : (value) => write(value.value),
    );
    return _withValidation(context, props, field);
  },
);

final _tabs = ComponentImplementation(
  name: 'Tabs',
  schema: v0_9.BasicComponents.tabs.schema,
  builder: (context, node, props, buildChild) {
    final tabs = props.list('tabs').whereType<Map<String, Object?>>().toList();
    if (tabs.isEmpty) return const SizedBox.shrink();
    return _Tabs(
      titles: [
        for (final tab in tabs) ComponentProps.asString(tab['title']) ?? '',
      ],
      children: [
        for (final tab in tabs)
          switch (tab['child']) {
            final ComponentNode<ComponentImplementation> child => buildChild(
              child,
            ),
            _ => const SizedBox.shrink(),
          },
      ],
    );
  },
);

/// Tabs that keep the selected index themselves, since the A2UI basic
/// catalog's Tabs have no value to bind it to.
class _Tabs extends StatefulWidget {
  const _Tabs({required this.titles, required this.children});

  final List<String> titles;
  final List<Widget> children;

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final index = _index.clamp(0, widget.children.length - 1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shad.Tabs(
          index: index,
          onChanged: (value) => setState(() => _index = value),
          children: [
            for (final title in widget.titles) shad.TabItem(child: Text(title)),
          ],
        ),
        IndexedStack(index: index, children: widget.children),
      ],
    );
  }
}

final _choicePicker = ComponentImplementation(
  name: 'ChoicePicker',
  schema: v0_9.BasicComponents.choicePicker.schema,
  builder: (context, node, props, buildChild) {
    final rawValue = props.value('value');
    final selected = rawValue is List
        ? rawValue.whereType<String>().toSet()
        : rawValue is String
        ? {rawValue}
        : <String>{};
    final label = props.string('label');
    final write = _writer(node, props, 'value');
    final field = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label),
        for (final option in props.list('options'))
          if (option is Map<String, Object?> && option['value'] is String)
            shad.Checkbox(
              state: selected.contains(option['value'])
                  ? shad.CheckboxState.checked
                  : shad.CheckboxState.unchecked,
              trailing: Text(
                ComponentProps.asString(option['label']) ??
                    option['value']! as String,
              ),
              onChanged: write == null
                  ? null
                  : (state) {
                      final value = option['value']! as String;
                      final next = <String>{...selected};
                      if (props.string('variant') == 'mutuallyExclusive') {
                        next
                          ..clear()
                          ..add(value);
                      } else if (state == shad.CheckboxState.checked) {
                        next.add(value);
                      } else {
                        next.remove(value);
                      }
                      write(
                        props.string('variant') == 'mutuallyExclusive'
                            ? next.firstOrNull
                            : next.toList(),
                      );
                    },
            ),
      ],
    );
    return _withValidation(context, props, field);
  },
);

final _dateTimeInput = ComponentImplementation(
  name: 'DateTimeInput',
  schema: v0_9.BasicComponents.dateTimeInput.schema,
  builder: (context, node, props, buildChild) {
    final rawValue = props.string('value') ?? '';
    final value =
        DateTime.tryParse(rawValue) ??
        DateTime.tryParse('1970-01-01T$rawValue');
    final enableDate = props.boolean('enableDate') ?? false;
    final enableTime = props.boolean('enableTime') ?? false;
    final variant = enableDate == enableTime
        ? 'datetime'
        : enableDate
        ? 'date'
        : 'time';
    final min = DateTime.tryParse(props.string('min') ?? '');
    final max = DateTime.tryParse(props.string('max') ?? '');
    final write = _writer(node, props, 'value');

    void update(DateTime? next) {
      if (next == null) {
        write?.call(null);
        return;
      }
      final formatted = switch (variant) {
        'date' => next.toIso8601String().split('T').first,
        'time' =>
          '${next.hour.toString().padLeft(2, '0')}:'
              '${next.minute.toString().padLeft(2, '0')}:00',
        _ => next.toIso8601String(),
      };
      write?.call(formatted);
    }

    final placeholder = Text(
      props.string('label') ??
          (variant == 'time' ? 'Choose a time' : 'Choose a date'),
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
      onChanged: write == null
          ? null
          : (date) {
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
      onChanged: write == null
          ? null
          : (time) {
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
    final field = switch (variant) {
      'date' => datePicker,
      'time' => timePicker,
      _ => Column(
        mainAxisSize: MainAxisSize.min,
        children: [datePicker, const SizedBox(height: 8), timePicker],
      ),
    };
    return _withValidation(context, props, field);
  },
);

final _divider = ComponentImplementation(
  name: 'Divider',
  schema: v0_9.BasicComponents.divider.schema,
  builder: (context, node, props, buildChild) =>
      props.string('axis') == 'vertical'
      ? const shad.VerticalDivider()
      : const shad.Divider(),
);

final _icon = ComponentImplementation(
  name: 'Icon',
  schema: v0_9.BasicComponents.icon.schema,
  builder: (context, node, props, buildChild) =>
      Icon(_icons[props.string('name')] ?? shad.LucideIcons.circleHelp),
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

final _modal = ComponentImplementation(
  name: 'Modal',
  schema: v0_9.BasicComponents.modal.schema,
  builder: (context, node, props, buildChild) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => shad.showOverlay<void>(
        context,
        const shad.DialogConfiguration(),
        builder: (buildContext) => _child(props, 'content', buildChild),
      ),
      child: _child(props, 'trigger', buildChild),
    );
  },
);

/// The properties that any component may have besides its own: its weight
/// in a Row or Column, and its accessibility attributes.
final _commonProperties = {
  'weight': S.number(),
  'accessibility': CommonSchemas.accessibilityAttributes,
};

final _switchSchema = S.object(
  description: 'A shadcn switch with a two-way boolean value binding.',
  properties: {
    ..._commonProperties,
    'label': CommonSchemas.dynamicString,
    'value': CommonSchemas.dynamicBoolean,
  },
  required: ['label', 'value'],
);

final _switchItem = ComponentImplementation(
  name: 'Switch',
  schema: _switchSchema,
  builder: (context, node, props, buildChild) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        shad.Switch(
          value: props.boolean('value') ?? false,
          onChanged: _writer(node, props, 'value'),
        ),
        const SizedBox(width: 8),
        Text(props.string('label') ?? ''),
      ],
    );
  },
);

final _progressItem = ComponentImplementation(
  name: 'Progress',
  schema: S.object(
    description: 'A progress indicator.',
    properties: {
      ..._commonProperties,
      'value': CommonSchemas.dynamicNumber,
      'min': S.number(),
      'max': S.number(),
    },
    required: ['value'],
  ),
  builder: (context, node, props, buildChild) {
    final min = props.number('min') ?? 0;
    final max = props.number('max') ?? 1;
    return shad.Progress(
      progress: props.number('value')?.clamp(min, max),
      min: min,
      max: max,
    );
  },
);

/// Standard A2UI items rendered by shadcn_flutter.
abstract final class GenCatalog {
  GenCatalog._();

  static final ComponentImplementation text = _text;
  static final ComponentImplementation button = _button;
  static final ComponentImplementation card = _card;
  static final ComponentImplementation checkBox = _checkBox;
  static final ComponentImplementation choicePicker = _choicePicker;
  static final ComponentImplementation column = v0_9.BasicComponents.column;
  static final ComponentImplementation dateTimeInput = _dateTimeInput;
  static final ComponentImplementation divider = _divider;
  static final ComponentImplementation icon = _icon;
  static final ComponentImplementation list = v0_9.BasicComponents.list;
  static final ComponentImplementation modal = _modal;
  static final ComponentImplementation row = v0_9.BasicComponents.row;
  static final ComponentImplementation slider = _slider;
  static final ComponentImplementation tabs = _tabs;
  static final ComponentImplementation textField = _textField;
  static final ComponentImplementation switchItem = _switchItem;
  static final ComponentImplementation progress = _progressItem;

  static List<ComponentImplementation> get all => [
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
  ///
  /// [items] are added to the components, replacing one of the same name.
  /// [functions] are added to the basic A2UI functions, which format for
  /// [locale]. [openUrl] opens the URL of an `openUrl` call, which fails
  /// without it. [systemPromptFragments] follow the catalog's own rules in
  /// its instructions.
  static CatalogImplementation asCatalog({
    List<ComponentImplementation> items = const [],
    List<FunctionImplementation> functions = const [],
    List<String> systemPromptFragments = const [],
    String locale = 'en-US',
    OpenUrlCallback? openUrl,
  }) {
    return v0_9
        .basicCatalog(locale: locale, openUrl: openUrl)
        .derive(
          catalogId: shadcnFlutterCatalogId,
          components: const [],
          addComponents: [...all, ...items],
          addFunctions: [CloseModalFunction(), ...functions],
          instructions: [_catalogRules, ...systemPromptFragments].join('\n\n'),
        );
  }

  /// Creates the catalog of [asCatalog] under [shadcnFlutterCatalogId] and
  /// under each id of the standard A2UI v0.9 basic catalog, for a renderer
  /// whose agent may create surfaces with the basic catalog's id.
  static List<CatalogImplementation> asCatalogs({
    List<ComponentImplementation> items = const [],
    List<FunctionImplementation> functions = const [],
    List<String> systemPromptFragments = const [],
    String locale = 'en-US',
    OpenUrlCallback? openUrl,
  }) {
    final catalog = asCatalog(
      items: items,
      functions: functions,
      systemPromptFragments: systemPromptFragments,
      locale: locale,
      openUrl: openUrl,
    );
    return [
      catalog,
      for (final id in _basicCatalogIds)
        catalog.derive(catalogId: id, instructions: catalog.instructions),
    ];
  }
}
