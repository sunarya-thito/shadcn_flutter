import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample4 extends StatefulWidget {
  const SortableExample4({super.key});

  @override
  State<SortableExample4> createState() => _SortableExample4State();
}

class _SortableExample4State extends State<SortableExample4> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
    const SortableData('David'),
    const SortableData('Richard'),
    const SortableData('Joseph'),
    const SortableData('Thomas'),
    const SortableData('Charles'),
    const SortableData('Daniel'),
    const SortableData('Matthew'),
    const SortableData('Anthony'),
    const SortableData('Donald'),
    const SortableData('Mark'),
    const SortableData('Paul'),
    const SortableData('Steven'),
    const SortableData('Andrew'),
    const SortableData('Kenneth'),
  ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SortableLayer(
        // Constrain drag overlays to the layer bounds so they scroll within the list.
        lock: true,
        child: SortableDropFallback<int>(
          // If dropped outside a specific edge target, append to the end.
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          // Wrap the scrollable so auto-scrolling can occur while dragging near edges.
          child: ScrollableSortableLayer(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, i) {
                return Sortable<String>(
                  // Stable key helps maintain drag state with virtualization.
                  key: ValueKey(i),
                  data: names[i],
                  onAcceptTop: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptBottom: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
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
