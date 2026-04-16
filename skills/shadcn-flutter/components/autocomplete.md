# AutoCompleteTheme

Theme configuration for [AutoComplete] widget styling and behavior.

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
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `popoverConstraints` | `BoxConstraints?` | Constraints applied to the autocomplete popover container.  Controls the maximum/minimum dimensions of the suggestion list popover. Defaults to a maximum height of 300 logical pixels when null. |
| `popoverWidthConstraint` | `PopoverConstraint?` | Width constraint strategy for the autocomplete popover.  Determines how the popover width relates to its anchor (the text field). Options include matching anchor width, flexible sizing, or fixed dimensions. |
| `popoverAnchorAlignment` | `AlignmentDirectional?` | Alignment point on the anchor widget where the popover attaches.  Specifies which edge/corner of the text field the popover should align to. Defaults to bottom-start (bottom-left in LTR, bottom-right in RTL). |
| `popoverAlignment` | `AlignmentDirectional?` | Alignment point on the popover that aligns with the anchor point.  Specifies which edge/corner of the popover aligns with the anchor alignment. Defaults to top-start (top-left in LTR, top-right in RTL). |
| `mode` | `AutoCompleteMode?` | Default mode for how suggestions are applied to text fields.  Controls the text replacement strategy when a suggestion is selected. Defaults to [AutoCompleteMode.replaceWord] when null. |
