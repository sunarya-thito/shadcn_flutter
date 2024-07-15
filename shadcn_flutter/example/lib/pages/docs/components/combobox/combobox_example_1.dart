import 'package:shadcn_flutter/shadcn_flutter.dart';

class ComboboxExample1 extends StatefulWidget {
  const ComboboxExample1({super.key});

  @override
  State<ComboboxExample1> createState() => _ComboboxExample1State();
}

class _ComboboxExample1State extends State<ComboboxExample1> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      searchFilter: (item, query) {
        return item.toLowerCase().contains(query.toLowerCase()) ? 1 : 0;
      },
      popupConstraints: const BoxConstraints(
        maxHeight: 200,
      ),
      placeholder: Text('Select a fruit'),
      children: [
        SelectItemButton(
          value: 'Red Apple',
          child: Text('Red Apple'),
        ),
        SelectItemButton(
          value: 'Green Apple',
          child: Text('Green Apple'),
        ),
        SelectItemButton(
          value: 'Yellow Banana',
          child: Text('Yellow Banana'),
        ),
        SelectItemButton(
          value: 'Brown Banana',
          child: Text('Brown Banana'),
        ),
        SelectItemButton(
          value: 'Yellow Lemon',
          child: Text('Yellow Lemon'),
        ),
        SelectItemButton(
          value: 'Green Lemon',
          child: Text('Green Lemon'),
        ),
        SelectItemButton(
          value: 'Red Tomato',
          child: Text('Red Tomato'),
        ),
        SelectItemButton(
          value: 'Green Tomato',
          child: Text('Green Tomato'),
        ),
        SelectItemButton(
          value: 'Yellow Tomato',
          child: Text('Yellow Tomato'),
        ),
        SelectItemButton(
          value: 'Brown Tomato',
          child: Text('Brown Tomato'),
        ),
      ],
    );
  }
}
