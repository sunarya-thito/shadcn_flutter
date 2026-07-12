import 'dart:async';
import 'dart:convert';

import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart' hide ValidationResult;
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'gen_schema_impl.dart';
part 'gen_schema_fields.dart';
part 'gen_schema_data_fields.dart';
part 'gen_schema_actions.dart';

/// Declares a widget's AI-fillable fields and builds it from their values.
abstract class GenSchema {
  void describeFields(GenFieldDescriptor descriptor);
  Widget buildWidget(BuildContext context);

  /// The catalog component name this schema renders as. Only needed to
  /// reference this schema from a `widget()`/`widgetList()` field's
  /// `example:` (see [GenFieldDescriptor.widget]) — a [GenCatalogItem]'s own
  /// `schema` doesn't need this, since its name already comes from
  /// [GenCatalogItem.name].
  String? get componentName => null;

  /// Set by [GenSchemaExampleX.withExample]; invoked once right after
  /// [describeFields] when this schema is used as a widget-field example,
  /// so the customizer can override specific fields' examples (via
  /// [GenField.example]) before the example JSON is read.
  void Function(GenSchema schema)? _exampleCustomizer;
}

/// Lets a bare schema factory (e.g. `TextSchema.new`) be customized for one
/// particular `widget()`/`widgetList()` example without writing a whole new
/// subclass, e.g.:
/// ```dart
/// example: TextSchema.new.withExample((s) => s.text.example = 'Card body')
/// ```
extension GenSchemaExampleX<T extends GenSchema> on T Function() {
  T Function() withExample(void Function(T schema) customize) {
    final factory = this;
    return () {
      final schema = factory();
      schema._exampleCustomizer = (s) => customize(s as T);
      return schema;
    };
  }
}

/// Binds a [GenSchema] to the name genui will use for it in JSON.
///
/// [schema] is a factory, not a shared instance: each conversion to a
/// genui `CatalogItem` (see [genCatalogItemToCatalogItem]) calls it once to
/// get a fresh [GenSchema], since `describeFields` assigns each field's
/// `late final` handle exactly once per instance.
class GenCatalogItem {
  final String name;
  final String label;
  final GenSchema Function() schema;

  const GenCatalogItem({
    required this.name,
    required this.label,
    required this.schema,
  });

  /// Prefer [GenCatalog.asCatalog], which threads a real
  /// [GenSystemFunctionRegistry] through every item at once.
  CatalogItem get asCatalogItem =>
      genCatalogItemToCatalogItem(this, GenSystemFunctionRegistry.empty);
}

/// A live handle to one of a [GenSchema]'s declared fields, resolved
/// through the ambient [BuildContext] on every read/write.
abstract final class GenField<T> {
  T operator [](BuildContext context);
  void operator []=(BuildContext context, T value);

  /// Overrides this field's own generated example value. Has no effect on
  /// live rendering — only on `exampleData` JSON generation. Chiefly used
  /// inside a [GenSchemaExampleX.withExample] customizer.
  set example(T value);
}

/// Plain get/set field for [GenObject] sub-fields and [GenSystemFunction]
/// arguments, no [BuildContext] involved.
abstract final class GenDataField<T> {
  T get value;
  set value(T newValue);
}

/// A typed, named value an action can expose to the AI (via
/// `{'var': name}`). Declare a `static const` on the owning [GenSchema] and
/// reuse it in both `describeFields` and `buildWidget`. [serialize] turns a
/// live callback value of type [T] into the JSON-safe value the AI actually
/// sees — for most built-in subclasses this is the identity, but e.g.
/// [GenDateTimeParameter] converts a `DateTime?` to an ISO date string.
///
/// Not sealed: third-party [GenSchema]s can declare their own subclasses
/// for value types this package doesn't ship (e.g. a color or duration).
abstract class GenActionParameter<T> {
  const GenActionParameter(this.name, {required this.description});
  final String name;
  final String description;

  Object? serialize(T value);

