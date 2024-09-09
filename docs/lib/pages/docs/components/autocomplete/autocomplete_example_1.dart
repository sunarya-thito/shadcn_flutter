import 'package:shadcn_flutter/shadcn_flutter.dart';

class AutoCompleteExample1 extends StatefulWidget {
  const AutoCompleteExample1({super.key});

  @override
  State<AutoCompleteExample1> createState() => _AutoCompleteExample1State();
}

class _AutoCompleteExample1State extends State<AutoCompleteExample1> {
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

  List<String> _currentSuggestions = [];
  final TextEditingController _controller = TextEditingController();

  void _updateSuggestions(String value) {
    if (value.isEmpty) {
      setState(() {
        _currentSuggestions = [];
      });
      return;
    }
    setState(() {
      _currentSuggestions = suggestions
          .where(
              (element) => element.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoComplete(
      controller: _controller,
      suggestions: _currentSuggestions,
      onChanged: (value) {
        _updateSuggestions(value);
      },
      trailing: IconButton.text(
        icon: const Icon(Icons.clear),
        onPressed: () {
          _controller.clear();
          setState(() {
            _currentSuggestions = [];
          });
        },
      ),
      onAcceptSuggestion: (value) {
        _controller.text = _currentSuggestions[value];
        setState(() {
          _currentSuggestions = [];
        });
      },
    );
  }
}
