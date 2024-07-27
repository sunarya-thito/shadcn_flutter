import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<SortableExample1> {
  final List<String> _items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
  ];
  @override
  Widget build(BuildContext context) {
    return Sortable<FruitItem>(
      onTaken: (index) {
        setState(() {
          _items.removeAt(index);
        });
      },
      onInsert: (index, child) {
        setState(() {
          _items.insert(index, child.fruit);
        });
      },
      onSort: (oldIndex, newIndex) {
        setState(() {
          final item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      children: [
        for (var item in _items)
          FruitItem(
            fruit: item,
          ),
      ],
    );
  }
}

class FruitItem extends StatelessWidget {
  final String fruit;

  const FruitItem({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Text(fruit),
          ),
          const SortableItemHandle(
            child: Icon(Icons.drag_indicator),
          ),
        ],
      ),
    );
  }
}