  /// Wraps this parameter for use with a callback whose native value is
  /// [N] instead of [T] (e.g. a `CheckboxState` where this parameter means
  /// `bool`), by [project]ing the native value to [T] before this
  /// parameter's own [serialize] runs. Declare the mapped parameter once,
  /// alongside the base one, and reuse it in both `describeFields` and
  /// `buildWidget` — the projection shouldn't live at the call site.
  GenActionParameter<N> map<N>(T Function(N native) project) =>
      _GenMappedParameter<N, T>(this, project);
}

final class _GenMappedParameter<N, T> extends GenActionParameter<N> {
  _GenMappedParameter(this._base, this._project)
    : super(_base.name, description: _base.description);
  final GenActionParameter<T> _base;
  final T Function(N native) _project;

  @override
  Object? serialize(N value) => _base.serialize(_project(value));
}

/// A `String` action parameter, e.g. a text field's new value.
final class GenStringParameter extends GenActionParameter<String> {
  const GenStringParameter(super.name, {required super.description});
  @override
  Object? serialize(String value) => value;
}

/// An optional `String` action parameter, e.g. a select's selected id.
final class GenOptionalStringParameter extends GenActionParameter<String?> {
  const GenOptionalStringParameter(super.name, {required super.description});
  @override
  Object? serialize(String? value) => value;
}

/// A `bool` action parameter, e.g. a checkbox's new checked state.
final class GenBoolParameter extends GenActionParameter<bool> {
  const GenBoolParameter(super.name, {required super.description});
  @override
  Object? serialize(bool value) => value;
}

/// An `int` action parameter, e.g. a tab bar's new selected index.
final class GenIntParameter extends GenActionParameter<int> {
  const GenIntParameter(super.name, {required super.description});
  @override
  Object? serialize(int value) => value;
}

/// A `double` action parameter, e.g. a slider's new value.
final class GenDecimalParameter extends GenActionParameter<double> {
  const GenDecimalParameter(super.name, {required super.description});
  @override
  Object? serialize(double value) => value;
}

/// A `DateTime?` action parameter, serialized as an ISO date (no time).
final class GenDateTimeParameter extends GenActionParameter<DateTime?> {
  const GenDateTimeParameter(super.name, {required super.description});
  @override
  Object? serialize(DateTime? value) =>
      value?.toIso8601String().split('T').first;
}

/// A single, type-checked (parameter, serialized value) pair — the
/// building block for [GenActionDispatcherX.toParameterizedCallback], which
/// needs several differently-typed parameter values at once.
final class GenActionParameterValue {
  const GenActionParameterValue._(this._name, this._serialized);
  final String _name;
  final Object? _serialized;

  static GenActionParameterValue of<T>(GenActionParameter<T> param, T value) =>
      GenActionParameterValue._(param.name, param.serialize(value));
}

/// A type-checked set of parameter values for one [GenActionDispatcher.call].
/// No raw `Map<String, Object?>` in this API.
final class GenActionParameters {
  const GenActionParameters._(this._entries);

  static const GenActionParameters none = GenActionParameters._([]);

  static GenActionParameters of<T>(GenActionParameter<T> param, T value) =>
      GenActionParameters._([(param.name, param.serialize(value))]);

  factory GenActionParameters.all(List<GenActionParameterValue> entries) =>
      GenActionParameters._([
        for (final e in entries) (e._name, e._serialized),
      ]);

  final List<(String, Object?)> _entries;
}

/// The runtime value of an `action`/`optionalAction` field: fires whatever
/// the AI's JSON configured, nothing, a message back to the AI, a
/// registered [GenSystemFunction], or a composition of those.
abstract final class GenActionDispatcher {
  /// Returns whatever value the fired action produced (e.g. a system
  /// function's own return value) — most callers (`onPressed`, `onChanged`,
  /// ...) can ignore it.
  Future<Object?> call(
    BuildContext context, [
    GenActionParameters parameters = GenActionParameters.none,
  ]);
}

extension GenActionDispatcherX on GenActionDispatcher? {
  /// For plain callbacks like `Button.onPressed`.
  VoidCallback? toVoidCallback(BuildContext context) {
    final dispatcher = this;
    if (dispatcher == null) return null;
    return () => dispatcher.call(context);
  }

