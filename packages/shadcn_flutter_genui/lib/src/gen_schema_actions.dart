part of 'gen_schema.dart';

abstract class _ActionNode {
  const _ActionNode();

  /// Runs this node, returning whatever value it produced (a leaf's
  /// computed/returned value, or the last-run child's value for
  /// composition nodes) so a `functionCall` (e.g. a system function that
  /// looks up data, not just performs a side effect) isn't a dead end.
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  );
}

class _NoopNode extends _ActionNode {
  const _NoopNode();

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async => null;
}

class _EventNode extends _ActionNode {
  const _EventNode(this.name, this.contextTemplate);
  final String name;
  final JsonMap contextTemplate;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    final resolved = await _resolveActionContext(
      itemContext.dataContext,
      variables,
      contextTemplate,
    );
    itemContext.dispatchEvent(
      UserActionEvent(
        name: name,
        sourceComponentId: itemContext.id,
        context: resolved,
      ),
    );
    return null;
  }
}

class _FunctionCallNode extends _ActionNode {
  const _FunctionCallNode(this.call, this.argsTemplate);
  final String call;
  final JsonMap argsTemplate;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    final resolvedArgs = await _resolveActionContext(
      itemContext.dataContext,
      variables,
      argsTemplate,
    );
    final function = registry.byName(call);
    if (function == null) {
      throw StateError('Unknown system function: "$call"');
    }
    if (!context.mounted) return null;
    final result = Actions.invoke(
      context,
      GenSystemFunctionIntent(function, resolvedArgs),
    );
    if (result is Future) {
      return await result;
    }
    return result;
  }
}

class _SetValueNode extends _ActionNode {
  const _SetValueNode(this.path, this.valueTemplate);
  final String path;
  final Object? valueTemplate;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    final resolved = await _resolveActionValue(
      itemContext.dataContext,
      variables,
      valueTemplate,
    );
    itemContext.dataContext.update(DataPath(path), resolved);
    return resolved;
  }
}

class _SetVarNode extends _ActionNode {
  const _SetVarNode(this.varName, this.valueTemplate);
  final String varName;
  final Object? valueTemplate;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    final resolved = await _resolveActionValue(
      itemContext.dataContext,
      variables,
      valueTemplate,
    );
    variables[varName] = resolved;
    return resolved;
  }
}

/// Submits the nearest ambient shadcn_flutter [Form], revalidating every
/// registered field first and only invoking that [Form]'s `onSubmit` if
/// all of them pass — see [wrapFormEntry] for how fields register.
class _SubmitFormNode extends _ActionNode {
  const _SubmitFormNode();

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    if (!context.mounted) return null;
    final result = context.submitForm();
    return result is Future<SubmissionResult> ? await result : result;
  }
}

class _SequenceNode extends _ActionNode {
  const _SequenceNode(this.steps);
  final List<_ActionNode> steps;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    Object? result;
    for (final step in steps) {
      result = await step.execute(context, itemContext, registry, variables);
    }
    return result;
  }
}

class _ConditionalNode extends _ActionNode {
  const _ConditionalNode(this.condition, this.thenNode, this.elseNode);
  final Object? condition;
  final _ActionNode thenNode;
  final _ActionNode? elseNode;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    final isTrue = await _evaluateCondition(
      itemContext.dataContext,
      variables,
      condition,
    );
    if (isTrue) {
      // context is only forwarded to another node; any UI-sensitive use is
      // guarded at the leaf that actually needs it (_FunctionCallNode).
      // ignore: use_build_context_synchronously
      return thenNode.execute(context, itemContext, registry, variables);
    } else if (elseNode != null) {
      // ignore: use_build_context_synchronously
      return elseNode!.execute(context, itemContext, registry, variables);
    }
    return null;
  }
}

