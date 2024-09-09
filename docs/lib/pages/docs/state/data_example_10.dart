import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample10 extends StatefulWidget {
  const DataExample10({super.key});

  @override
  State<DataExample10> createState() => DataExample10State();
}

class DataExample10State extends State<DataExample10> {
  int rebuildCount = 0;
  ValueNotifier<int> counter = ValueNotifier(0);
  ValueNotifier<bool> toggle = ValueNotifier(false);
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
            ValueListenableBuilder(
              valueListenable: toggle,
              builder: (context, value, child) {
                return Toggle(
                  value: value,
                  onChanged: (value) {
                    toggle.value = value;
                  },
                  child: const Text('Toggle'),
                );
              },
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                counter.value++;
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const Gap(24),
        MultiData(
          data: [
            DataNotifier(counter),
            DataNotifier(toggle),
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
    innerRebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataBuilder<int>(
            builder: (context, data, child) {
              return Text(
                  'Data: $data - InnerWidget Rebuild Count: $innerRebuildCount');
            },
          ),
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
      child: DataBuilder<bool>(
        builder: (context, data, child) {
          return Text(
              'Data: $data - MostInnerWidget Rebuild Count: $mostInnerRebuildCount');
        },
      ),
    );
  }
}
