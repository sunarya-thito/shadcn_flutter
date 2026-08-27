import 'package:material_ui/material_ui.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builds the platform's own text selection toolbar for a text field.
///
/// Delegates to Material's `AdaptiveTextSelectionToolbar`, which picks the
/// Android, iOS, macOS, Windows, Linux or Fuchsia toolbar to match the current
/// platform. This is the behaviour `TextField.nativeContextMenuBuilder()`
/// used to provide before Material was split out of shadcn_flutter.
///
/// Pass it straight to a field:
/// ```dart
/// TextField(
///   contextMenuBuilder: buildAdaptiveEditableTextContextMenu,
/// );
/// ```
///
/// See also:
///  * [buildMaterialEditableTextContextMenu], which always uses the Material
///    toolbar regardless of platform.
///  * `buildEditableTextContextMenu` in `package:shadcn_flutter`, the default,
///    which renders shadcn styled menus instead.
Widget buildAdaptiveEditableTextContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return material.AdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}

/// Builds a Material Design text selection toolbar for a text field.
///
/// Unlike [buildAdaptiveEditableTextContextMenu] this uses the Material toolbar
/// on every platform. This is the behaviour `TextField.materialContextMenuBuilder()`
/// used to provide.
///
/// Requires [kMaterialLocalizationsDelegates] to be registered, since the
/// button labels come from `MaterialLocalizations`.
///
/// ```dart
/// TextField(
///   contextMenuBuilder: buildMaterialEditableTextContextMenu,
/// );
/// ```
Widget buildMaterialEditableTextContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  final TextSelectionToolbarAnchors anchors =
      editableTextState.contextMenuAnchors;
  return material.TextSelectionToolbar(
    anchorAbove: anchors.primaryAnchor,
    anchorBelow: anchors.secondaryAnchor ?? anchors.primaryAnchor,
    children: _buildMaterialButtons(
      context,
      editableTextState.contextMenuButtonItems,
    ),
  );
}

List<Widget> _buildMaterialButtons(
  BuildContext context,
  List<ContextMenuButtonItem> buttonItems,
) {
  final List<Widget> buttons = <Widget>[];
  for (int i = 0; i < buttonItems.length; i++) {
    final ContextMenuButtonItem buttonItem = buttonItems[i];
    buttons.add(
      material.TextSelectionToolbarTextButton(
        padding: material.TextSelectionToolbarTextButton.getPadding(
          i,
          buttonItems.length,
        ),
        onPressed: buttonItem.onPressed,
        alignment: AlignmentDirectional.centerStart,
        child: Text(_materialButtonLabel(context, buttonItem)),
      ),
    );
  }
  return buttons;
}

String _materialButtonLabel(
  BuildContext context,
  ContextMenuButtonItem buttonItem,
) {
  final material.MaterialLocalizations localizations =
      material.MaterialLocalizations.of(context);
  return switch (buttonItem.type) {
    ContextMenuButtonType.cut => localizations.cutButtonLabel,
    ContextMenuButtonType.copy => localizations.copyButtonLabel,
    ContextMenuButtonType.paste => localizations.pasteButtonLabel,
    ContextMenuButtonType.selectAll => localizations.selectAllButtonLabel,
    ContextMenuButtonType.delete =>
      localizations.deleteButtonTooltip.toUpperCase(),
    ContextMenuButtonType.lookUp => localizations.lookUpButtonLabel,
    ContextMenuButtonType.searchWeb => localizations.searchWebButtonLabel,
    ContextMenuButtonType.share => localizations.shareButtonLabel,
    ContextMenuButtonType.liveTextInput => localizations.scanTextButtonLabel,
    ContextMenuButtonType.custom => '',
  };
}

/// Builds the Material spell check suggestions toolbar for a text field.
///
/// The shadcn_flutter equivalent is `SpellCheckSuggestionsToolbar`, which is the
/// default; use this to match Android instead.
///
/// ```dart
/// TextField(
///   spellCheckConfiguration: const SpellCheckConfiguration(
///     spellCheckService: DefaultSpellCheckService(),
///   ).copyWith(
///     spellCheckSuggestionsToolbarBuilder:
///         buildMaterialSpellCheckSuggestionsToolbar,
///   ),
/// );
/// ```
Widget buildMaterialSpellCheckSuggestionsToolbar(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return material.SpellCheckSuggestionsToolbar.editableText(
    editableTextState: editableTextState,
  );
}
