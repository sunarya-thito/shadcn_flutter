import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample7 extends StatefulWidget {
  const DataExample7({super.key});

  @override
  State<DataExample7> createState() => DataExample7State();
}

class DataExample7State extends State<DataExample7> {
  int counter = 0;
  int rebuildCount = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    rebuildCount++;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Current Value: $counter - Rebuild Count: $rebuildCount'),
        const Gap(24),
        Data.inherit(
          data: this,
          child: const InnerWidget(),
        )
      ],
    );
  }
}

class InnerWidget extends StatefulWidget {
  const InnerWidget({super.key});

  @override
  State<InnerWidget> createState() => _InnerWidgetState();
}

class _InnerWidgetState extends State<InnerWidget> {
  int innerRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    innerRebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('InnerWidget Rebuild Count: $innerRebuildCount'),
          const Gap(12),
          PrimaryButton(
            onPressed: () {
              // Use "find" instead of "of" to avoid unnecessary rebuilds
              final data = Data.find<DataExample7State>(context);
              data.incrementCounter();
            },
            child: const Text('Increment Counter'),
          )
        ],
      ),
    );
  }
}
