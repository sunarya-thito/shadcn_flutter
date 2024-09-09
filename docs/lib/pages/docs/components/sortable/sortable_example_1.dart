import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<SortableExample1> {
  late List<SortableItem> items;

  SortableItem _createItem(String name) {
    return SortableItem(
      child: FruitItem(
        fruit: name,
        onRemove: (item) {
          setState(() {
            items.removeWhere((element) => element.child == item);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    items = [
      _createItem('Apple'),
      _createItem('Banana'),
      _createItem('Cherry'),
      _createItem('Date'),
      _createItem('Elderberry'),
      _createItem('Fig'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DragSortable(
          shrinkWrap: true,
          onAdded: (index, item) {
            setState(() {
              items.insert(index, item);
            });
          },
          onRemoved: (index) {
            setState(() {
              items.removeAt(index);
            });
          },
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final item = items.removeAt(oldIndex);
              if (newIndex > oldIndex) newIndex--;
              items.insert(newIndex, item);
            });
          },
          items: items,
        ),
        const Gap(16),
        PrimaryButton(
          alignment: Alignment.center,
          onPressed: () {
            TextEditingController fruit = TextEditingController();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Fruit'),
                  content: TextField(
                    controller: fruit,
                    placeholder: 'Enter fruit name',
                  ),
                  actions: [
                    SecondaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    PrimaryButton(
                      onPressed: () {
                        setState(() {
                          items.add(_createItem(fruit.text));
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class FruitItem extends StatelessWidget {
  final String fruit;
  final ValueChanged<FruitItem> onRemove;

  const FruitItem({super.key, required this.fruit, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Text(fruit),
          ),
          const SizedBox(width: 8),
          GhostButton(
            density: ButtonDensity.icon,
            onPressed: () {
              onRemove(this);
            },
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
          const SortableHandle(
            child: Icon(Icons.drag_indicator),
          ),
        ],
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FruitItem(fruit: $fruit)';
  }
}
