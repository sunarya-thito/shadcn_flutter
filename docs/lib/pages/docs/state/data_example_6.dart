import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample6 extends StatefulWidget {
  const DataExample6({super.key});

  @override
  State<DataExample6> createState() => DataExample6State();
}

class DataExample6State extends State<DataExample6> {
  int counter = 0;
  int rebuildCount = 0;
  bool toggle = false;
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
            Toggle(
              value: toggle,
              onChanged: (value) {
                setState(() {
                  toggle = value;
                });
              },
              child: const Text('Toggle'),
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const Gap(24),
        MultiData(
          data: [
            Data(counter),
            Data(toggle),
          ],
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
    final counter = Data.of<int>(context);
    innerRebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              'Data: $counter - InnerWidget Rebuild Count: $innerRebuildCount'),
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
    final toggle = Data.of<bool>(context);
    mostInnerRebuildCount++;
    return Card(
      child: Text(
          'Data: $toggle - MostInnerWidget Rebuild Count: $mostInnerRebuildCount'),
    );
  }
}
