import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample2 extends StatefulWidget {
  const SortableExample2({super.key});

  @override
  State<SortableExample2> createState() => _SortableExample2State();
}

class _SortableExample2State extends State<SortableExample2> {
  late SortableController<String> sortableController1;
  late SortableController<String> sortableController2;

  @override
  void initState() {
    super.initState();
    sortableController1 = SortableController<String>([
      'Apple',
      'Banana',
      'Cherry',
      'Date',
      'Elderberry',
      'Fig',
    ]);
    sortableController2 = SortableController<String>([]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              child: Sortable(
                controller: sortableController1,
                dividerBuilder: (context, index) {
                  return gap(4);
                },
                builder: (context, child) {
                  return FruitItem(fruit: child);
                },
              ),
            ),
          ),
          gap(16),
          Expanded(
            child: Card(
              child: Sortable(
                controller: sortableController2,
                dividerBuilder: (context, index) {
                  return gap(4);
                },
                builder: (context, child) {
                  return FruitItem(fruit: child);
                },
              ),
            ),
          ),
        ],
      ),
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
