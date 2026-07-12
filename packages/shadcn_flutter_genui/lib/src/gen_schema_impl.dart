part of 'gen_schema.dart';

/// Identity key for a field's live value in the [MultiModel] tree built by
/// [_GenWidget], one per (owning catalog item, field name).
class _GenFieldSymbol implements Symbol {
  const _GenFieldSymbol(this.owner, this.name);
  final GenCatalogItem owner;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _GenFieldSymbol &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          owner == other.owner;

  @override
  int get hashCode => Object.hash(owner, name);

  @override
  String toString() => 'GenFieldSymbol(${owner.name}.$name)';
}

/// Sentinel distinguishing "no example override set" from a legitimate
/// `null` override value.
const Object _unsetExample = Object();

/// Base for every concrete [GenField] implementation. One instance is
/// shared across all rendered widget instances; value access always goes
/// through the ambient [BuildContext].
abstract final class AbstractGenField<T> implements GenField<T> {
  AbstractGenField(this.owner, this.name, this.label);

  final GenCatalogItem owner;
  final String name;
  final String label;

  Object? _exampleOverride = _unsetExample;

  /// The example value set via [example], or [_unsetExample] if never set.
  Object? get exampleOverride => _exampleOverride;

  @override
  set example(T value) => _exampleOverride = serializeValue(value);

  /// False only for widget-reference fields: structural (a child component
  /// id), not part of the reactive data model.
  bool get needsSubscription => true;

  T deserializeValue(Object? raw, BuildContext context);
  Object? serializeValue(T value);

  /// Used when this field is the item shape of a `list`/`set`. Rebinds
  /// nested-object items against [elementPath] instead of this field's own
  /// resolved path. Scalars ignore [elementPath] and just deserialize
  /// [raw] directly.
  T deserializeElement(Object? raw, BuildContext context, String elementPath) =>
      deserializeValue(raw, context);

  /// Resolves this field's DataModel path for [itemContext]: an explicit
  /// `{'path': ...}` in the component's own JSON if present, otherwise a
  /// default flat path namespaced to this component instance.
  String resolvePath(CatalogItemContext itemContext) {
    final data = itemContext.data as JsonMap;
    final raw = data[name];
    if (raw is Map && raw.containsKey('path')) {
      return raw['path'] as String;
    }
    return '${itemContext.id}.$name';
  }

  @override
  T operator [](BuildContext context) {
    final Object? liveValue = Model.maybeOf<Object?>(
      context,
      _GenFieldSymbol(owner, name),
    );
    if (liveValue != null) {
      return deserializeValue(liveValue, context);
    }
    final itemContext = Data.of<CatalogItemContext>(context);
    final data = itemContext.data as JsonMap;
    final raw = data[name];
    final isPathRef = raw is Map && raw.containsKey('path');
    // Nothing written to the model yet: fall back to the literal the AI
    // authored directly in the component JSON (unless it was itself a
    // {'path': ...} reference, in which case there's genuinely nothing).
    return deserializeValue(isPathRef ? null : raw, context);
  }

  @override
  void operator []=(BuildContext context, T value) {
    final itemContext = Data.of<CatalogItemContext>(context);
    final path = resolvePath(itemContext);
    itemContext.dataContext.update(DataPath(path), serializeValue(value));
  }
}

/// Builds the JSON schema for a [GenCatalogItem] and the [AbstractGenField]
/// handles its [GenSchema.buildWidget] closes over.
class _GenFieldDescriptorImpl implements GenFieldDescriptor {
  _GenFieldDescriptorImpl(this.owner, this.registry);

  final GenCatalogItem owner;
  final GenSystemFunctionRegistry registry;

  final Map<String, Schema> properties = {};
  final List<String> required = [];
  final List<AbstractGenField> fields = [];

  /// Already-JSON-encodable example values declared via each field's own
  /// `example:` parameter. Feeds [buildExampleComponent], the sole source
  /// of a [GenCatalogItem]'s `exampleData`.
  final Map<String, Object?> exampleValues = {};

