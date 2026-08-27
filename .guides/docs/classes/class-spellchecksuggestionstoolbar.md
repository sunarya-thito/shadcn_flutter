---
title: "Class: SpellCheckSuggestionsToolbar"
description: "A shadcn styled toolbar offering spell check replacements for the  misspelled word under the cursor.   This is the shadcn_flutter replacement for the Material  `SpellCheckSuggestionsToolbar` and the Cupertino  `CupertinoSpellCheckSuggestionsToolbar` — it carries no dependency on either  library and renders through the same [ContextMenuPopup] used by the rest of  this package's menus.   It is the default for [TextField.spellCheckConfiguration], and is used  automatically whenever a [SpellCheckConfiguration] is enabled on a field:   ```dart  TextField(    spellCheckConfiguration: const SpellCheckConfiguration(      spellCheckService: DefaultSpellCheckService(),    ),  );  ```   See also:   * [buildEditableTextContextMenu], which builds the ordinary cut/copy/paste     context menu for a text field."
---

```dart
/// A shadcn styled toolbar offering spell check replacements for the
/// misspelled word under the cursor.
///
/// This is the shadcn_flutter replacement for the Material
/// `SpellCheckSuggestionsToolbar` and the Cupertino
/// `CupertinoSpellCheckSuggestionsToolbar` — it carries no dependency on either
/// library and renders through the same [ContextMenuPopup] used by the rest of
/// this package's menus.
///
/// It is the default for [TextField.spellCheckConfiguration], and is used
/// automatically whenever a [SpellCheckConfiguration] is enabled on a field:
///
/// ```dart
/// TextField(
///   spellCheckConfiguration: const SpellCheckConfiguration(
///     spellCheckService: DefaultSpellCheckService(),
///   ),
/// );
/// ```
///
/// See also:
///  * [buildEditableTextContextMenu], which builds the ordinary cut/copy/paste
///    context menu for a text field.
class SpellCheckSuggestionsToolbar extends StatelessWidget {
  /// Creates a spell check suggestions toolbar from explicit button items.
  ///
  /// [buttonItems] must not contain more than three items, mirroring the
  /// platform convention.
  const SpellCheckSuggestionsToolbar({super.key, required this.anchors, required this.buttonItems});
  /// Creates a spell check suggestions toolbar for an [EditableText].
  ///
  /// Reads the misspelled span under the cursor from [editableTextState] and
  /// turns its suggestions into replacement buttons. If there is no misspelled
  /// span the toolbar builds to nothing.
  SpellCheckSuggestionsToolbar.editableText({super.key, required EditableTextState editableTextState});
  /// Where to anchor the toolbar relative to the text field.
  final TextSelectionToolbarAnchors anchors;
  /// The replacement suggestions to display, at most three.
  final List<ContextMenuButtonItem> buttonItems;
  /// Builds the replacement buttons for the misspelled word under the cursor.
  ///
  /// Returns null when the cursor is not inside a misspelled span, which the
  /// callers treat as "render nothing". Returns a single disabled item when the
  /// word is misspelled but the spell check service has no suggestion for it.
  static List<ContextMenuButtonItem>? buildButtonItems(EditableTextState editableTextState);
  Widget build(BuildContext context);
}
```
