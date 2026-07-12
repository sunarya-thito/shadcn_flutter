part of 'gen_schema.dart';

/// Where a [GenDataField]'s value actually lives: a plain [Map] for
/// one-shot [GenSystemFunction] arguments and schema-only passes, or a live
/// [DataContext] sub-path for [GenObject] fields nested inside a widget.
abstract class _FieldStorage {
  Object? read(String key);
  void write(String key, Object? value);
  _FieldStorage scoped(String key);
}

class _MapFieldStorage implements _FieldStorage {
  _MapFieldStorage(this.map);
  final Map<String, Object?> map;

  @override
  Object? read(String key) => map[key];

  @override
  void write(String key, Object? value) => map[key] = value;

  @override
  _FieldStorage scoped(String key) {
    final nested = map[key];
    if (nested is Map<String, Object?>) return _MapFieldStorage(nested);
    final created = <String, Object?>{};
    map[key] = created;
    return _MapFieldStorage(created);
  }
}

class _DataContextFieldStorage implements _FieldStorage {
  _DataContextFieldStorage(this.dataContext, this.basePath);
  final DataContext dataContext;
  final String basePath;

  @override
  Object? read(String key) =>
      dataContext.getValue<Object?>(DataPath('$basePath.$key'));

  @override
  void write(String key, Object? value) =>
      dataContext.update(DataPath('$basePath.$key'), value);

  @override
  _FieldStorage scoped(String key) =>
      _DataContextFieldStorage(dataContext, '$basePath.$key');
}

/// A plain get/set [GenDataField] whose (de)serialization is a pair of pure
/// functions. Covers string/bool/int/double/enum, required and optional.
final class _LiveGenDataField<T> implements GenDataField<T> {
  _LiveGenDataField(
    this.storage,
    this.key,
    this._deserialize,
    this._serialize,
  );

  final _FieldStorage? storage;
  final String key;
  final T Function(Object? raw) _deserialize;
  final Object? Function(T value) _serialize;

  _FieldStorage _requireStorage() {
    final s = storage;
    if (s == null) {
      throw StateError(
        'GenDataField "$key" has no live storage (this is a schema-only pass)',
      );
    }
    return s;
  }

  @override
  T get value => _deserialize(_requireStorage().read(key));

  @override
  set value(T newValue) => _requireStorage().write(key, _serialize(newValue));
}

/// A nested [GenObject] data field. Every read builds a fresh, live-bound
/// copy scoped one level deeper than its own storage.
final class _LiveGenObjectDataField<T extends GenObject>
    implements GenDataField<T> {
  _LiveGenObjectDataField(this.storage, this.key, this.prototype);
  final _FieldStorage? storage;
  final String key;
  final T prototype;

  @override
  T get value {
    final s = storage;
    if (s == null) {
      throw StateError(
        'GenDataField "$key" has no live storage (this is a schema-only pass)',
      );
    }
    final copy = prototype.copy() as T;
    final nestedDescriptor = _GenDataFieldDescriptorImpl(s.scoped(key));
    copy.describeFields(nestedDescriptor);
    return copy;
  }

  @override
  set value(T newValue) => throw UnsupportedError(
    "object data fields are read-only; write through the returned "
    "GenObject's own fields instead",
  );
}

/// A list/set/map [GenDataField]. The whole collection is one JSON value
/// under [key]; items are (de)serialized with the item field's own codec,
/// and object items are rebound per-index against a scoped storage.
final class _LiveListGenDataField<T> implements GenDataField<List<T>> {
  _LiveListGenDataField(this.storage, this.key, this.itemBuilder);
  final _FieldStorage? storage;
  final String key;
  final GenDataField<T> Function(_FieldStorage? storage, String key) itemBuilder;

  @override
  List<T> get value {
    final s = storage;
    if (s == null) {
      throw StateError(
        'GenDataField "$key" has no live storage (this is a schema-only pass)',
      );
    }
    final raw = s.read(key);
    if (raw is! List) return const [];
    return [
      for (var i = 0; i < raw.length; i++)
        itemBuilder(_MapFieldStorage({'$i': raw[i]}), '$i').value,
    ];
  }

  @override
  set value(List<T> newValue) {
    final s = storage;
    if (s == null) {
      throw StateError(
        'GenDataField "$key" has no live storage (this is a schema-only pass)',
      );
    }
    final serialized = <Object?>[];
    for (var i = 0; i < newValue.length; i++) {
      final entryStorage = _MapFieldStorage(<String, Object?>{});
      itemBuilder(entryStorage, '$i').value = newValue[i];
      serialized.add(entryStorage.map['$i']);
    }
    s.write(key, serialized);
  }
}

/// Builds schema for a [GenObject]/[GenSystemFunction]; a null [storage]
/// means schema-only (see [_GenDataFieldDescriptorImpl.schemaOnly]).
class _GenDataFieldDescriptorImpl implements GenDataFieldDescriptor {
  _GenDataFieldDescriptorImpl(this.storage);
  _GenDataFieldDescriptorImpl.schemaOnly() : storage = null;

