import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample1 extends StatefulWidget {
  const SelectExample1({super.key});

  @override
  State<SelectExample1> createState() => _SelectExample1State();
}

class _SelectExample1State extends State<SelectExample1> {
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
        maxHeight: 300,
        maxWidth: 200,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
      children: const [
        SelectGroup(
          headers: [
            SelectLabel(
              child: Text('Apple'),
            ),
          ],
          children: [
            SelectItemButton(
              value: 'Red Apple',
              child: Text('Red Apple'),
            ),
            SelectItemButton(
              value: 'Green Apple',
              child: Text('Green Apple'),
            ),
          ],
        ),
        SelectGroup(
          headers: [
            SelectLabel(
              child: Text('Banana'),
            ),
          ],
          children: [
            SelectItemButton(
              value: 'Yellow Banana',
              child: Text('Yellow Banana'),
            ),
            SelectItemButton(
              value: 'Brown Banana',
              child: Text('Brown Banana'),
            ),
          ],
        ),
        SelectGroup(
          headers: [
            SelectLabel(
              child: Text('Lemon'),
            ),
          ],
          children: [
            SelectItemButton(
              value: 'Yellow Lemon',
              child: Text('Yellow Lemon'),
            ),
            SelectItemButton(
              value: 'Green Lemon',
              child: Text('Green Lemon'),
            ),
          ],
        ),
        SelectGroup(
          headers: [
            SelectLabel(
              child: Text('Tomato'),
            ),
          ],
          children: [
            SelectItemButton(
              value: 'Red Tomato',
              child: Text('Red'),
            ),
            SelectItemButton(
              value: 'Green Tomato',
              child: Text('Green'),
            ),
            SelectItemButton(
              value: 'Yellow Tomato',
              child: Text('Yellow'),
            ),
            SelectItemButton(
              value: 'Brown Tomato',
              child: Text('Brown'),
            ),
          ],
        ),
      ],
    );
  }
}
