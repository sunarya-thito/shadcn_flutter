import 'dart:async';

import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

/// Executes an A2UI action using the same event/function semantics as GenUI's
/// basic catalog.
Future<void> dispatchA2uiAction(
  CatalogItemContext context,
  JsonMap action,
) async {
  final event = action['event'];
  if (event is JsonMap) {
    final name = event['name'];
    if (name is! String) {
      context.reportError(
        ArgumentError.value(name, 'action.event.name', 'Must be a string'),
        StackTrace.current,
      );
      return;
    }
    final definition = event['context'];
    final resolved = await resolveContext(
      context.dataContext,
      definition is JsonMap ? definition : null,
    );
    context.dispatchEvent(
      UserActionEvent(
        name: name,
        sourceComponentId: context.id,
        context: resolved,
      ),
    );
    return;
  }

  final functionCall = action['functionCall'];
  if (functionCall is JsonMap) {
    final call = functionCall['call'];
    if (call == 'closeModal') {
      if (context.buildContext.mounted) {
        shad.closeOverlay(context.buildContext);
      }
      return;
    }
    final iterator = StreamIterator<Object?>(
      context.dataContext.resolve(functionCall),
    );
    try {
      await iterator.moveNext().timeout(const Duration(seconds: 10));
    } catch (error, stackTrace) {
      context.reportError(error, stackTrace);
    } finally {
      await iterator.cancel();
    }
    return;
  }

  context.reportError(
    ArgumentError.value(action, 'action', 'Expected event or functionCall'),
    StackTrace.current,
  );
}