  /// For callbacks whose argument carries several pieces of data (e.g.
  /// `onTapDown`) and so can't be expressed as a single [GenValueAction]'s
  /// one parameter. Build each entry with [GenActionParameterValue.of].
  void Function(T)? toParameterizedCallback<T>(
    BuildContext context,
    List<GenActionParameterValue> Function(T) toParameters,
  ) {
    final dispatcher = this;
    if (dispatcher == null) return null;
    return (T value) =>
        dispatcher.call(context, GenActionParameters.all(toParameters(value)));
  }
}

/// The runtime value of a `valueAction`/`optionalValueAction` field: like
/// [GenActionDispatcher], but its owning field declared exactly one typed
/// [parameter] up front (see [GenFieldDescriptor.valueAction]), so firing it
/// via [GenValueActionDispatcherX.toValueCallback] doesn't need that
/// parameter repeated at the `buildWidget` call site — the association was
/// already fixed, type-checked, at the field's declaration.
abstract final class GenValueActionDispatcher<T> implements GenActionDispatcher {
  GenActionParameter<T> get parameter;
}

extension GenValueActionDispatcherX<T> on GenValueActionDispatcher<T>? {
  /// For single-argument callbacks like `TextField.onChanged`.
  void Function(T)? toValueCallback(BuildContext context) {
    final dispatcher = this;
    if (dispatcher == null) return null;
    return (T value) => dispatcher.call(
      context,
      GenActionParameters.of(dispatcher.parameter, value),
    );
  }
}

/// A type-safe way to describe an example `action`/`optionalAction` value,
/// mirroring the real action AST (event/functionCall/setValue/setVar/
/// sequence/conditional/try/async) without hand-typing JSON. Each subclass
/// knows how to render itself via [toJson].
sealed class GenActionExample {
  const GenActionExample();
  Object? toJson();
}

/// Example: notify the AI.
final class EventExample extends GenActionExample {
  const EventExample(this.name, {this.context = const {}});
  final String name;
  final Map<String, Object?> context;

  @override
  Object? toJson() => {
    'event': {'name': name, if (context.isNotEmpty) 'context': context},
  };
}

/// Example: call a registered [GenSystemFunction].
final class FunctionCallExample extends GenActionExample {
  const FunctionCallExample(this.call, {this.args = const {}});
  final String call;
  final Map<String, Object?> args;

  @override
  Object? toJson() => {
    'functionCall': {'call': call, if (args.isNotEmpty) 'args': args},
  };
}

/// Example: write directly to the data model.
final class SetValueExample extends GenActionExample {
  const SetValueExample(this.path, this.value);
  final String path;
  final Object? value;

  @override
  Object? toJson() => {
    'setValue': {'path': path, 'value': value},
  };
}

/// Example: store a temporary variable for later steps to read.
final class SetVarExample extends GenActionExample {
  const SetVarExample(this.name, this.value);
  final String name;
  final Object? value;

  @override
  Object? toJson() => {
    'setVar': {'name': name, 'value': value},
  };
}

/// Example: run several actions in order.
final class SequenceExample extends GenActionExample {
  const SequenceExample(this.steps);
  final List<GenActionExample> steps;

  @override
  Object? toJson() => {
    'sequence': [for (final step in steps) step.toJson()],
  };
}

/// Example: branch on a condition.
final class ConditionalExample extends GenActionExample {
  const ConditionalExample(this.condition, this.then, [this.orElse]);
  final Object? condition;
  final GenActionExample then;
  final GenActionExample? orElse;

  @override
  Object? toJson() => {
    'conditional': {
      'condition': condition,
      'then': then.toJson(),
      if (orElse != null) 'else': orElse!.toJson(),
    },
  };
}

/// Example: catch errors from [action].
final class TryExample extends GenActionExample {
  const TryExample(this.action, [this.catchExample]);
  final GenActionExample action;
  final GenActionExample? catchExample;

  @override
  Object? toJson() => {
    'try': {
      'action': action.toJson(),
      if (catchExample != null) 'catch': catchExample!.toJson(),
    },
  };
}

