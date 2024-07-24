import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipInputExample1 extends StatefulWidget {
  @override
  State<ChipInputExample1> createState() => _ChipInputExample1State();
}

class _ChipInputExample1State extends State<ChipInputExample1> {
  final List<String> _chips = [];
  final List<String> _suggestions = [];
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChipInput(
      controller: _controller,
      onTextChanged: (value) {},
      onSubmitted: (value) {
        setState(() {
          _chips.add(value);
          _controller.clear();
        });
      },
      suggestions: _suggestions.map(
        (e) {
          return Text(e);
        },
      ).toList(),
      onChipRemoved: (index) {
        setState(() {
          _chips.removeAt(index);
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