class _TryNode extends _ActionNode {
  const _TryNode(this.action, this.catchNode);
  final _ActionNode action;
  final _ActionNode? catchNode;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    try {
      return await action.execute(context, itemContext, registry, variables);
    } catch (error, stack) {
      final catchStep = catchNode;
      if (catchStep != null) {
        final errorVariables = Map<String, Object?>.of(variables)
          ..['error'] = error.toString();
        // ignore: use_build_context_synchronously
        return await catchStep.execute(context, itemContext, registry, errorVariables);
      }
      itemContext.reportError(error, stack);
      return null;
    }
  }
}

class _AsyncNode extends _ActionNode {
  const _AsyncNode(this.action, this.thenNode);
  final _ActionNode action;
  final _ActionNode? thenNode;

  @override
  Future<Object?> execute(
    BuildContext context,
    CatalogItemContext itemContext,
    GenSystemFunctionRegistry registry,
    Map<String, Object?> variables,
  ) async {
    unawaited(
      action
          .execute(context, itemContext, registry, variables)
          .then((_) async {
            final continuation = thenNode;
            if (continuation != null) {
              // ignore: use_build_context_synchronously
              await continuation.execute(context, itemContext, registry, variables);
            }
          })
          .catchError((Object error, StackTrace stack) {
            itemContext.reportError(error, stack);
          }),
    );
    return null;
  }
}

_ActionNode _parseActionNode(Object? raw) {
  if (raw is! Map) return const _NoopNode();
  final map = raw as JsonMap;
  if (map['event'] case final JsonMap event) {
    return _EventNode(
      event['name'] as String,
      (event['context'] as JsonMap?) ?? const {},
    );
  }
  if (map['functionCall'] case final JsonMap functionCall) {
    return _FunctionCallNode(
      functionCall['call'] as String,
      (functionCall['args'] as JsonMap?) ?? const {},
    );
  }
  if (map['setValue'] case final JsonMap setValue) {
    return _SetValueNode(setValue['path'] as String, setValue['value']);
  }
  if (map['setVar'] case final JsonMap setVar) {
    return _SetVarNode(setVar['name'] as String, setVar['value']);
  }
  if (map['sequence'] case final List sequence) {
    return _SequenceNode([for (final step in sequence) _parseActionNode(step)]);
  }
  if (map['conditional'] case final JsonMap conditional) {
    return _ConditionalNode(
      conditional['condition'],
      _parseActionNode(conditional['then']),
      conditional.containsKey('else')
          ? _parseActionNode(conditional['else'])
          : null,
    );
  }
  if (map['try'] case final JsonMap tryNode) {
    return _TryNode(
      _parseActionNode(tryNode['action']),
      tryNode.containsKey('catch') ? _parseActionNode(tryNode['catch']) : null,
    );
  }
  if (map['async'] case final JsonMap asyncNode) {
    return _AsyncNode(
      _parseActionNode(asyncNode['action']),
      asyncNode.containsKey('then') ? _parseActionNode(asyncNode['then']) : null,
    );
  }
  if (map.containsKey('submitForm')) {
    return const _SubmitFormNode();
  }
  return const _NoopNode();
}

Future<Object?> _resolveActionValue(
  DataContext dataContext,
  Map<String, Object?> variables,
  Object? template,
) async {
  if (template is Map && template.containsKey('var')) {
    return variables[template['var'] as String];
  }
  return await dataContext.resolve(template).first;
}

Future<JsonMap> _resolveActionContext(
  DataContext dataContext,
  Map<String, Object?> variables,
  JsonMap? template,
) async {
  if (template == null) return {};
  final resolved = <String, Object?>{};
  for (final entry in template.entries) {
    resolved[entry.key] = await _resolveActionValue(
      dataContext,
      variables,
      entry.value,
    );
  }
  return resolved;
}

Future<bool> _evaluateCondition(
  DataContext dataContext,
  Map<String, Object?> variables,
  Object? condition,
) async {
  if (condition is Map && condition.containsKey('var')) {
    final value = variables[condition['var'] as String];
    if (value is bool) return value;
    return value != null;
  }
  return await dataContext.evaluateConditionStream(condition).first;
}

