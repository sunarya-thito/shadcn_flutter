import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample14 extends StatefulWidget {
  const DataExample14({super.key});
  @override
  State<DataExample14> createState() => _DataExample14State();
}

class _DataExample14State extends State<DataExample14> {
  ValueNotifier<int> firstCounter = ValueNotifier(0);
  ValueNotifier<int> secondCounter = ValueNotifier(0);

  int buildCount = 0;
  @override
  Widget build(BuildContext context) {
    buildCount++;
    return MultiModel(
      data: [
        // Model is type-strict, so you must specify the type of the model
        ModelListenable<int>(#firstCounter, firstCounter),
        ModelListenable<int>(#secondCounter, secondCounter),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const InnerWidget(),
          const Gap(8),
          PrimaryButton(
            onPressed: () {
              firstCounter.value++;
            },
            child: const Text('Increment First Counter'),
          ),
          const Gap(4),
          PrimaryButton(
            onPressed: () {
              secondCounter.value++;
            },
            child: const Text('Increment Second Counter'),
          ),
          const Gap(8),
          Text('Build count: $buildCount').muted(),
        ],
      ),
    );
  }
}

class InnerWidget extends StatefulWidget {
  const InnerWidget({super.key});

  @override
  State<InnerWidget> createState() => _InnerWidgetState();
}

class _InnerWidgetState extends State<InnerWidget> {
  int rebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    // if you're using var, you must specify the type of the model
    var firstCounter = Model.of<int>(context, #firstCounter);
    rebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('First Counter: $firstCounter (Rebuild Count: $rebuildCount)'),
          const Gap(8),
          const LeafWidget(),
        ],
      ),
    );
  }
}

class LeafWidget extends StatefulWidget {
  const LeafWidget({super.key});

  @override
  State<LeafWidget> createState() => _LeafWidgetState();
}

class _LeafWidgetState extends State<LeafWidget> {
  int rebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    // typed-variable doesn't need to specify the type of the model
    int secondCounter = Model.of(context, #secondCounter);
    rebuildCount++;
    return Card(
      child:
          Text('Second Counter: $secondCounter (Rebuild Count: $rebuildCount)'),
    );
  }
}
