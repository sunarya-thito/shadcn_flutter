import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample3 extends StatefulWidget {
  const DataExample3({super.key});

  @override
  State<DataExample3> createState() => DataExample3State();
}

class DataExample3State extends State<DataExample3> {
  int rootRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    int? childCounterData = Data.maybeFindMessenger(context);
    rootRebuildCount++;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Rebuild: $rootRebuildCount - Root Data: $childCounterData'),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                setState(() {});
              },
              density: ButtonDensity.icon,
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
        const Gap(24),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataMessenger<int>(
              child: InnerChildWidget(
                child: MostInnerChildWidget(
                  child: LeafWidget(),
                ),
              ),
            ),
            Gap(24),
            InnerChildWidget(
              child: MostInnerChildWidget(
                child: LeafWidget(),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class InnerChildWidget extends StatefulWidget {
  final Widget child;

  const InnerChildWidget({super.key, required this.child});

  @override
  State<InnerChildWidget> createState() => _InnerChildWidgetState();
}

class _InnerChildWidgetState extends State<InnerChildWidget> {
  int innerRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    int? childCounterData = Data.maybeFindMessenger(context);
    innerRebuildCount++;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Rebuild: $innerRebuildCount - Inner Data: $childCounterData'),
              const Gap(24),
              PrimaryButton(
                onPressed: () {
                  setState(() {});
                },
                density: ButtonDensity.icon,
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
          const Gap(24),
          widget.child
        ],
      ),
    );
  }
}

class MostInnerChildWidget extends StatefulWidget {
  final Widget child;

  const MostInnerChildWidget({super.key, required this.child});

  @override
  State<MostInnerChildWidget> createState() => _MostInnerChildState();
}

class _MostInnerChildState extends State<MostInnerChildWidget> {
  int mostInnerRebuildCount = 0;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    mostInnerRebuildCount++;
    return ForwardableData(
      data: counter,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Rebuild: $mostInnerRebuildCount - Most Inner Data: $counter'),
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
            widget.child
          ],
        ),
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
  int leafRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    int parentCounter = Data.of(context);
    leafRebuildCount++;
    return Card(
      child: Text('Rebuild: $leafRebuildCount - Leaf Data: $parentCounter'),
    );
  }
}
