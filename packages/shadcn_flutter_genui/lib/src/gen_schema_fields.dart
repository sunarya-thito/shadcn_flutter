part of 'gen_schema.dart';

/// A field whose (de)serialization is just a pair of pure functions.
/// Covers string/bool/int/double, required and optional alike.
final class _ScalarGenField<T> extends AbstractGenField<T> {
  _ScalarGenField(
    super.owner,
    super.name,
    super.label,
    this._deserialize,
    this._serialize,
  );

  final T Function(Object? raw) _deserialize;
  final Object? Function(T value) _serialize;

  @override
  T deserializeValue(Object? raw, BuildContext context) => _deserialize(raw);

  @override
  Object? serializeValue(T value) => _serialize(value);
}

final class _EnumGenField<T extends Enum> extends AbstractGenField<T> {
  _EnumGenField(super.owner, super.name, super.label, this.values);
  final List<T> values;

  @override
  T deserializeValue(Object? raw, BuildContext context) {
    if (raw is String) {
      for (final v in values) {
        if (v.name == raw) return v;
      }
    }
    return values.first;
  }

  @override
  Object? serializeValue(T value) => value.name;
}

final class _OptionalEnumGenField<T extends Enum> extends AbstractGenField<T?> {
  _OptionalEnumGenField(super.owner, super.name, super.label, this.values);
  final List<T> values;

  @override
  T? deserializeValue(Object? raw, BuildContext context) {
    if (raw is String) {
      for (final v in values) {
        if (v.name == raw) return v;
      }
    }
    return null;
  }

  @override
  Object? serializeValue(T? value) => value?.name;
}

/// A structural reference to a child component built by genui. Not stored
/// in the DataModel at all.
final class _WidgetGenField extends AbstractGenField<Widget> {
  _WidgetGenField(super.owner, super.name, super.label);

  @override
  bool get needsSubscription => false;

  @override
  Widget deserializeValue(Object? raw, BuildContext context) {
    if (raw is! String) {
      throw StateError('widget field "$name" requires a child component id');
    }
    final itemContext = Data.of<CatalogItemContext>(context);
    return itemContext.buildChild(raw);
  }

  @override
  Object? serializeValue(Widget value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );

  @override
  Widget operator [](BuildContext context) {
    final itemContext = Data.of<CatalogItemContext>(context);
    final data = itemContext.data as JsonMap;
    return deserializeValue(data[name], context);
  }

  @override
  void operator []=(BuildContext context, Widget value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );
}

final class _OptionalWidgetGenField extends AbstractGenField<Widget?> {
  _OptionalWidgetGenField(super.owner, super.name, super.label);

  @override
  bool get needsSubscription => false;

  @override
  Widget? deserializeValue(Object? raw, BuildContext context) {
    if (raw is! String) return null;
    final itemContext = Data.of<CatalogItemContext>(context);
    return itemContext.buildChild(raw);
  }

  @override
  Object? serializeValue(Widget? value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );

  @override
  Widget? operator [](BuildContext context) {
    final itemContext = Data.of<CatalogItemContext>(context);
    final data = itemContext.data as JsonMap;
    return deserializeValue(data[name], context);
  }

  @override
  void operator []=(BuildContext context, Widget? value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );
}

/// A list of child-component references, e.g. tab panes or accordion
/// bodies. Like [_WidgetGenField], not stored in the DataModel.
final class _WidgetListGenField extends AbstractGenField<List<Widget>> {
  _WidgetListGenField(super.owner, super.name, super.label);

  @override
  bool get needsSubscription => false;

  @override
  List<Widget> deserializeValue(Object? raw, BuildContext context) {
    if (raw is! List) return const [];
    final itemContext = Data.of<CatalogItemContext>(context);
    return [
      for (final id in raw)
        if (id is String) itemContext.buildChild(id),
    ];
  }

  @override
  Object? serializeValue(List<Widget> value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );

  @override
  List<Widget> operator [](BuildContext context) {
    final itemContext = Data.of<CatalogItemContext>(context);
    final data = itemContext.data as JsonMap;
    return deserializeValue(data[name], context);
  }

  @override
  void operator []=(BuildContext context, List<Widget> value) => throw UnsupportedError(
    'widget fields are read-only (structural, AI-authored)',
  );
}

final class _ListGenField<T> extends AbstractGenField<List<T>> {
  _ListGenField(super.owner, super.name, super.label, this.item);
  final AbstractGenField<T> item;