  final _FieldStorage? storage;
  final Map<String, Schema> properties = {};
  final List<String> required = [];

  /// Already-JSON-encodable example values declared via each field's
  /// `example:` parameter. Used by [_GenFieldDescriptorImpl.object] to
  /// fold a nested [GenObject]'s own examples into the owning widget's
  /// auto-generated `exampleData`.
  final Map<String, Object?> exampleValues = {};

  void _register(String name, Schema schema, {bool isRequired = true}) {
    properties[name] = schema;
    if (isRequired) required.add(name);
  }

  @override
  GenDataField<String> string(String name, {required String label, String? example}) {
    _register(name, S.string(description: label));
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<String>(storage, name, _asString, _identity);
  }

  @override
  GenDataField<String?> optionalString(
    String name, {
    required String label,
    String? example,
  }) {
    _register(name, S.string(description: label), isRequired: false);
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<String?>(
      storage,
      name,
      _asOptionalString,
      _identity,
    );
  }

  @override
  GenDataField<bool> boolean(String name, {required String label, bool? example}) {
    _register(name, S.boolean(description: label));
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<bool>(storage, name, _asBool, _identity);
  }

  @override
  GenDataField<bool?> optionalBoolean(
    String name, {
    required String label,
    bool? example,
  }) {
    _register(name, S.boolean(description: label), isRequired: false);
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<bool?>(
      storage,
      name,
      _asOptionalBool,
      _identity,
    );
  }

  @override
  GenDataField<int> integer(String name, {required String label, int? example}) {
    _register(name, S.integer(description: label));
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<int>(storage, name, _asInt, _identity);
  }

  @override
  GenDataField<int?> optionalInteger(
    String name, {
    required String label,
    int? example,
  }) {
    _register(name, S.integer(description: label), isRequired: false);
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<int?>(storage, name, _asOptionalInt, _identity);
  }

  @override
  GenDataField<double> decimal(String name, {required String label, double? example}) {
    _register(name, S.number(description: label));
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<double>(storage, name, _asDouble, _identity);
  }

  @override
  GenDataField<double?> optionalDecimal(
    String name, {
    required String label,
    double? example,
  }) {
    _register(name, S.number(description: label), isRequired: false);
    if (example != null) exampleValues[name] = example;
    return _LiveGenDataField<double?>(
      storage,
      name,
      _asOptionalDouble,
      _identity,
    );
  }

  @override
  GenDataField<Widget> widget(String name, {required String label}) =>
      throw UnsupportedError(
        'widget fields are not supported inside GenObject/GenSystemFunction '
        '- they require a live CatalogItemContext to build a child widget',
      );

  @override
  GenDataField<Widget?> optionalWidget(String name, {required String label}) =>
      throw UnsupportedError(
        'widget fields are not supported inside GenObject/GenSystemFunction '
        '- they require a live CatalogItemContext to build a child widget',
      );

