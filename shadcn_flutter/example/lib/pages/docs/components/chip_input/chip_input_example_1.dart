import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipInputExample1 extends StatefulWidget {
  @override
  State<ChipInputExample1> createState() => _ChipInputExample1State();
}

class _ChipInputExample1State extends State<ChipInputExample1> {
  final List<String> _chips = [];
  final List<String> _suggestions = [];
  final TextEditingController _controller = TextEditingController();
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
          var value = _controller.text;
          _suggestions.clear();
          if (value.isNotEmpty) {
            _suggestions.addAll(_availableSuggestions.where((element) {
              return element.startsWith(value);
            }));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChipInput(
      controller: _controller,
      onSubmitted: (value) {
        setState(() {
          _chips.add(value);
          _suggestions.clear();
          _controller.clear();
        });
      },
      suggestions: _suggestions.map(
        (e) {
          return Text(e);
        },
      ).toList(),
      onSuggestionChoosen: (index) {
        setState(() {
          _chips.add(_suggestions[index]);
          _controller.clear();
        });
      },
      chips: _chips.map(
        (e) {
          return Chip(
            trailing: ChipButton(
              onPressed: () {
                setState(() {
                  _chips.remove(e);
                });
              },
              child: const Icon(Icons.close),
            ),
            child: Text(e),
          );
        },
      ).toList(),
    );
  }
}