/// Example: fire [action] without waiting for it, running [then] once it
/// completes.
final class AsyncExample extends GenActionExample {
  const AsyncExample(this.action, [this.then]);
  final GenActionExample action;
  final GenActionExample? then;

  @override
  Object? toJson() => {
    'async': {
      'action': action.toJson(),
      if (then != null) 'then': then!.toJson(),
    },
  };
}

/// A fluent builder a [GenSchema] uses, once, to declare its AI-fillable
/// fields. Most methods take an optional `example`, which feeds
/// [GenCatalogItem]'s auto-generated `exampleData`.
abstract class GenFieldDescriptor {
  GenField<String> string(String name, {required String label, String? example});
  GenField<bool> boolean(String name, {required String label, bool? example});
  GenField<int> integer(String name, {required String label, int? example});
  GenField<double> decimal(String name, {required String label, double? example});
  /// [example] is a [GenSchema] factory describing another catalog
  /// component (e.g. `TextSchema.new`), used to generate this field's
  /// example child. See [GenSchemaExampleX.withExample] to customize it.
  GenField<Widget> widget(
    String name, {
    required String label,
    GenSchema Function()? example,
  });
  GenField<T> enumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  });
  GenField<String?> optionalString(
    String name, {
    required String label,
    String? example,
  });
  GenField<bool?> optionalBoolean(
    String name, {
    required String label,
    bool? example,
  });
  GenField<int?> optionalInteger(
    String name, {
    required String label,
    int? example,
  });
  GenField<double?> optionalDecimal(
    String name, {
    required String label,
    double? example,
  });
  GenField<Widget?> optionalWidget(
    String name, {
    required String label,
    GenSchema Function()? example,
  });

  /// A list of child-component references (see [widget]), e.g. tab panes or
  /// accordion bodies. [example] supplies one [GenSchema] factory per
  /// example child.
  GenField<List<Widget>> widgetList(
    String name, {
    required String label,
    List<GenSchema Function()>? example,
  });
  GenField<T?> optionalEnumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  });
  GenField<List<T>> list<T>(
    String name, {
    required String label,
    required GenField<T> item,
    List<T>? example,
  });
  GenField<List<T>?> optionalList<T>(
    String name, {
    required String label,
    required GenField<T> item,
    List<T>? example,
  });
  GenField<Map<K, V>> map<K, V>(
    String name, {
    required String label,
    required GenField<K> key,
    required GenField<V> value,
    Map<K, V>? example,
  });
  GenField<Map<K, V>?> optionalMap<K, V>(
    String name, {
    required String label,
    required GenField<K> key,
    required GenField<V> value,
    Map<K, V>? example,
  });
  GenField<Set<T>> set<T>(
    String name, {
    required String label,
    required GenField<T> item,
    Set<T>? example,
  });
  GenField<Set<T>?> optionalSet<T>(
    String name, {
    required String label,
    required GenField<T> item,
    Set<T>? example,
  });
  GenField<T> object<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  });

  GenField<GenActionDispatcher> action(
    String name, {
    required String label,
    List<GenActionParameter<Object?>> parameters = const [],
    GenActionExample? example,
  });

  GenField<GenActionDispatcher?> optionalAction(
    String name, {
    required String label,
    List<GenActionParameter<Object?>> parameters = const [],
    GenActionExample? example,
  });

  /// An action with exactly one typed [parameter] the AI can reference via
  /// `{'var': parameter.name}` — the common case for onChanged-style
  /// callbacks. Prefer this over [action] when there's exactly one value:
  /// the returned dispatcher already knows [parameter], so
  /// [GenValueActionDispatcherX.toValueCallback] doesn't need it repeated.
  GenField<GenValueActionDispatcher<T>> valueAction<T>(
    String name, {
    required String label,
    required GenActionParameter<T> parameter,
    GenActionExample? example,
  });

  GenField<GenValueActionDispatcher<T>?> optionalValueAction<T>(
    String name, {
    required String label,
    required GenActionParameter<T> parameter,
    GenActionExample? example,
  });

  /// Declares which [available] [GenValidator] kinds the AI may attach to
  /// [fieldName] (already declared via `string`/`decimal`/etc.), each
  /// selected and configured via JSON (`{"kind": "notEmpty", ...}`),
  /// composed with AND semantics into one real shadcn_flutter [Validator].
  GenField<Validator<T>?> validators<T>(
    String fieldName, {
    required List<GenValidator<T>> available,
    List<JsonMap>? example,
  });
}

