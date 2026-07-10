import 'dart:async';

import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'A text input field.',
  properties: {
    'value': A2uiSchemas.stringReference(
      description: 'The value of the text field.',
    ),
    'label': A2uiSchemas.stringReference(),
    'variant': S.string(
      enumValues: ['shortText', 'longText', 'number', 'obscured'],
    ),
    'checks': A2uiSchemas.checkable(),
    'onSubmittedAction': A2uiSchemas.action(),
  },
);

extension type _TextFieldData.fromMap(JsonMap _json) {
  Object? get value => _json['value'];
  Object? get label => _json['label'];
  List<JsonMap>? get checks => (_json['checks'] as List?)?.cast<JsonMap>();
  String? get variant => _json['variant'] as String?;
  JsonMap? get onSubmittedAction => _json['onSubmittedAction'] as JsonMap?;
}

class _ShadcnTextField extends StatefulWidget {
  const _ShadcnTextField({
    required this.initialValue,
    this.label,
    this.checks,
    this.context,
    this.variant,
    required this.onChanged,
    required this.onSubmitted,
  });

  final String initialValue;
  final String? label;
  final List<JsonMap>? checks;
  final DataContext? context;
  final String? variant;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;

  @override
  State<_ShadcnTextField> createState() => _ShadcnTextFieldState();
}

class _ShadcnTextFieldState extends State<_ShadcnTextField> {
  late final TextEditingController _controller;
  String? _errorText;
  StreamSubscription<String?>? _validationSubscription;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _setupValidation();
  }

  @override
  void didUpdateWidget(_ShadcnTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
    if (widget.checks != oldWidget.checks || widget.context != oldWidget.context) {
      _setupValidation();
    }
  }

  void _setupValidation() {
    _validationSubscription?.cancel();
    _validationSubscription = null;

    if (widget.checks == null || widget.checks!.isEmpty || widget.context == null) {
      if (_errorText != null && mounted) {
        setState(() => _errorText = null);
      }
      return;
    }

    _validationSubscription = ValidationHelper.validateStream(
      widget.checks,
      widget.context,
    ).listen((newError) {
      if (newError != _errorText && mounted) {
        setState(() => _errorText = newError);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _validationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: _controller,
      hintText: widget.label,
      obscureText: widget.variant == 'obscured',
      maxLines: widget.variant == 'longText' ? null : 1,
      keyboardType: switch (widget.variant) {
        'number' => TextInputType.number,
        'longText' => TextInputType.multiline,
        _ => TextInputType.text,
      },
      onChanged: widget.onChanged,
      onSubmitted: (value) {
        if (_errorText == null) {
          widget.onSubmitted(value);
        }
      },
    );

    if (_errorText == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        field,
        Text(
          _errorText!,
        ).small(color: Theme.of(context).colorScheme.destructive),
      ],
    );
  }
}

/// A text input field, rendered with shadcn_flutter's [TextField].
///
/// The `value` parameter bidirectionally binds the field's content to the
/// data model.
///
/// ## Parameters:
///
/// - `value`: The initial value of the text field.
/// - `label`: The text to display as a placeholder for the text field.
/// - `variant`: The type of text field. Can be `shortText`, `longText`,
///   `number`, or `obscured`.
/// - `onSubmittedAction`: The action to perform when the user submits the
///   text field.
final textField = CatalogItem(
  name: 'TextField',
  isImplicitlyFlexible: true,
  dataSchema: _schema,
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "TextField",
          "value": "Hello World",
          "label": "Greeting"
        }
      ]
    ''',
  ],
  widgetBuilder: (itemContext) {
    final data = _TextFieldData.fromMap(itemContext.data as JsonMap);
    final Object? valueRef = data.value;
    final path = (valueRef is Map && valueRef.containsKey('path'))
        ? valueRef['path'] as String
        : '${itemContext.id}.value';

    return BoundString(
      dataContext: itemContext.dataContext,
      value: {'path': path},
      builder: (context, currentValue) {
        return BoundString(
          dataContext: itemContext.dataContext,
          value: data.label,
          builder: (context, label) {
            final effectiveValue =
                currentValue?.toString() ?? (valueRef is String ? valueRef : null);

            return _ShadcnTextField(
              initialValue: effectiveValue ?? '',
              label: label,
              checks: data.checks,
              context: itemContext.dataContext,
              variant: data.variant,
              onChanged: (newValue) {
                if (data.variant == 'number') {
                  final numberValue = num.tryParse(newValue);
                  if (numberValue != null) {
                    itemContext.dataContext.update(DataPath(path), numberValue);
                    return;
                  }
                }
                itemContext.dataContext.update(DataPath(path), newValue);
              },
              onSubmitted: (newValue) async {
                final actionData = data.onSubmittedAction;
                if (actionData == null) return;

                if (actionData.containsKey('event')) {
                  final eventMap = actionData['event'] as JsonMap;
                  final actionName = eventMap['name'] as String;
                  final contextDefinition = eventMap['context'] as JsonMap?;
                  final resolvedContext = await resolveContext(
                    itemContext.dataContext,
                    contextDefinition,
                  );
                  itemContext.dispatchEvent(
                    UserActionEvent(
                      name: actionName,
                      sourceComponentId: itemContext.id,
                      context: resolvedContext,
                    ),
                  );
                } else if (actionData.containsKey('functionCall')) {
                  final funcMap = actionData['functionCall'] as JsonMap;
                  final callName = funcMap['call'] as String;
                  if (callName == 'closeModal') {
                    if (itemContext.buildContext.mounted) {
                      Navigator.of(itemContext.buildContext).pop();
                    }
                    return;
                  }
                  await itemContext.dataContext.resolve(funcMap).first;
                }
              },
            );
          },
        );
      },
    );
  },
);