  @override
  List<T> deserializeValue(Object? raw, BuildContext context) {
    if (raw is! List) return const [];
    final itemContext = Data.of<CatalogItemContext>(context);
    final basePath = resolvePath(itemContext);
    return [
      for (var i = 0; i < raw.length; i++)
        item.deserializeElement(raw[i], context, '$basePath.$i'),
    ];
  }

  @override
  Object? serializeValue(List<T> value) => [
    for (final v in value) item.serializeValue(v),
  ];
}

final class _OptionalListGenField<T> extends AbstractGenField<List<T>?> {
  _OptionalListGenField(super.owner, super.name, super.label, this.item)
    : _inner = _ListGenField<T>(owner, name, label, item);
  final AbstractGenField<T> item;
  final _ListGenField<T> _inner;

  @override
  List<T>? deserializeValue(Object? raw, BuildContext context) =>
      raw == null ? null : _inner.deserializeValue(raw, context);

  @override
  Object? serializeValue(List<T>? value) =>
      value == null ? null : _inner.serializeValue(value);
}

final class _SetGenField<T> extends AbstractGenField<Set<T>> {
  _SetGenField(super.owner, super.name, super.label, this.item);
  final AbstractGenField<T> item;

  @override
  Set<T> deserializeValue(Object? raw, BuildContext context) {
    if (raw is! List) return const {};
    return {for (final e in raw) item.deserializeValue(e, context)};
  }

  @override
  Object? serializeValue(Set<T> value) => [
    for (final v in value) item.serializeValue(v),
  ];
}

final class _OptionalSetGenField<T> extends AbstractGenField<Set<T>?> {
  _OptionalSetGenField(super.owner, super.name, super.label, this.item)
    : _inner = _SetGenField<T>(owner, name, label, item);
  final AbstractGenField<T> item;
  final _SetGenField<T> _inner;

  @override
  Set<T>? deserializeValue(Object? raw, BuildContext context) =>
      raw == null ? null : _inner.deserializeValue(raw, context);

  @override
  Object? serializeValue(Set<T>? value) =>
      value == null ? null : _inner.serializeValue(value);
}

final class _MapGenField<K, V> extends AbstractGenField<Map<K, V>> {
  _MapGenField(
    super.owner,
    super.name,
    super.label,
    this.keyField,
    this.valueField,
  );
  final AbstractGenField<K> keyField;
  final AbstractGenField<V> valueField;

  @override
  Map<K, V> deserializeValue(Object? raw, BuildContext context) {
    if (raw is! List) return const {};
    final result = <K, V>{};
    for (final entry in raw) {
      if (entry is! Map) continue;
      final k = keyField.deserializeValue(entry['key'], context);
      final v = valueField.deserializeValue(entry['value'], context);
      result[k] = v;
    }
    return result;
  }

  @override
  Object? serializeValue(Map<K, V> value) => [
    for (final e in value.entries)
      {
        'key': keyField.serializeValue(e.key),
        'value': valueField.serializeValue(e.value),
      },
  ];
}

final class _OptionalMapGenField<K, V> extends AbstractGenField<Map<K, V>?> {
  _OptionalMapGenField(
    super.owner,
    super.name,
    super.label,
    this.keyField,
    this.valueField,
  ) : _inner = _MapGenField<K, V>(owner, name, label, keyField, valueField);
  final AbstractGenField<K> keyField;
  final AbstractGenField<V> valueField;
  final _MapGenField<K, V> _inner;

  @override
  Map<K, V>? deserializeValue(Object? raw, BuildContext context) =>
      raw == null ? null : _inner.deserializeValue(raw, context);

  @override
  Object? serializeValue(Map<K, V>? value) =>
      value == null ? null : _inner.serializeValue(value);
}

/// A nested [GenObject]. `object<T>`'s prototype is used only to know the
/// shape; every read builds a *fresh*, live-bound copy so that the same
/// declaration works whether it appears once or as a `list<GenObject>`
/// item, each element needing its own independent binding.
final class _ObjectGenField<T extends GenObject> extends AbstractGenField<T> {
  _ObjectGenField(super.owner, super.name, super.label, this.prototype);
  final T prototype;

  @override
  T deserializeValue(Object? raw, BuildContext context) {
    final itemContext = Data.of<CatalogItemContext>(context);
    return _bind(itemContext, resolvePath(itemContext));
  }

  @override
  T deserializeElement(Object? raw, BuildContext context, String elementPath) {
    final itemContext = Data.of<CatalogItemContext>(context);
    return _bind(itemContext, elementPath);
  }