/// [GenFieldDescriptor] counterpart for [GenObject] sub-fields and
/// [GenSystemFunction] arguments: plain get/set, no [BuildContext].
abstract class GenDataFieldDescriptor {
  GenDataField<String> string(String name, {required String label, String? example});
  GenDataField<bool> boolean(String name, {required String label, bool? example});
  GenDataField<int> integer(String name, {required String label, int? example});
  GenDataField<double> decimal(
    String name, {
    required String label,
    double? example,
  });
  GenDataField<Widget> widget(String name, {required String label});
  GenDataField<T> enumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  });
  GenDataField<List<T>> list<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    List<T>? example,
  });
  GenDataField<Map<K, V>> map<K, V>(
    String name, {
    required String label,
    required GenDataField<K> key,
    required GenDataField<V> value,
    Map<K, V>? example,
  });
  GenDataField<Set<T>> set<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    Set<T>? example,
  });
  GenDataField<T> object<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  });
  GenDataField<String?> optionalString(
    String name, {
    required String label,
    String? example,
  });
  GenDataField<bool?> optionalBoolean(
    String name, {
    required String label,
    bool? example,
  });
  GenDataField<int?> optionalInteger(
    String name, {
    required String label,
    int? example,
  });
  GenDataField<double?> optionalDecimal(
    String name, {
    required String label,
    double? example,
  });
  GenDataField<Widget?> optionalWidget(String name, {required String label});
  GenDataField<T?> optionalEnumerated<T extends Enum>(
    String name, {
    required String label,
    required List<T> values,
    T? example,
  });
  GenDataField<List<T>?> optionalList<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    List<T>? example,
  });
  GenDataField<Map<K, V>?> optionalMap<K, V>(
    String name, {
    required String label,
    required GenDataField<K> key,
    required GenDataField<V> value,
    Map<K, V>? example,
  });
  GenDataField<Set<T>?> optionalSet<T>(
    String name, {
    required String label,
    required GenDataField<T> item,
    Set<T>? example,
  });
  GenDataField<T?> optionalObject<T extends GenObject>(
    String name, {
    required String label,
    required T object,
  });
}

/// A user-defined nested data shape, used with [GenFieldDescriptor.object].
abstract class GenObject {
  @protected
  void describeFields(GenDataFieldDescriptor descriptor);
  @protected
  GenObject copy();
}

/// A developer-provided, non-UI operation (e.g. "exit the program").
/// Reachable directly by the AI (as a genui `ClientFunction`, via
/// [GenCatalog.asCatalog]) or from a widget's `buildWidget` via an
/// `action`/`optionalAction` field.
abstract class GenSystemFunction {
  String get name;
  String get description;

  void describeFields(GenDataFieldDescriptor descriptor);

  /// [context] is set when triggered via [Actions.invoke] from a widget;
  /// null when the AI calls it directly.
  Future<Object?> invoke([BuildContext? context]);
}

/// One AI-selectable validation rule, backed by a real shadcn_flutter
/// [Validator]. Declares its own parameters via [GenDataFieldDescriptor] —
/// exactly like [GenSystemFunction] does — never touching a JSON schema
/// type or genui directly. Not sealed: third-party [GenSchema]s can add
/// their own kinds.
abstract class GenValidator<T> {
  const GenValidator();

  /// The JSON discriminator the AI uses to select this kind, e.g. `'notEmpty'`.
  String get kind;

  /// Declares this kind's own parameters (message, min, max, ...).
  void describeFields(GenDataFieldDescriptor descriptor);

  /// Builds the real shadcn_flutter validator from the now-bound parameters.
  Validator<T> build();
}
