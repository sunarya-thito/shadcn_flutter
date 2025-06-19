import 'package:shadcn_flutter/shadcn_flutter.dart';

class DataExample5 extends StatefulWidget {
  const DataExample5({super.key});

  @override
  State<DataExample5> createState() => DataExample5State();
}

class DataExample5State extends State<DataExample5> {
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
        Data.inherit(
          data: counter,
          child: const InnerWidget(
            child: MostInnerWidget(
              child: MostInnerWidget(),
            ),
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
  final Widget? child;

  const MostInnerWidget({super.key, this.child});

  @override
  State<MostInnerWidget> createState() => _MostInnerWidgetState();
}

class _MostInnerWidgetState extends State<MostInnerWidget> {
  int mostInnerRebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    int? parentCounter = Data.maybeFind(context);
    mostInnerRebuildCount++;
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'MostInnerWidget Data: $parentCounter - Rebuild Count: $mostInnerRebuildCount'),
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
          if (widget.child != null) ...[
            const Gap(12),
            widget.child!,
          ],
        ],
      ),
    );
  }
}