  @override
  GenDataField<T> enumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  }) {
    _register(name, S.string(enumValues: [for (final v in values) v.name], description: label));
    if (example != null) exampleValues[name] = example.name;
    return _LiveGenDataField<T>(
      storage,
      name,
      (raw) => _matchEnum(values, raw) ?? values.first,
      (v) => v.name,
    );
  }

  @override
  GenDataField<T?> optionalEnumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  }) {
    _register(
      name,
      S.string(enumValues: [for (final v in values) v.name], description: label),
      isRequired: false,
    );
    if (example != null) exampleValues[name] = example.name;
    return _LiveGenDataField<T?>(
      storage,
      name,
      (raw) => _matchEnum(values, raw),
      (v) => v?.name,
    );
  }

  @override
  GenDataField<List<T>> list<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    List<T>? example,
  }) {
    _register(name, S.list(description: label));
    if (example != null) {
      exampleValues[name] = [for (final e in example) _serializeValue(item, e)];
    }
    return _LiveListGenDataField<T>(
      storage,
      name,
      (s, k) => _rebind(item, s, k),
    );
  }

  @override
  GenDataField<List<T>?> optionalList<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    List<T>? example,
  }) {
    _register(name, S.list(description: label), isRequired: false);
    if (example != null) {
      exampleValues[name] = [for (final e in example) _serializeValue(item, e)];
    }
    final inner = _LiveListGenDataField<T>(
      storage,
      name,
      (s, k) => _rebind(item, s, k),
    );
    return _LiveGenDataField<List<T>?>(
      storage,
      name,
      (raw) => raw == null ? null : inner.value,
      (v) => v,
    );
  }

  @override
  GenDataField<Set<T>> set<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    Set<T>? example,
  }) {
    _register(name, S.list(description: label, uniqueItems: true));
    if (example != null) {
      exampleValues[name] = [for (final e in example) _serializeValue(item, e)];
    }
    final list = _LiveListGenDataField<T>(
      storage,
      name,
      (s, k) => _rebind(item, s, k),
    );
    return _LiveGenDataField<Set<T>>(
      storage,
      name,
      (_) => list.value.toSet(),
      (v) => v.toList(),
    );
  }

  @override
  GenDataField<Set<T>?> optionalSet<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    Set<T>? example,
  }) {
    _register(
      name,
      S.list(description: label, uniqueItems: true),
      isRequired: false,
    );
    if (example != null) {
      exampleValues[name] = [for (final e in example) _serializeValue(item, e)];
    }
    final list = _LiveListGenDataField<T>(
      storage,
      name,
      (s, k) => _rebind(item, s, k),
    );
    return _LiveGenDataField<Set<T>?>(
      storage,
      name,
      (raw) => raw == null ? null : list.value.toSet(),
      (v) => v?.toList(),
    );
  }

  @override
  GenDataField<Map<K, V>> map<K, V>(
    String name, {
    required String label,
    required GenDataField<K> key,
    required GenDataField<V> value,
    Map<K, V>? example,
  }) {
    _register(name, S.list(description: label));
    if (example != null) {
      exampleValues[name] = [
        for (final e in example.entries)
          {'key': _serializeValue(key, e.key), 'value': _serializeValue(value, e.value)},
      ];
    }
    return _LiveGenDataField<Map<K, V>>(
      storage,
      name,
      (raw) {
        if (raw is! List) return const {};
        final result = <K, V>{};
        for (final entry in raw) {
          if (entry is! Map) continue;
          result[_rebindValue(key, entry['key'])] =
              _rebindValue(value, entry['value']);
        }
        return result;
      },
      (v) => [
        for (final e in v.entries)
          {'key': _serializeValue(key, e.key), 'value': _serializeValue(value, e.value)},
      ],
    );
  }

  @override
  GenDataField<Map<K, V>?> optionalMap<K, V>(
    String name, {
    required String label,
    required GenDataField<K> key,
    required GenDataField<V> value,
    Map<K, V>? example,
  }) {
    _register(name, S.list(description: label), isRequired: false);
    if (example != null) {
      exampleValues[name] = [
        for (final e in example.entries)
          {'key': _serializeValue(key, e.key), 'value': _serializeValue(value, e.value)},
      ];
    }
    return _LiveGenDataField<Map<K, V>?>(
      storage,
      name,
      (raw) {
        if (raw == null) return null;
        if (raw is! List) return const {};
        final result = <K, V>{};
        for (final entry in raw) {
          if (entry is! Map) continue;
          result[_rebindValue(key, entry['key'])] = _rebindValue(
            value,
            entry['value'],
          );
        }
        return result;
      },
      (v) => v == null
          ? null
          : [
              for (final e in v.entries)
                {
                  'key': _serializeValue(key, e.key),
                  'value': _serializeValue(value, e.value),
                },
            ],
    );
  }

  @override
  GenDataField<T> object<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  }) {
    final schemaDescriptor = _GenDataFieldDescriptorImpl.schemaOnly();
    object.describeFields(schemaDescriptor);
    _register(
      name,
      S.object(
        properties: schemaDescriptor.properties,
        required: schemaDescriptor.required,
        description: label,
      ),
    );
    return _LiveGenObjectDataField<T>(storage, name, object);
  }

  @override
  GenDataField<T?> optionalObject<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  }) {
    final schemaDescriptor = _GenDataFieldDescriptorImpl.schemaOnly();
    object.describeFields(schemaDescriptor);
    _register(
      name,
      S.object(
        properties: schemaDescriptor.properties,
        required: schemaDescriptor.required,
        description: label,
      ),
      isRequired: false,
    );
    final inner = _LiveGenObjectDataField<T>(storage, name, object);
    return _LiveGenDataField<T?>(
      storage,
      name,
      (raw) => raw == null ? null : inner.value,
      (v) => v,
    );
  }
}

T? _matchEnum<T extends Enum>(List<T> values, Object? raw) {
  if (raw is String) {
    for (final v in values) {
      if (v.name == raw) return v;
    }
  }
  return null;
}

GenDataField<T> _rebind<T>(
  GenDataField<T> template,
  _FieldStorage? storage,
  String key,
) {
  if (template is _LiveGenDataField<T>) {
    return _LiveGenDataField<T>(
      storage,
      key,
      template._deserialize,
      template._serialize,
    );
  }
  final dynamic dynTemplate = template;
  if (dynTemplate is _LiveGenObjectDataField) {
    return _LiveGenObjectDataField(storage, key, dynTemplate.prototype)
        as GenDataField<T>;
  }
  throw UnsupportedError(
    'Unsupported GenDataField item type for rebinding: ${template.runtimeType}',
  );
}

T _rebindValue<T>(GenDataField<T> template, Object? raw) {
  final rebound = _rebind(template, _MapFieldStorage({'v': raw}), 'v');
  return rebound.value;
}

Object? _serializeValue<T>(GenDataField<T> template, T value) {
  final storage = _MapFieldStorage(<String, Object?>{});
  final rebound = _rebind(template, storage, 'v');
  rebound.value = value;
  return storage.map['v'];
}
