# AutoComplete

Intelligent autocomplete functionality with customizable suggestion handling.

## Usage

### Autocomplete Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'autocomplete/autocomplete_example_1.dart';

class AutoCompleteExample extends StatelessWidget {
  const AutoCompleteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'autocomplete',
      description: 'A text input with suggestions.',
      displayName: 'AutoComplete',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/autocomplete/autocomplete_example_1.dart',
          child: AutoCompleteExample1(),
        ),
      ],
    );
  }
}

```

### Autocomplete Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AutoComplete with a TextField and filtered suggestions.
///
/// Typing in the field updates the current word under the caret using
/// [TextEditingController.currentWord] and filters a static list of fruits.
/// The [AutoComplete] widget displays suggestions provided via `suggestions`.
class AutoCompleteExample1 extends StatefulWidget {
  const AutoCompleteExample1({super.key});

  @override
  State<AutoCompleteExample1> createState() => _AutoCompleteExample1State();
}

class _AutoCompleteExample1State extends State<AutoCompleteExample1> {
  // Source data for suggestions.
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  // Filtered suggestions for the current input word.
  List<String> _currentSuggestions = [];
  // Controller for reading the current text and word at the caret.
  final TextEditingController _controller = TextEditingController();

  // Update the filtered suggestions based on the current word being typed.
  void _updateSuggestions(String value) {
    String? currentWord = _controller.currentWord;
    if (currentWord == null || currentWord.isEmpty) {
      setState(() {
        _currentSuggestions = [];
      });
      return;
    }
    setState(() {
      _currentSuggestions = suggestions
          .where((element) =>
              element.toLowerCase().contains(currentWord.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoComplete(
      // Provide the list to be shown in the overlay.
      suggestions: _currentSuggestions,
      child: TextField(
        controller: _controller,
        // Each keystroke recalculates the suggestions.
        onChanged: _updateSuggestions,
        features: const [
          InputFeature.clear(),
        ],
      ),
    );
  }
}

```

### Autocomplete Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AutocompleteTile extends StatelessWidget implements IComponentPage {
  const AutocompleteTile({super.key});

  @override
  String get title => 'Autocomplete';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'autocomplete',
      title: 'Autocomplete',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const TextField(
              placeholder: Text('Search fruits...'),
              features: [
                InputFeature.trailing(Icon(LucideIcons.search)),
              ],
            ),
            const Gap(8),
            OutlinedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button(
                    style: const ButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Apple'),
                  ),
                  Button(
                    style: const ButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Banana'),
                  ),
                  Button(
                    style: const ButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Cherry'),
                  ),
                ],
              ),
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}

```



## Features
- **Multiple completion modes**: append, replace word, or replace all text
- **Keyboard navigation**: arrow keys to navigate, tab/enter to accept
- **Customizable presentation**: popover positioning, sizing, and constraints
- **Smart suggestion filtering**: automatically manages suggestion visibility
- **Accessibility support**: proper focus management and keyboard shortcuts

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `suggestions` | `List<String>` | List of suggestions to display in the autocomplete popover.  When non-empty, triggers the popover to appear with selectable options. The suggestions are filtered and managed externally - this widget only handles the presentation and selection logic. |
| `child` | `Widget` | The child widget that receives autocomplete functionality.  Typically a [TextField] or similar text input widget. The autocomplete popover will be positioned relative to this widget, and keyboard actions will be applied to the focused text field within this child tree. |
| `popoverConstraints` | `BoxConstraints?` | Constraints applied to the autocomplete popover container.  Overrides the theme default. Controls maximum/minimum dimensions of the suggestion list. When null, uses theme value or framework default. |
| `popoverWidthConstraint` | `PopoverConstraint?` | Width constraint strategy for the autocomplete popover.  Overrides the theme default. Determines how popover width relates to the anchor widget. When null, uses theme value or matches anchor width. |
| `popoverAnchorAlignment` | `AlignmentDirectional?` | Alignment point on the anchor widget for popover attachment.  Overrides the theme default. Specifies which edge/corner of the child widget the popover aligns to. When null, uses theme or bottom-start. |
| `popoverAlignment` | `AlignmentDirectional?` | Alignment point on the popover for anchor attachment.  Overrides the theme default. Specifies which edge/corner of the popover aligns with the anchor point. When null, uses theme or top-start. |
| `mode` | `AutoCompleteMode?` | Text replacement strategy when a suggestion is selected.  Overrides the theme default. Controls how selected suggestions modify the text field content. When null, uses theme or [AutoCompleteMode.replaceWord]. |
| `completer` | `AutoCompleteCompleter` | Function to customize suggestion text before application.  Called when a suggestion is selected, allowing modification of the final text inserted into the field. Useful for adding prefixes, suffixes, or formatting. Defaults to returning the suggestion unchanged. |