  T _bind(CatalogItemContext itemContext, String basePath) {
    final copy = prototype.copy() as T;
    final storage = _DataContextFieldStorage(itemContext.dataContext, basePath);
    final descriptor = _GenDataFieldDescriptorImpl(storage);
    copy.describeFields(descriptor);
    return copy;
  }

  @override
  Object? serializeValue(T value) {
    throw UnsupportedError(
      "object fields are read-only from the outside; write through the "
      "returned GenObject's own GenDataFields instead",
    );
  }
}

final class _ActionGenField extends AbstractGenField<GenActionDispatcher> {
  _ActionGenField(super.owner, super.name, super.label, this.registry);
  final GenSystemFunctionRegistry registry;

  @override
  GenActionDispatcher deserializeValue(Object? raw, BuildContext context) =>
      _GenActionDispatcherImpl(_parseActionNode(raw), registry);

  @override
  Object? serializeValue(GenActionDispatcher value) =>
      throw UnsupportedError('action fields are AI-authored and read-only');
}

final class _OptionalActionGenField extends AbstractGenField<GenActionDispatcher?> {
  _OptionalActionGenField(
    super.owner,
    super.name,
    super.label,
    this.registry,
  );
  final GenSystemFunctionRegistry registry;

  @override
  GenActionDispatcher? deserializeValue(Object? raw, BuildContext context) {
    if (raw == null) return null;
    return _GenActionDispatcherImpl(_parseActionNode(raw), registry);
  }

  @override
  Object? serializeValue(GenActionDispatcher? value) =>
      throw UnsupportedError('action fields are AI-authored and read-only');
}

final class _ValueActionGenField<T>
    extends AbstractGenField<GenValueActionDispatcher<T>> {
  _ValueActionGenField(
    super.owner,
    super.name,
    super.label,
    this.parameter,
    this.registry,
  );
  final GenActionParameter<T> parameter;
  final GenSystemFunctionRegistry registry;

  @override
  GenValueActionDispatcher<T> deserializeValue(Object? raw, BuildContext context) =>
      _GenValueActionDispatcherImpl<T>(
        _GenActionDispatcherImpl(_parseActionNode(raw), registry),
        parameter,
      );

  @override
  Object? serializeValue(GenValueActionDispatcher<T> value) =>
      throw UnsupportedError('action fields are AI-authored and read-only');
}

final class _OptionalValueActionGenField<T>
    extends AbstractGenField<GenValueActionDispatcher<T>?> {
  _OptionalValueActionGenField(
    super.owner,
    super.name,
    super.label,
    this.parameter,
    this.registry,
  );
  final GenActionParameter<T> parameter;
  final GenSystemFunctionRegistry registry;

  @override
  GenValueActionDispatcher<T>? deserializeValue(Object? raw, BuildContext context) {
    if (raw == null) return null;
    return _GenValueActionDispatcherImpl<T>(
      _GenActionDispatcherImpl(_parseActionNode(raw), registry),
      parameter,
    );
  }

  @override
  Object? serializeValue(GenValueActionDispatcher<T>? value) =>
      throw UnsupportedError('action fields are AI-authored and read-only');
}

/// Parses the AI's JSON list of `{'kind': ..., ...}` entries into one
/// composed shadcn_flutter [Validator], matching each entry's `kind` against
/// [available] and binding that kind's own declared parameters straight out
/// of the entry via [_MapFieldStorage].
final class _ValidatorsGenField<T> extends AbstractGenField<Validator<T>?> {
  _ValidatorsGenField(super.owner, super.name, super.label, this.available);
  final List<GenValidator<T>> available;

  GenValidator<T>? _findKind(Object? kind) {
    for (final v in available) {
      if (v.kind == kind) return v;
    }
    return null;
  }

  @override
  Validator<T>? deserializeValue(Object? raw, BuildContext context) {
    if (raw is! List || raw.isEmpty) return null;
    Validator<T>? combined;
    for (final entry in raw) {
      if (entry is! Map) continue;
      final kind = _findKind(entry['kind']);
      if (kind == null) continue;
      final descriptor = _GenDataFieldDescriptorImpl(
        _MapFieldStorage(Map<String, Object?>.from(entry)),
      );
      kind.describeFields(descriptor);
      final validator = kind.build();
      combined = combined == null ? validator : combined & validator;
    }
    return combined;
  }

  @override
  Object? serializeValue(Validator<T>? value) =>
      throw UnsupportedError('validators fields are AI-authored and read-only');
}
