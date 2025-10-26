import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipInputExample1 extends StatefulWidget {
  const ChipInputExample1({super.key});

  @override
  State<ChipInputExample1> createState() => _ChipInputExample1State();
}

class _ChipInputExample1State extends State<ChipInputExample1> {
  List<String> _suggestions = [];
  final ChipEditingController<String> _controller = ChipEditingController();
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
          var value =
              _controller.plainText; // IMPORTANT: use plainText instead of text
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
        ChipInput<String>(
          controller: _controller,
          onSubmitted: (value) {
            setState(() {
              _suggestions.clear();
            });
            return '@$value';
          },
          suggestions: _suggestions,
          chipBuilder: (context, chip) {
            return Text(chip);
          },
        ),
        gap(24),
        ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            return Text('Current chips: ${_controller.chips.join(', ')}');
          },
        ),
      ],
    );
  }
}
