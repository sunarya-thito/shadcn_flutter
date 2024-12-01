import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _IndexData {
  final int index;
  final List<String> names;

  _IndexData(this.index, this.names);
}

class _SortableExample1State extends State<SortableExample1> {
  List<String> names = [
    'James',
    'John',
    'Robert',
    'Michael',
    'William',
  ];
  List<String> names2 = [
    'David',
    'Richard',
    'Joseph',
    'Thomas',
    'Charles',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SortableLayer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                child: SortableDropFallback<_IndexData>(
                  onAccept: (value) {
                    setState(() {
                      names.add(value.data.names.removeAt(value.data.index));
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < names.length; i++)
                        Sortable<_IndexData>(
                          key: ValueKey(i),
                          data: _IndexData(i, names),
                          onAcceptTop: (value) {
                            setState(() {
                              bool isBefore = i < value.data.index ||
                                  value.data.names != names;
                              if (isBefore) {
                                names.insert(
                                    i,
                                    value.data.names
                                        .removeAt(value.data.index));
                              } else {
                                names.insert(
                                    i - 1,
                                    value.data.names
                                        .removeAt(value.data.index));
                              }
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              bool isBefore = i > value.data.index &&
                                  value.data.names == names;
                              if (isBefore) {
                                names.insert(
                                    i,
                                    value.data.names
                                        .removeAt(value.data.index));
                              } else {
                                names.insert(
                                    i + 1,
                                    value.data.names
                                        .removeAt(value.data.index));
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
              ),
            ),
            gap(12),
            Expanded(
              child: Card(
                child: SortableDropFallback<_IndexData>(
                  onAccept: (value) {
                    setState(() {
                      names2.add(value.data.names.removeAt(value.data.index));
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < names2.length; i++)
                        Sortable<_IndexData>(
                          key: ValueKey(i),
                          data: _IndexData(i, names2),
                          onAcceptTop: (value) {
                            setState(() {
                              bool isBefore = i < value.data.index ||
                                  value.data.names != names2;
                              if (isBefore) {
                                names2.insert(
                                    i,
                                    value.data.names
                                        .removeAt(value.data.index));
                              } else {
                                names2.insert(
                                    i - 1,
                                    value.data.names
                                        .removeAt(value.data.index));
                              }
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              bool isBefore = i > value.data.index &&
                                  value.data.names == names2;
                              if (isBefore) {
                                names2.insert(
                                    i,
                                    value.data.names
                                        .removeAt(value.data.index));
                              } else {
                                names2.insert(
                                    i + 1,
                                    value.data.names
                                        .removeAt(value.data.index));
                              }
                            });
                          },
                          child: OutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(names2[i])),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
