# SpellCheckSuggestionsToolbar

A shadcn styled toolbar offering spell check replacements for the
misspelled word under the cursor.

## Usage

### Basic Example
```dart
TextField(
  spellCheckConfiguration: const SpellCheckConfiguration(
    spellCheckService: DefaultSpellCheckService(),
  ),
);
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `anchors` | `TextSelectionToolbarAnchors` | Where to anchor the toolbar relative to the text field. |
| `buttonItems` | `List<ContextMenuButtonItem>` | The replacement suggestions to display, at most three. |