final class _GenActionDispatcherImpl implements GenActionDispatcher {
  _GenActionDispatcherImpl(this.node, this.registry);
  final _ActionNode node;
  final GenSystemFunctionRegistry registry;

  @override
  Future<Object?> call(
    BuildContext context, [
    GenActionParameters parameters = GenActionParameters.none,
  ]) async {
    final itemContext = Data.of<CatalogItemContext>(context);
    final variables = <String, Object?>{
      for (final (name, value) in parameters._entries) name: value,
    };
    return node.execute(context, itemContext, registry, variables);
  }
}

/// Wraps a [_GenActionDispatcherImpl], additionally carrying the single
/// [GenActionParameter] its owning `valueAction`/`optionalValueAction`
/// field was declared with.
final class _GenValueActionDispatcherImpl<T>
    implements GenValueActionDispatcher<T> {
  _GenValueActionDispatcherImpl(this._inner, this.parameter);
  final GenActionDispatcher _inner;
  @override
  final GenActionParameter<T> parameter;

  @override
  Future<Object?> call(
    BuildContext context, [
    GenActionParameters parameters = GenActionParameters.none,
  ]) => _inner.call(context, parameters);
}

/// Every [GenSystemFunction] available to a [GenCatalog], built once by
/// [GenCatalog.asCatalog] and threaded into every widget's `action`/
/// `optionalAction` fields.
class GenSystemFunctionRegistry {
  GenSystemFunctionRegistry(List<GenSystemFunction> functions)
    : _byName = {for (final fn in functions) fn.name: fn};

  static final GenSystemFunctionRegistry empty = GenSystemFunctionRegistry(
    const [],
  );

  final Map<String, GenSystemFunction> _byName;

  GenSystemFunction? byName(String name) => _byName[name];

  List<String> get names => _byName.keys.toList(growable: false);
}

/// Fired via `Actions.invoke(context, GenSystemFunctionIntent(fn, args))`
/// to trigger a [GenSystemFunction] from inside a widget's `buildWidget`,
/// with the exact same typed-field binding the AI-direct call path uses.
class GenSystemFunctionIntent extends Intent {
  const GenSystemFunctionIntent(this.function, [this.args = const {}]);
  final GenSystemFunction function;
  final Map<String, Object?> args;
}

/// Handles every [GenSystemFunctionIntent]. Register once, e.g. inside
/// [_GenWidget], since the function to run travels with the intent itself.
class GenSystemFunctionAction extends Action<GenSystemFunctionIntent> {
  GenSystemFunctionAction();

  @override
  Object? invoke(covariant GenSystemFunctionIntent intent, [BuildContext? context]) {
    final descriptor = _GenDataFieldDescriptorImpl(_MapFieldStorage(intent.args));
    intent.function.describeFields(descriptor);
    return intent.function.invoke(context);
  }
}

/// Bridges [function] to a genui [ClientFunction] so the AI can call it
/// directly, with no widget involved. Used by [GenCatalog.asCatalog]
/// (a plain `import`, not a `part of`, so it needs this public entry point
/// rather than reaching into [_GenSystemClientFunction] directly).
ClientFunction genSystemFunctionToClientFunction(GenSystemFunction function) =>
    _GenSystemClientFunction(function);

/// Bridges a [GenSystemFunction] to genui's [ClientFunction] so the AI can
/// call it directly, with no widget involved.
class _GenSystemClientFunction implements ClientFunction {
  _GenSystemClientFunction(this.function);
  final GenSystemFunction function;

  @override
  String get name => function.name;

  @override
  String get description => function.description;

  @override
  ClientFunctionReturnType get returnType => ClientFunctionReturnType.any;

  @override
  Schema get argumentSchema {
    final schemaDescriptor = _GenDataFieldDescriptorImpl.schemaOnly();
    function.describeFields(schemaDescriptor);
    return S.object(
      properties: schemaDescriptor.properties,
      required: schemaDescriptor.required,
    );
  }

