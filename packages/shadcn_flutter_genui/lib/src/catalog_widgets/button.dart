import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final _schema = S.object(
  description: 'An interactive button that triggers an action when pressed.',
  properties: {
    'child': A2uiSchemas.componentReference(
      description:
          'The ID of a child widget. This should always be set, e.g. to the '
          'ID of a `Text` widget.',
    ),
    'action': A2uiSchemas.action(),
    'variant': S.string(
      description: 'A hint for the button style.',
      enumValues: ['primary', 'secondary', 'outline', 'ghost'],
    ),
    'checks': A2uiSchemas.checkable(),
  },
  required: ['child', 'action'],
);

extension type _ButtonData.fromMap(JsonMap _json) {
  String get child {
    final Object? val = _json['child'];
    if (val is String) return val;
    throw ArgumentError('Invalid child: $val');
  }

  JsonMap get action => _json['action'] as JsonMap;
  String? get variant => _json['variant'] as String?;
  List<JsonMap>? get checks => (_json['checks'] as List?)?.cast<JsonMap>();
}

/// A button that triggers an action when pressed, rendered with
/// shadcn_flutter's button styles.
///
/// ## Parameters:
///
/// - `child`: The ID of a child widget to display inside the button.
/// - `action`: The action to perform when the button is pressed.
/// - `variant`: A hint for the button style ('primary', 'secondary',
///   'outline' or 'ghost').
final button = CatalogItem(
  name: 'Button',
  dataSchema: _schema,
  widgetBuilder: (itemContext) {
    final data = _ButtonData.fromMap(itemContext.data as JsonMap);
    final child = itemContext.buildChild(data.child);

    return StreamBuilder<String?>(
      stream: ValidationHelper.validateStream(
        data.checks,
        itemContext.dataContext,
      ),
      builder: (context, snapshot) {
        final enabled = snapshot.data == null;
        final onPressed = enabled
            ? () => _handlePress(itemContext, data)
            : null;

        return switch (data.variant) {
          'secondary' => SecondaryButton(onPressed: onPressed, child: child),
          'outline' => OutlineButton(onPressed: onPressed, child: child),
          'ghost' => GhostButton(onPressed: onPressed, child: child),
          _ => PrimaryButton(onPressed: onPressed, child: child),
        };
      },
    );
  },
  exampleData: [
    () => '''
      [
        {
          "id": "root",
          "component": "Button",
          "child": "text",
          "action": {
            "event": {
              "name": "button_pressed"
            }
          }
        },
        {
          "id": "text",
          "component": "Text",
          "text": "Hello World"
        }
      ]
    ''',
  ],
);

Future<void> _handlePress(
  CatalogItemContext itemContext,
  _ButtonData buttonData,
) async {
  final JsonMap actionData = buttonData.action;
  if (actionData.containsKey('event')) {
    final eventMap = actionData['event'] as JsonMap;
    final actionName = eventMap['name'] as String;
    final contextDefinition = eventMap['context'] as JsonMap?;

    final JsonMap resolvedContext = await resolveContext(
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

    final Stream<Object?> resultStream = itemContext.dataContext.resolve(
      funcMap,
    );
    try {
      await resultStream.first;
    } catch (exception, stackTrace) {
      itemContext.reportError(exception, stackTrace);
    }
  }
}
