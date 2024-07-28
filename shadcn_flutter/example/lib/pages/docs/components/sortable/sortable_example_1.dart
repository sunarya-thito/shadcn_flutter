import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<SortableExample1> {
  late SortableController<String> sortableController;

  @override
  void initState() {
    super.initState();
    sortableController = SortableController<String>([
      'Apple',
      'Banana',
      'Cherry',
      'Date',
      'Elderberry',
      'Fig',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Sortable(
      controller: sortableController,
      dividerBuilder: (context, index) {
        return gap(4);
      },
      builder: (context, child) {
        return FruitItem(fruit: child);
      },
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
