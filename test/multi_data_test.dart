import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_test/shadcn_flutter_test.dart';

import 'data_test.dart';

main() {
  testWidgets('MultiData test', (tester) async {
    await tester.pumpWidget(
      const MultiDataRootWidget(
        child: ChildWidget(),
      ),
    );
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Increment'));
    await tester.pump();
    expect(shadcnFind.text('Counter: 1'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Toggle'));
    await tester.pump();
    expect(shadcnFind.text('Counter: 1'), findsOneWidget);
    expect(shadcnFind.text('Flag: true'), findsOneWidget);
  });

  testWidgets('MultiData.boundary test', (tester) async {
    await tester.pumpWidget(
      const MultiDataRootWidget(
        child: MultiDataBoundaryChildWidget(
          boundaryCounter: true,
          boundaryFlag: true,
          child: ChildWidget(),
        ),
      ),
    );
    expect(shadcnFind.text('Counter: null'), findsOneWidget);
    expect(shadcnFind.text('Flag: null'), findsOneWidget);

    await tester.tap(shadcnFind.text('Increment'));
    await tester.pump();
    expect(shadcnFind.text('Counter: null'), findsOneWidget);
    expect(shadcnFind.text('Flag: null'), findsOneWidget);

    await tester.tap(shadcnFind.text('Toggle'));
    await tester.pump();
    expect(shadcnFind.text('Counter: null'), findsOneWidget);
    expect(shadcnFind.text('Flag: null'), findsOneWidget);
  });
}

class MultiDataRootWidget extends StatefulWidget {
  final Widget child;

  const MultiDataRootWidget({super.key, required this.child});

  @override
  State<MultiDataRootWidget> createState() => MultiDataRootWidgetState();
}

class MultiDataRootWidgetState extends State<MultiDataRootWidget> {
  int _counter = 0;
  bool _flag = false;

  void increment() {
    setState(() {
      _counter++;
    });
  }

  void toggle() {
    setState(() {
      _flag = !_flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: MultiData(
          data: [
            Data(_counter),
            Data(_flag),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
              PrimaryButton(
                onPressed: increment,
                child: const Text('Increment'),
              ),
              PrimaryButton(
                onPressed: toggle,
                child: const Text('Toggle'),
              ),
            ],
          )),
    );
  }
}

class MultiDataBoundaryChildWidget extends StatelessWidget {
  final bool boundaryCounter;
  final bool boundaryFlag;
  final Widget child;

  const MultiDataBoundaryChildWidget({
    super.key,
    required this.boundaryCounter,
    required this.boundaryFlag,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiData(
      data: [
        if (boundaryCounter) const Data<int>.boundary(),
        if (boundaryFlag) const Data<bool>.boundary(),
      ],
      child: child,
    );
  }
}
