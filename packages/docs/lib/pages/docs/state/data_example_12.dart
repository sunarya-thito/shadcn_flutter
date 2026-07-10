import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample12 extends StatefulWidget {
  const DataExample12({super.key});
  @override
  State<DataExample12> createState() => _DataExample12State();
}

class _DataExample12State extends State<DataExample12> {
  int firstCounter = 0;
  int secondCounter = 0;

  int buildCount = 0;
  @override
  Widget build(BuildContext context) {
    buildCount++;
    return MultiModel(
      data: [
        // Not specifying the onChanged callback will make the model read-only
        // Read-only model will throw an error if you try to change the value
        Model<int>(
          #firstCounter,
          firstCounter,
          onChanged: (value) {
            setState(() {
              firstCounter = value;
            });
          },
        ),
        Model<int>(
          #secondCounter,
          secondCounter,
          onChanged: (value) {
            setState(() {
              secondCounter = value;
            });
          },
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const InnerWidget(),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'First Counter: $firstCounter (Rebuild Count: $rebuildCount)'),
              const Gap(24),
              PrimaryButton(
                onPressed: () {
                  Model.change(context, #firstCounter, firstCounter + 1);
                },
                child: const Icon(Icons.add),
              ),
            ],
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
    // directly get the ModelProperty instance
    // careful to not use [of] method when trying to get ModelProperty instance
    // as it will try to find Model<ModelProperty<T>> instance instead of Model<T>
    ModelProperty<int> secondCounter =
        Model.ofProperty(context, #secondCounter);
    rebuildCount++;
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              'Second Counter: ${secondCounter.value} (Rebuild Count: $rebuildCount)'),
          const Gap(24),
          PrimaryButton(
            onPressed: () {
              secondCounter.value = secondCounter.value + 1;
              // or secondCounter.data++ works too
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
