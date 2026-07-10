import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample15 extends StatefulWidget {
  const DataExample15({super.key});
  @override
  State<DataExample15> createState() => _DataExample15State();
}

class _DataExample15State extends State<DataExample15> {
  int firstCounter = 0;
  ValueNotifier<int> secondCounter = ValueNotifier(0);

  int buildCount = 0;
  @override
  Widget build(BuildContext context) {
    buildCount++;
    return MultiModel(
      data: [
        // Model is type-strict, so you must specify the type of the model
        Model<int>(#firstCounter, firstCounter),
        ModelNotifier<int>(#secondCounter, secondCounter),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const InnerWidget(),
          const Gap(8),
          PrimaryButton(
            onPressed: () {
              setState(() {
                firstCounter++;
              });
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
    rebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModelBuilder<int>(
            #firstCounter,
            builder: (context, model, child) {
              return Text(
                  'First Counter: ${model.value} (Rebuild Count: $rebuildCount)');
            },
          ),
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
    rebuildCount++;
    return Card(
      child: ModelBuilder<int>(
        #secondCounter,
        builder: (context, model, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Second Counter: ${model.value} (Rebuild Count: $rebuildCount)'),
              const Gap(24),
              PrimaryButton(
                onPressed: () {
                  model.value = model.value + 1;
                  // or model.data++ works too
                },
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }
}
