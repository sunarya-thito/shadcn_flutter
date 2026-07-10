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