  @override
  Stream<Object?> execute(JsonMap args, ExecutionContext context) async* {
    final descriptor = _GenDataFieldDescriptorImpl(_MapFieldStorage(args));
    function.describeFields(descriptor);
    yield await function.invoke();
  }
}

Schema _actionFieldSchema(
  String label,
  List<GenActionParameter<Object?>> parameters,
  GenSystemFunctionRegistry registry,
) {
  final description = parameters.isEmpty
      ? label
      : '$label Available via {\'var\': ...}: '
            '${parameters.map((p) => '${p.name} (${p.description})').join(', ')}.';
  return S.combined(
    description: description,
    $defs: {'ActionNode': _actionNodeDef(registry)},
    $ref: '#/\$defs/ActionNode',
  );
}

Schema _actionNodeDef(GenSystemFunctionRegistry registry) {
  final nodeRef = S.combined($ref: '#/\$defs/ActionNode');
  return S.combined(
    description:
        'A single action, or a sequence/conditional/try/async composition '
        'of actions.',
    oneOf: [
      S.nil(),
      _eventNodeSchema(),
      _functionCallNodeSchema(registry),
      _setValueNodeSchema(),
      _setVarNodeSchema(),
      S.object(
        properties: {'sequence': S.list(items: nodeRef)},
        required: ['sequence'],
      ),
      S.object(
        properties: {
          'conditional': S.object(
            properties: {
              'condition': S.any(description: 'A DynamicBoolean condition.'),
              'then': nodeRef,
              'else': nodeRef,
            },
            required: ['condition', 'then'],
          ),
        },
        required: ['conditional'],
      ),
      S.object(
        properties: {
          'try': S.object(
            properties: {'action': nodeRef, 'catch': nodeRef},
            required: ['action'],
          ),
        },
        required: ['try'],
      ),
      S.object(
        properties: {
          'async': S.object(
            properties: {'action': nodeRef, 'then': nodeRef},
            required: ['action'],
          ),
        },
        required: ['async'],
      ),
      S.object(
        description:
            'Submits the nearest ambient Form: revalidates every field and '
            "only triggers that Form's onSubmit if all of them pass.",
        properties: {'submitForm': S.object(properties: {})},
        required: ['submitForm'],
      ),
    ],
  );
}

Schema _eventNodeSchema() => S.object(
  properties: {
    'event': S.object(
      properties: {
        'name': S.string(
          description: 'The name of the event to notify the AI about.',
        ),
        'context': S.object(
          description: 'Arbitrary data to send with the event.',
          additionalProperties: true,
        ),
      },
      required: ['name'],
    ),
  },
  required: ['event'],
);

Schema _functionCallNodeSchema(GenSystemFunctionRegistry registry) => S.object(
  properties: {
    'functionCall': S.object(
      properties: {
        'call': S.string(
          enumValues: registry.names,
          description: 'The name of the registered system function to call.',
        ),
        'args': S.object(
          description: 'Arguments for the function.',
          additionalProperties: true,
        ),
      },
      required: ['call'],
    ),
  },
  required: ['functionCall'],
);

Schema _setValueNodeSchema() => S.object(
  properties: {
    'setValue': S.object(
      properties: {
        'path': S.string(description: 'The data model path to write to.'),
        'value': A2uiSchemas.propertyReference(
          description: 'The value to write.',
        ),
      },
      required: ['path', 'value'],
    ),
  },
  required: ['setValue'],
);

Schema _setVarNodeSchema() => S.object(
  properties: {
    'setVar': S.object(
      properties: {
        'name': S.string(description: 'The temporary variable name.'),
        'value': A2uiSchemas.propertyReference(
          description: 'The value to store.',
        ),
      },
      required: ['name', 'value'],
    ),
  },
  required: ['setVar'],
);
