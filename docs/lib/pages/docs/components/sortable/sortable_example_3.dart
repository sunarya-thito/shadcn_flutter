import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample3 extends StatefulWidget {
  const SortableExample3({super.key});

  @override
  State<SortableExample3> createState() => _SortableExample3State();
}

class _SortableExample3State extends State<SortableExample3> {
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
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < names.length; i++)
                Sortable<int>(
                  key: ValueKey(i),
                  data: i,
                  onAcceptLeft: (value) {
                    setState(() {
                      bool isBefore = i < value.data;
                      if (isBefore) {
                        names.insert(i, names.removeAt(value.data));
                      } else {
                        names.insert(i - 1, names.removeAt(value.data));
                      }
                    });
                  },
                  onAcceptRight: (value) {
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
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i])),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
