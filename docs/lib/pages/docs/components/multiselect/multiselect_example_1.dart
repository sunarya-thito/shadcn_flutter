import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiSelectExample1 extends StatefulWidget {
  const MultiSelectExample1({super.key});

  @override
  State<MultiSelectExample1> createState() => _MultiSelectExample1State();
}

class _MultiSelectExample1State extends State<MultiSelectExample1> {
  Iterable<String>? selectedValues;
  @override
  Widget build(BuildContext context) {
    return MultiSelect<String>(
      itemBuilder: (context, item) {
        return MultiSelectChip(value: item, child: Text(item));
      },
      popup: const SelectPopup(
          items: SelectItemList(children: [
        SelectItemButton(
          value: 'Apple',
          child: Text('Apple'),
        ),
        SelectItemButton(
          value: 'Banana',
          child: Text('Banana'),
        ),
        SelectItemButton(
          value: 'Cherry',
          child: Text('Cherry'),
        ),
      ])),
      onChanged: (value) {
        setState(() {
          selectedValues = value;
        });
      },
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValues,
      placeholder: const Text('Select a fruit'),
    );
  }
}
