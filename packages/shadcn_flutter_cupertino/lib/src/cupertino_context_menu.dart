import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builds an iOS-style text selection toolbar for a text field.
///
/// Delegates to `CupertinoAdaptiveTextSelectionToolbar`, which picks the iOS or
/// macOS toolbar to match the current platform. This is the behaviour
/// `TextField.cupertinoContextMenuBuilder()` used to provide before Cupertino
/// was split out of shadcn_flutter.
///
/// ```dart
/// TextField(
///   contextMenuBuilder: buildCupertinoEditableTextContextMenu,
/// );
/// ```
///
/// See also:
///  * `buildEditableTextContextMenu` in `package:shadcn_flutter`, the default,
///    which renders shadcn styled menus instead.
Widget buildCupertinoEditableTextContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return cupertino.CupertinoAdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}

/// Builds the iOS spell check suggestions toolbar for a text field.
///
/// The shadcn_flutter equivalent is `SpellCheckSuggestionsToolbar`, which is the
/// default; use this to match iOS instead.
///
/// ```dart
/// TextField(
///   spellCheckConfiguration: const SpellCheckConfiguration(
///     spellCheckService: DefaultSpellCheckService(),
///   ).copyWith(
///     spellCheckSuggestionsToolbarBuilder:
///         buildCupertinoSpellCheckSuggestionsToolbar,
///   ),
/// );
/// ```
Widget buildCupertinoSpellCheckSuggestionsToolbar(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return cupertino.CupertinoSpellCheckSuggestionsToolbar.editableText(
    editableTextState: editableTextState,
  );
}
