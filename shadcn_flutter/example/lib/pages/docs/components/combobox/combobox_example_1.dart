import 'package:shadcn_flutter/shadcn_flutter.dart';

class ComboboxExample1 extends StatefulWidget {
  const ComboboxExample1({super.key});

  @override
  State<ComboboxExample1> createState() => _ComboboxExample1State();
}

class _ComboboxExample1State extends State<ComboboxExample1> {
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select(
      selectedIndex: selectedValue,
      items: const [
        'Red Apple',
        'Green Apple',
        'Yellow Banana',
        'Brown Banana',
        'Yellow Lemon',
        'Green Lemon',
        'Red Tomato',
        'Green Tomato',
        'Yellow Tomato',
        'Brown Tomato',
      ],
      searchFilter: (item, query) {
        return item.toLowerCase().contains(query.toLowerCase()) ? 1 : 0;
      },
      placeholder: const Text('Select a fruit'),
      itemBuilder: (context, item) {
        return Text(item);
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