  /// Extra example components generated for `widget`/`widgetList` fields'
  /// text examples (each becomes its own entry alongside the root
  /// component in the example JSON array).
  final List<JsonMap> extraExampleComponents = [];

  int _exampleChildCounter = 0;

  /// Describes [factory] (a schema referenced from a `widget()`/
  /// `widgetList()` field's `example:`), collects its own generated example
  /// JSON as a new entry in [extraExampleComponents] (plus any further
  /// nested widget examples it declares), and returns its id.
  String _addWidgetExampleChild(GenSchema Function() factory) {
    final schema = factory();
    final nested = _GenFieldDescriptorImpl(owner, registry);
    schema.describeFields(nested);
    schema._exampleCustomizer?.call(schema);
    final componentName = schema.componentName;
    if (componentName == null) {
      throw ArgumentError(
        '${schema.runtimeType} must override componentName to be used as a '
        'widget()/widgetList() example.',
      );
    }
    final id = '${owner.name}Example${_exampleChildCounter++}';
    extraExampleComponents.add(nested.buildExampleComponentAs(id, componentName));
    extraExampleComponents.addAll(nested.extraExampleComponents);
    return id;
  }

  void _register(
    String name,
    Schema schema,
    AbstractGenField field, {
    bool isRequired = true,
  }) {
    properties[name] = schema;
    if (isRequired) required.add(name);
    fields.add(field);
  }

  void _deregister(AbstractGenField field) {
    properties.remove(field.name);
    required.remove(field.name);
    fields.remove(field);
  }

  ObjectSchema buildDataSchema() => S.object(
    description: owner.label,
    properties: properties,
    required: required,
  ) as ObjectSchema;

  JsonMap buildExampleComponent(String id) =>
      buildExampleComponentAs(id, owner.name);

  JsonMap buildExampleComponentAs(String id, String componentName) => {
    'id': id,
    'component': componentName,
    ..._collectExampleValues(),
  };

  /// Merges the declaratively-collected [exampleValues] with any per-field
  /// [AbstractGenField.exampleOverride] set afterward (e.g. via
  /// [GenSchemaExampleX.withExample]) — overrides win.
  Map<String, Object?> _collectExampleValues() {
    final values = Map<String, Object?>.of(exampleValues);
    for (final field in fields) {
      final override = field.exampleOverride;
      if (!identical(override, _unsetExample)) values[field.name] = override;
    }
    return values;
  }

