import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiSelectExample2 extends StatefulWidget {
  const MultiSelectExample2({super.key});

  @override
  State<MultiSelectExample2> createState() => _MultiSelectExample2State();
}

class _MultiSelectExample2State extends State<MultiSelectExample2> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  Iterable<String>? selectedValues;

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
    // Multi-select with grouped options and a search field.
    // The popup is built dynamically and groups items under a label.
    return MultiSelect<String>(
      itemBuilder: (context, item) {
        return MultiSelectChip(value: item, child: Text(item));
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
