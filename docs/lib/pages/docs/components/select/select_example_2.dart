import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample2 extends StatefulWidget {
  const SelectExample2({super.key});

  @override
  State<SelectExample2> createState() => _SelectExample2State();
}

class _SelectExample2State extends State<SelectExample2> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  String? selectedValue;

  Iterable<MapEntry<String, List<String>>> _filteredFruits(
      String searchQuery) sync* {
    for (final entry in fruits.entries) {
      final filteredValues = entry.value
          .where((value) => _filterName(value, searchQuery))
          .toList();
      if (filteredValues.isNotEmpty) {
        yield MapEntry(entry.key, filteredValues);
      } else if (_filterName(entry.key, searchQuery)) {
        yield entry;
      }
    }
  }

  bool _filterName(String name, String searchQuery) {
    return name.toLowerCase().contains(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popup: SelectPopup.builder(
        searchPlaceholder: const Text('Search fruit'),
        builder: (context, searchQuery) {
          final filteredFruits = searchQuery == null
              ? fruits.entries
              : _filteredFruits(searchQuery);
          return SelectItemList(
            children: [
              for (final entry in filteredFruits)
                SelectGroup(
                  headers: [
                    SelectLabel(
                      child: Text(entry.key),
                    ),
                  ],
                  children: [
                    for (final value in entry.value)
                      SelectItemButton(
                        value: value,
                        child: Text(value),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
    );
  }
}
