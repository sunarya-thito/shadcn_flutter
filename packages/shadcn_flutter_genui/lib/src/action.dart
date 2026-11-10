import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:json_schema_builder/json_schema_builder.dart'
    hide ValidationResult;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;

/// Declares the `closeModal` function, so that a catalog accepts actions that
/// call it. [dispatchA2uiAction] closes the overlay itself, since a function
/// has no access to the widget tree; run any other way, it does nothing.
class CloseModalFunction extends FunctionImplementation {
  CloseModalFunction()
    : super(
        name: 'closeModal',
        description: 'Closes the Modal that contains the component.',
        argumentSchema: S.object(),
        returnType: A2uiReturnType.void_,
      );

  @override
  Object? execute(
    Map<String, dynamic> args,
    DataContext context, [
    CancellationSignal? cancellationSignal,
  ]) => null;
}

/// Executes the A2UI action in the property [key] of [node] using the same
/// event/function semantics as the A2UI basic catalog, except that a
/// `closeModal` function call closes the shadcn overlay around [context].
void dispatchA2uiAction(
  BuildContext context,
  ComponentNode<ComponentImplementation> node,
  ComponentProps props,
  String key,
) {
  final action = node.context?.componentModel.properties[key];
  if (action case {'functionCall': {'call': 'closeModal'}}) {
    if (context.mounted) {
      shad.closeOverlay(context);
    }
    return;
  }
  unawaited(props.action(key)?.call());
}
