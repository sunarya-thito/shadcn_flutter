import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample4 extends StatefulWidget {
  const SortableExample4({super.key});

  @override
  State<SortableExample4> createState() => _SortableExample4State();
}

class _SortableExample4State extends State<SortableExample4> {
  List<String> names = [
    'James',
    'John',
    'Robert',
    'Michael',
    'William',
    'David',
    'Richard',
    'Joseph',
    'Thomas',
    'Charles',
    'Daniel',
    'Matthew',
    'Anthony',
    'Donald',
    'Mark',
    'Paul',
    'Steven',
    'Andrew',
    'Kenneth',
  ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SortableLayer(
        lock: true,
        child: SortableDropFallback<int>(
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          child: ScrollableSortableLayer(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, i) {
                return Sortable<int>(
                  key: ValueKey(i),
                  data: i,
                  onAcceptTop: (value) {
                    setState(() {
                      bool isBefore = i < value.data;
                      if (isBefore) {
                        names.insert(i, names.removeAt(value.data));
                      } else {
                        names.insert(i - 1, names.removeAt(value.data));
                      }
                    });
                  },
                  onAcceptBottom: (value) {
                    setState(() {
                      bool isBefore = i > value.data;
                      if (isBefore) {
                        names.insert(i, names.removeAt(value.data));
                      } else {
                        names.insert(i + 1, names.removeAt(value.data));
                      }
                    });
                  },
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i])),
                  ),
                );
              },
              itemCount: names.length,
            ),
          ),
        ),
      ),
    );
  }
}
