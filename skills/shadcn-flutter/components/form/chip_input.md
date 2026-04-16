# ChipInput

A text input widget that supports inline chip elements.

## Usage

### Chip Input Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'chip_input/chip_input_example_1.dart';

class ChipInputExample extends StatelessWidget {
  const ChipInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'chip_input',
      description:
          'A chip input is a text input that allows users to input multiple chips.',
      displayName: 'Chip Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/chip_input/chip_input_example_1.dart',
          child: ChipInputExample1(),
        ),
      ],
    );
  }
}

```

### Chip Input Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// ChipInput with inline autocomplete suggestions.
///
/// Shows how to:
/// - Listen to a [ChipEditingController] to compute suggestions based on
///   the current token being typed (using [textAtCursor]).
/// - Wrap [ChipInput] with [AutoComplete] to display suggestions.
/// - Transform submitted chips (here we prepend '@').
class ChipInputExample1 extends StatefulWidget {
  const ChipInputExample1({super.key});

  @override
  State<ChipInputExample1> createState() => _ChipInputExample1State();
}

class _ChipInputExample1State extends State<ChipInputExample1> {
  // Current filtered suggestions for the token at the cursor.
  List<String> _suggestions = [];
  // Controller manages both chips and text entry.
  final ChipEditingController<String> _controller = ChipEditingController();
  // Static suggestion pool to match against.
  static const List<String> _availableSuggestions = [
    'hello world',
    'lorem ipsum',
    'do re mi',
    'foo bar',
    'flutter dart',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        setState(() {
          // IMPORTANT: use textAtCursor instead of text so we only consider
          // the current token under the caret when filtering suggestions.
          var value = _controller.textAtCursor;
          if (value.isNotEmpty) {
            _suggestions = _availableSuggestions.where((element) {
              return element.startsWith(value);
            }).toList();
          } else {
            _suggestions = [];
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoComplete(
          // Provide suggestions to show below the input as the user types.
          suggestions: _suggestions,
          child: ChipInput<String>(
            controller: _controller,
            onChipSubmitted: (value) {
              setState(() {
                _suggestions = [];
              });
              // Transform the chip value before storing it.
              return '@$value';
            },
            chipBuilder: (context, chip) {
              return Text(chip);
            },
          ),
        ),
        gap(24),
        ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            // Reflect the current chip list for demonstration.
            return Text('Current chips: ${_controller.chips.join(', ')}');
          },
        ),
      ],
    );
  }
}

```

### Chip Input Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ChipInputTile extends StatelessWidget implements IComponentPage {
  const ChipInputTile({super.key});

  @override
  String get title => 'Chip Input';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'chip_input',
      title: 'Chip Input',
      scale: 1,
      example: Card(
        child: SizedBox(
          width: 300,
          height: 300,
          child: OutlinedContainer(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    // Empty for now - chip input components would go here
                  ],
                ),
              ),
            ),
          ),
        ),
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
| `chipBuilder` | `ChipWidgetBuilder<T>` | Builder function for creating chip widgets. |
| `onChipSubmitted` | `ChipSubmissionCallback<T>` | Callback to convert text into a chip object. |
| `onChipsChanged` | `ValueChanged<List<T>>?` | Callback invoked when the list of chips changes. |
| `useChips` | `bool?` | Whether to display items as visual chips (defaults to theme setting). |
| `initialChips` | `List<T>?` | Initial chips to display in the input. |
| `autoInsertSuggestion` | `bool` | Whether to automatically insert autocomplete suggestions as chips. |
