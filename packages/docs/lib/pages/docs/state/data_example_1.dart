import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample1 extends StatefulWidget {
  const DataExample1({super.key});

  @override
  State<DataExample1> createState() => DataExample1State();
}

class DataExample1State extends State<DataExample1> {
  int counter = 0;
  int rebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    rebuildCount++;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Value: $counter - Rebuild Count: $rebuildCount'),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            )
          ],
        ),
        const Gap(24),

        // From here, InnerWidget and MostInnerWidget will be able to access the
        // "counter" variable without causing unnecessary rebuilds.
        Data.inherit(
          data: counter,
          child: const InnerWidget(
            child: MostInnerWidget(),
          ),
        )
      ],
    );
  }
}

class InnerWidget extends StatefulWidget {
  final Widget child;

  const InnerWidget({super.key, required this.child});

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
          widget.child
        ],
      ),
    );
  }
}

class MostInnerWidget extends StatefulWidget {
  const MostInnerWidget({super.key});

  @override
  State<MostInnerWidget> createState() => _MostInnerWidgetState();
}

class _MostInnerWidgetState extends State<MostInnerWidget> {
  int mostInnerRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    int parentCounter = Data.of(context);
    mostInnerRebuildCount++;
    return Card(
      child: Text(
          'MostInnerWidget Data: $parentCounter - Rebuild Count: $mostInnerRebuildCount'),
    );
  }
}
