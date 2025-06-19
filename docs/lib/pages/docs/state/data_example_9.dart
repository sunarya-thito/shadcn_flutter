import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample9 extends StatefulWidget {
  const DataExample9({super.key});

  @override
  State<DataExample9> createState() => DataExample9State();
}

class DataExample9State extends State<DataExample9> {
  final ValueNotifier<int> counter = ValueNotifier(0);
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
            ValueListenableBuilder(
              valueListenable: counter,
              builder: (context, value, child) {
                return Text(
                    'Current Value: $value - Rebuild Count: $rebuildCount');
              },
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                counter.value++;
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            )
          ],
        ),
        const Gap(24),
        DataNotifier.inherit(
          notifier: counter,
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
    mostInnerRebuildCount++;
    return Card(
      child: DataBuilder<int>(
        builder: (context, data, _) {
          return Text(
              'MostInnerWidget Data: $data - Rebuild Count: $mostInnerRebuildCount');
        },
      ),
    );
  }
}
