import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample2 extends StatefulWidget {
  const SortableExample2({super.key});

  @override
  State<SortableExample2> createState() => _SortableExample2State();
}

class _SortableExample2State extends State<SortableExample2> {
  List<String> names = [
    'James',
    'John',
    'Robert',
    'Michael',
    'William',
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      lock: true,
      child: SortableDropFallback<int>(
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<int>(
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
              ),
          ],
        ),
      ),
    );
  }
}