  @override
  GenField<String> string(String name, {required String label, String? example}) {
    final field = _ScalarGenField<String>(owner, name, label, _asString, _identity);
    _register(name, A2uiSchemas.stringReference(description: label), field);
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<String?> optionalString(
    String name, {
    required String label,
    String? example,
  }) {
    final field = _ScalarGenField<String?>(
      owner,
      name,
      label,
      _asOptionalString,
      _identity,
    );
    _register(
      name,
      A2uiSchemas.stringReference(description: label),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<bool> boolean(String name, {required String label, bool? example}) {
    final field = _ScalarGenField<bool>(owner, name, label, _asBool, _identity);
    _register(name, A2uiSchemas.booleanReference(description: label), field);
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<bool?> optionalBoolean(
    String name, {
    required String label,
    bool? example,
  }) {
    final field = _ScalarGenField<bool?>(
      owner,
      name,
      label,
      _asOptionalBool,
      _identity,
    );
    _register(
      name,
      A2uiSchemas.booleanReference(description: label),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<int> integer(String name, {required String label, int? example}) {
    final field = _ScalarGenField<int>(owner, name, label, _asInt, _identity);
    _register(name, A2uiSchemas.numberReference(description: label), field);
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<int?> optionalInteger(
    String name, {
    required String label,
    int? example,
  }) {
    final field = _ScalarGenField<int?>(
      owner,
      name,
      label,
      _asOptionalInt,
      _identity,
    );
    _register(
      name,
      A2uiSchemas.numberReference(description: label),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<double> decimal(String name, {required String label, double? example}) {
    final field = _ScalarGenField<double>(owner, name, label, _asDouble, _identity);
    _register(name, A2uiSchemas.numberReference(description: label), field);
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<double?> optionalDecimal(
    String name, {
    required String label,
    double? example,
  }) {
    final field = _ScalarGenField<double?>(
      owner,
      name,
      label,
      _asOptionalDouble,
      _identity,
    );
    _register(
      name,
      A2uiSchemas.numberReference(description: label),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example;
    return field;
  }

  @override
  GenField<Widget> widget(
    String name, {
    required String label,
    GenSchema Function()? example,
  }) {
    final field = _WidgetGenField(owner, name, label);
    _register(name, A2uiSchemas.componentReference(description: label), field);
    if (example != null) exampleValues[name] = _addWidgetExampleChild(example);
    return field;
  }

  @override
  GenField<Widget?> optionalWidget(
    String name, {
    required String label,
    GenSchema Function()? example,
  }) {
    final field = _OptionalWidgetGenField(owner, name, label);
    _register(
      name,
      A2uiSchemas.componentReference(description: label),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = _addWidgetExampleChild(example);
    return field;
  }

  @override
  GenField<List<Widget>> widgetList(
    String name, {
    required String label,
    List<GenSchema Function()>? example,
  }) {
    final field = _WidgetListGenField(owner, name, label);
    _register(name, A2uiSchemas.componentArrayReference(description: label), field);
    if (example != null) {
      exampleValues[name] = [
        for (final factory in example) _addWidgetExampleChild(factory),
      ];
    }
    return field;
  }

  @override
  GenField<T> enumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  }) {
    final field = _EnumGenField<T>(owner, name, label, values);
    _register(name, _enumSchema(values, label), field);
    if (example != null) exampleValues[name] = example.name;
    return field;
  }

  @override
  GenField<T?> optionalEnumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  }) {
    final field = _OptionalEnumGenField<T>(owner, name, label, values);
    _register(name, _enumSchema(values, label), field, isRequired: false);
    if (example != null) exampleValues[name] = example.name;
    return field;
  }

  @override
  GenField<List<T>> list<T>(
    String name, {
    required String label,
    required GenField<T> item,
    List<T>? example,
  }) {
    final itemField = item as AbstractGenField<T>;
    final itemSchema = properties[itemField.name]!;
    _deregister(itemField);
    final field = _ListGenField<T>(owner, name, label, itemField);
    _register(
      name,
      A2uiSchemas.listOrReference(items: itemSchema, description: label),
      field,
    );
    if (example != null) {
      exampleValues[name] = [for (final e in example) itemField.serializeValue(e)];
    }
    return field;
  }

  @override
  GenField<List<T>?> optionalList<T>(
    String name, {
    required String label,
    required GenField<T> item,
    List<T>? example,
  }) {
    final itemField = item as AbstractGenField<T>;
    final itemSchema = properties[itemField.name]!;
    _deregister(itemField);
    final field = _OptionalListGenField<T>(owner, name, label, itemField);
    _register(
      name,
      A2uiSchemas.listOrReference(items: itemSchema, description: label),
      field,
      isRequired: false,
    );
    if (example != null) {
      exampleValues[name] = [for (final e in example) itemField.serializeValue(e)];
    }
    return field;
  }

  @override
  GenField<Map<K, V>> map<K, V>(
    String name, {
    required String label,
    required GenField<K> key,
    required GenField<V> value,
    Map<K, V>? example,
  }) {
    final keyField = key as AbstractGenField<K>;
    final valueField = value as AbstractGenField<V>;
    final entrySchema = _mapEntrySchema(keyField, valueField);
    _deregister(keyField);
    _deregister(valueField);
    final field = _MapGenField<K, V>(owner, name, label, keyField, valueField);
    _register(
      name,
      A2uiSchemas.listOrReference(items: entrySchema, description: label),
      field,
    );
    if (example != null) {
      exampleValues[name] = [
        for (final e in example.entries)
          {
            'key': keyField.serializeValue(e.key),
            'value': valueField.serializeValue(e.value),
          },
      ];
    }
    return field;
  }

  @override
  GenField<Map<K, V>?> optionalMap<K, V>(
    String name, {
    required String label,
    required GenField<K> key,
    required GenField<V> value,
    Map<K, V>? example,
  }) {
    final keyField = key as AbstractGenField<K>;
    final valueField = value as AbstractGenField<V>;
    final entrySchema = _mapEntrySchema(keyField, valueField);
    _deregister(keyField);
    _deregister(valueField);
    final field = _OptionalMapGenField<K, V>(
      owner,
      name,
      label,
      keyField,
      valueField,
    );
    _register(
      name,
      A2uiSchemas.listOrReference(items: entrySchema, description: label),
      field,
      isRequired: false,
    );
    if (example != null) {
      exampleValues[name] = [
        for (final e in example.entries)
          {
            'key': keyField.serializeValue(e.key),
            'value': valueField.serializeValue(e.value),
          },
      ];
    }
    return field;
  }

  @override
  GenField<Set<T>> set<T>(
    String name, {
    required String label,
    required GenField<T> item,
    Set<T>? example,
  }) {
    final itemField = item as AbstractGenField<T>;
    final itemSchema = properties[itemField.name]!;
    _deregister(itemField);
    final field = _SetGenField<T>(owner, name, label, itemField);
    _register(name, _setOrReference(itemSchema, label), field);
    if (example != null) {
      exampleValues[name] = [for (final e in example) itemField.serializeValue(e)];
    }
    return field;
  }

  @override
  GenField<Set<T>?> optionalSet<T>(
    String name, {
    required String label,
    required GenField<T> item,
    Set<T>? example,
  }) {
    final itemField = item as AbstractGenField<T>;
    final itemSchema = properties[itemField.name]!;
    _deregister(itemField);
    final field = _OptionalSetGenField<T>(owner, name, label, itemField);
    _register(name, _setOrReference(itemSchema, label), field, isRequired: false);
    if (example != null) {
      exampleValues[name] = [for (final e in example) itemField.serializeValue(e)];
    }
    return field;
  }

  @override
  GenField<T> object<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  }) {
    final schemaDescriptor = _GenDataFieldDescriptorImpl.schemaOnly();
    object.describeFields(schemaDescriptor);
    final field = _ObjectGenField<T>(owner, name, label, object);
    _register(
      name,
      S.object(
        properties: schemaDescriptor.properties,
        required: schemaDescriptor.required,
        description: label,
      ),
      field,
    );
    // The object's own field declarations (inside its describeFields) carry
    // their own `example:` values, collected here during the same schema
    // pass that just ran.
    if (schemaDescriptor.exampleValues.isNotEmpty) {
      exampleValues[name] = Map.of(schemaDescriptor.exampleValues);
    }
    return field;
  }

  @override
  GenField<GenActionDispatcher> action(
    String name, {
    required String label,
    List<GenActionParameter<Object?>> parameters = const [],
    GenActionExample? example,
  }) {
    final field = _ActionGenField(owner, name, label, registry);
    _register(name, _actionFieldSchema(label, parameters, registry), field);
    if (example != null) exampleValues[name] = example.toJson();
    return field;
  }

  @override
  GenField<GenActionDispatcher?> optionalAction(
    String name, {
    required String label,
    List<GenActionParameter<Object?>> parameters = const [],
    GenActionExample? example,
  }) {
    final field = _OptionalActionGenField(owner, name, label, registry);
    _register(
      name,
      _actionFieldSchema(label, parameters, registry),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example.toJson();
    return field;
  }

  @override
  GenField<GenValueActionDispatcher<T>> valueAction<T>(
    String name, {
    required String label,
    required GenActionParameter<T> parameter,
    GenActionExample? example,
  }) {
    final field = _ValueActionGenField<T>(owner, name, label, parameter, registry);
    _register(name, _actionFieldSchema(label, [parameter], registry), field);
    if (example != null) exampleValues[name] = example.toJson();
    return field;
  }

  @override
  GenField<GenValueActionDispatcher<T>?> optionalValueAction<T>(
    String name, {
    required String label,
    required GenActionParameter<T> parameter,
    GenActionExample? example,
  }) {
    final field = _OptionalValueActionGenField<T>(
      owner,
      name,
      label,
      parameter,
      registry,
    );
    _register(
      name,
      _actionFieldSchema(label, [parameter], registry),
      field,
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example.toJson();
    return field;
  }

  @override
  GenField<Validator<T>?> validators<T>(
    String fieldName, {
    required List<GenValidator<T>> available,
    List<JsonMap>? example,
  }) {
    final propertyName = '${fieldName}_validators';
    final field = _ValidatorsGenField<T>(owner, propertyName, propertyName, available);
    _register(propertyName, _validatorsFieldSchema(available), field, isRequired: false);
    if (example != null) exampleValues[propertyName] = example;
    return field;
  }
}

Schema _validatorsFieldSchema<T>(List<GenValidator<T>> available) {
  final kindSchemas = <Schema>[
    for (final kind in available) _validatorKindSchema(kind),
  ];
  return S.list(
    description: 'Validation rules for this field.',
    items: kindSchemas.length == 1 ? kindSchemas.first : S.combined(oneOf: kindSchemas),
  );
}

Schema _validatorKindSchema<T>(GenValidator<T> kind) {
  final schemaDescriptor = _GenDataFieldDescriptorImpl.schemaOnly();
  kind.describeFields(schemaDescriptor);
  return S.object(
    properties: {
      'kind': S.string(enumValues: [kind.kind]),
      ...schemaDescriptor.properties,
    },
    required: ['kind', ...schemaDescriptor.required],
  );
}

Object? _identity(Object? v) => v;

String _asString(Object? raw) => raw?.toString() ?? '';
String? _asOptionalString(Object? raw) => raw?.toString();
bool _asBool(Object? raw) {
  if (raw is bool) return raw;
  if (raw is String) return raw.toLowerCase() == 'true';
  return false;
}

bool? _asOptionalBool(Object? raw) => raw == null ? null : _asBool(raw);
int _asInt(Object? raw) {
  if (raw is num) return raw.round();
  return int.tryParse('$raw') ?? 0;
}

int? _asOptionalInt(Object? raw) => raw == null ? null : _asInt(raw);
double _asDouble(Object? raw) {
  if (raw is num) return raw.toDouble();
  return double.tryParse('$raw') ?? 0.0;
}

double? _asOptionalDouble(Object? raw) => raw == null ? null : _asDouble(raw);

Schema _enumSchema<T extends Enum>(List<T> values, String label) => S.combined(
  description: label,
  oneOf: [
    S.string(enumValues: [for (final v in values) v.name]),
    A2uiSchemas.dataBindingSchema(),
    A2uiSchemas.functionCall(),
  ],
);

Schema _mapEntrySchema(AbstractGenField key, AbstractGenField value) =>
    S.object(
      properties: {
        'key': S.any(description: key.label),
        'value': S.any(description: value.label),
      },
      required: ['key', 'value'],
    );

Schema _setOrReference(Schema items, String? description) {
  final literal = S.list(items: items, uniqueItems: true);
  final binding = A2uiSchemas.dataBindingSchema(description: 'A path to a set.');
  final function = A2uiSchemas.functionCall();
  return S.combined(oneOf: [literal, binding, function], description: description);
}

class _GenWidget extends StatefulWidget {
  const _GenWidget({
    required this.itemContext,
    required this.catalogItem,
    required this.schema,
    required this.descriptor,
  });

  final CatalogItemContext itemContext;
  final GenCatalogItem catalogItem;
  final GenSchema schema;
  final _GenFieldDescriptorImpl descriptor;

  @override
  State<_GenWidget> createState() => _GenWidgetState();
}

class _GenWidgetState extends State<_GenWidget> {
  final Map<String, ValueNotifier<Object?>> _fieldNotifiers = {};
  @override
  void initState() {
    super.initState();
    _subscribeAll();
  }

  @override
  void didUpdateWidget(covariant _GenWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemContext.dataContext != widget.itemContext.dataContext ||
        oldWidget.itemContext.id != widget.itemContext.id ||
        oldWidget.descriptor != widget.descriptor) {
      _unsubscribeAll();
      _subscribeAll();
    }
  }

  void _subscribeAll() {
    final itemContext = widget.itemContext;
    for (final field in widget.descriptor.fields) {
      if (!field.needsSubscription) continue;
      final path = DataPath(field.resolvePath(itemContext));
      _fieldNotifiers[field.name] = itemContext.dataContext.subscribe<Object?>(path);
    }
  }

  void _unsubscribeAll() {
    for (final notifier in _fieldNotifiers.values) {
      notifier.dispose();
    }
    _fieldNotifiers.clear();
  }

  @override
  void dispose() {
    _unsubscribeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemContext = widget.itemContext;
    return Data<CatalogItemContext>.inherit(
      data: itemContext,
      child: Actions(
        actions: {GenSystemFunctionIntent: GenSystemFunctionAction()},
        child: MultiModel(
          data: [
            for (final field in widget.descriptor.fields)
              if (_fieldNotifiers[field.name] case final notifier?)
                ModelListenable<Object?>(
                  _GenFieldSymbol(widget.catalogItem, field.name),
                  notifier,
                ),
          ],
          child: Builder(
            builder: (innerContext) => widget.schema.buildWidget(innerContext),
          ),
        ),
      ),
    );
  }
}

/// Converts a [GenCatalogItem] into a genui [CatalogItem], using [registry]
/// to resolve any `functionCall`s its `action`/`optionalAction` fields
/// reference. Prefer [GenCatalog.asCatalog], which builds one registry and
/// calls this once per shipped widget.
CatalogItem genCatalogItemToCatalogItem(
  GenCatalogItem genCatalogItem,
  GenSystemFunctionRegistry registry,
) {
  final schema = genCatalogItem.schema();
  final descriptor = _GenFieldDescriptorImpl(genCatalogItem, registry);
  schema.describeFields(descriptor);
  final dataSchema = descriptor.buildDataSchema();
  return CatalogItem(
    name: genCatalogItem.name,
    dataSchema: dataSchema,
    exampleData: [
      () => jsonEncode([
        descriptor.buildExampleComponent('root'),
        ...descriptor.extraExampleComponents,
      ]),
    ],
    widgetBuilder: (CatalogItemContext itemContext) {
      return _GenWidget(
        itemContext: itemContext,
        catalogItem: genCatalogItem,
        schema: schema,
        descriptor: descriptor,
      );
    },
  );
}

/// Wraps [field] in a shadcn_flutter [FormEntry], registering it with
/// whatever ambient [Form]/[FormController] exists (a no-op if there's
/// none) so it participates in a real shadcn form: validated via
/// [validator] (built from a [GenFieldDescriptor.validators] field).
///
/// This is registration only — a widget's own `buildWidget` never renders
/// validation error text itself; that's not an individual field's concern.
/// Anything that wants to *display* a field's validity reads it from the
/// ambient [FormController]/[FormEntryErrorBuilder] independently.
///
/// Takes [context] rather than a `CatalogItemContext` so widget files never
/// need to touch genui types directly.
Widget wrapFormEntry<T>({
  required BuildContext context,
  required Validator<T>? validator,
  required Widget field,
}) {
  final itemContext = Data.of<CatalogItemContext>(context);
  return FormEntry<T>(
    key: FormKey<T>(itemContext.id),
    validator: validator,
    child: field,
  );
}
