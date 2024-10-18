import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_test/shadcn_flutter_test.dart';

import 'data_test.dart';

main() {
  testWidgets('MultiModel test', (tester) async {
    await tester.pumpWidget(
      const RootModelWidget(
        child: ChildModelWidget(),
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

  testWidgets('Model test', (tester) async {
    await tester.pumpWidget(
      const RootModelSeparatedWidget(
        child: ChildModelWidget(),
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

  testWidgets('MultiModel ModelNotifier test', (tester) async {
    await tester.pumpWidget(
      const RootModelNotifierWidget(
        child: ChildModelWidget(),
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

  testWidgets('ModelNotifier test', (tester) async {
    await tester.pumpWidget(
      const RootModelNotifierSeparatedWidget(
        child: ChildModelWidget(),
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

  testWidgets('ModelReadOnly test', (tester) async {
    await tester.pumpWidget(
      const RootModelReadOnlyWidget(
        child: ChildModelChangeWidget(),
      ),
    );
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Increment from Child'));
    expect(tester.takeException(), isAssertionError);

    await tester.pump();
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Toggle from Child'));
    expect(tester.takeException(), isAssertionError);
    await tester.pump();
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);
  });

  testWidgets('ModelReadOnlySeparated test', (tester) async {
    await tester.pumpWidget(
      const RootModelReadOnlySeparatedWidget(
        child: ChildModelChangeWidget(),
      ),
    );
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Increment from Child'));
    expect(tester.takeException(), isAssertionError);

    await tester.pump();
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Toggle from Child'));
    expect(tester.takeException(), isAssertionError);

    await tester.pump();
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);
  });

  testWidgets('ModelBuilder test', (tester) async {
    await tester.pumpWidget(
      const RootModelWidget(
        child: ChildModelBuilderWidget(),
      ),
    );
    expect(shadcnFind.text('Counter: 0'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Increment from Builder'));
    await tester.pump();
    expect(shadcnFind.text('Counter: 1'), findsOneWidget);
    expect(shadcnFind.text('Flag: false'), findsOneWidget);

    await tester.tap(shadcnFind.text('Toggle from Builder'));
    await tester.pump();
    expect(shadcnFind.text('Counter: 1'), findsOneWidget);
    expect(shadcnFind.text('Flag: true'), findsOneWidget);
  });

  testWidgets('ModelBoundary test', (tester) async {
    Object? exception;
    FlutterError.onError = (details) {
      exception = details.exception;
    };
    await tester.pumpWidget(
      const RootModelWidget(
        child: ChildModelBoundaryWidget(
          boundaryCounter: true,
          boundaryFlag: true,
          child: ChildModelWidget(),
        ),
      ),
      duration: Duration.zero,
    );
    expect(exception, isAssertionError);
  });
}

class RootModelWidget extends StatefulWidget {
  final Widget child;
  const RootModelWidget({super.key, required this.child});

  @override
  State<RootModelWidget> createState() => _RootModelWidgetState();
}

class _RootModelWidgetState extends State<RootModelWidget> {
  int counter = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: MultiModel(
        data: [
          Model<int>(
            #counter,
            counter,
            onChanged: (value) {
              setState(() {
                counter = value;
              });
            },
          ),
          Model<bool>(
            #flag,
            flag,
            onChanged: (value) {
              setState(() {
                flag = value;
              });
            },
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            PrimaryButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text('Increment'),
            ),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  flag = !flag;
                });
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}

class RootModelSeparatedWidget extends StatefulWidget {
  final Widget child;
  const RootModelSeparatedWidget({super.key, required this.child});

  @override
  State<RootModelSeparatedWidget> createState() =>
      _RootModelSeparatedWidgetState();
}

class _RootModelSeparatedWidgetState extends State<RootModelSeparatedWidget> {
  int counter = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Model<int>.inherit(
            #counter,
            counter,
            onChanged: (value) {
              setState(() {
                counter = value;
              });
            },
            child: Model<bool>.inherit(
              #flag,
              flag,
              onChanged: (value) {
                setState(() {
                  flag = value;
                });
              },
              child: widget.child,
            ),
          ),
          PrimaryButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: const Text('Increment'),
          ),
          PrimaryButton(
            onPressed: () {
              setState(() {
                flag = !flag;
              });
            },
            child: const Text('Toggle'),
          ),
        ],
      ),
    );
  }
}

class RootModelNotifierWidget extends StatefulWidget {
  final Widget child;
  const RootModelNotifierWidget({super.key, required this.child});

  @override
  State<RootModelNotifierWidget> createState() =>
      _RootModelNotifierWidgetState();
}

class _RootModelNotifierWidgetState extends State<RootModelNotifierWidget> {
  final counter = ValueNotifier<int>(0);
  final flag = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: MultiModel(
        data: [
          ModelNotifier<int>(#counter, counter),
          ModelNotifier<bool>(#flag, flag),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            PrimaryButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text('Increment'),
            ),
            PrimaryButton(
              onPressed: () {
                flag.value = !flag.value;
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}

class RootModelNotifierSeparatedWidget extends StatefulWidget {
  final Widget child;
  const RootModelNotifierSeparatedWidget({super.key, required this.child});

  @override
  State<RootModelNotifierSeparatedWidget> createState() =>
      _RootModelNotifierSeparatedWidgetState();
}

class _RootModelNotifierSeparatedWidgetState
    extends State<RootModelNotifierSeparatedWidget> {
  final counter = ValueNotifier<int>(0);
  final flag = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModelNotifier<int>.inherit(
            #counter,
            counter,
            child: ModelNotifier<bool>.inherit(
              #flag,
              flag,
              child: widget.child,
            ),
          ),
          PrimaryButton(
            onPressed: () {
              counter.value++;
            },
            child: const Text('Increment'),
          ),
          PrimaryButton(
            onPressed: () {
              flag.value = !flag.value;
            },
            child: const Text('Toggle'),
          ),
        ],
      ),
    );
  }
}

class RootModelReadOnlyWidget extends StatefulWidget {
  final Widget child;
  const RootModelReadOnlyWidget({super.key, required this.child});

  @override
  State<RootModelReadOnlyWidget> createState() =>
      _RootModelReadOnlyWidgetState();
}

class _RootModelReadOnlyWidgetState extends State<RootModelReadOnlyWidget> {
  int counter = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: MultiModel(
        data: [
          Model<int>(
            #counter,
            counter,
          ),
          Model<bool>(
            #flag,
            flag,
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.child,
            PrimaryButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text('Increment'),
            ),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  flag = !flag;
                });
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}

class RootModelReadOnlySeparatedWidget extends StatefulWidget {
  final Widget child;
  const RootModelReadOnlySeparatedWidget({super.key, required this.child});

  @override
  State<RootModelReadOnlySeparatedWidget> createState() =>
      _RootModelReadOnlySeparatedWidgetState();
}

class _RootModelReadOnlySeparatedWidgetState
    extends State<RootModelReadOnlySeparatedWidget> {
  int counter = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return ShadcnTester(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Model<int>.inherit(
            #counter,
            counter,
            child: Model<bool>.inherit(
              #flag,
              flag,
              child: widget.child,
            ),
          ),
          PrimaryButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: const Text('Increment'),
          ),
          PrimaryButton(
            onPressed: () {
              setState(() {
                flag = !flag;
              });
            },
            child: const Text('Toggle'),
          ),
        ],
      ),
    );
  }
}

class ChildModelWidget extends StatelessWidget {
  const ChildModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var counter = Model.of<int>(context, #counter);
    var flag = Model.of<bool>(context, #flag);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Counter: $counter'),
        Text('Flag: $flag'),
      ],
    );
  }
}

class ChildModelChangeWidget extends StatelessWidget {
  const ChildModelChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var counterProp = Model.ofProperty<int>(context, #counter);
    var flagProp = Model.ofProperty<bool>(context, #flag);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Counter: ${counterProp.value}'),
        Text('Flag: ${flagProp.value}'),
        PrimaryButton(
          onPressed: () {
            counterProp.value++;
          },
          child: const Text('Increment from Child'),
        ),
        PrimaryButton(
          onPressed: () {
            flagProp.value = !flagProp.value;
          },
          child: const Text('Toggle from Child'),
        ),
      ],
    );
  }
}

class ChildModelBuilderWidget extends StatelessWidget {
  const ChildModelBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelBuilder<int>(
      #counter,
      builder: (context, counter, _) {
        return ModelBuilder<bool>(
          #flag,
          builder: (context, flag, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Counter: ${counter.value}'),
                Text('Flag: ${flag.value}'),
                PrimaryButton(
                  onPressed: () {
                    counter.value++;
                  },
                  child: const Text('Increment from Builder'),
                ),
                PrimaryButton(
                  onPressed: () {
                    flag.value = !flag.value;
                  },
                  child: const Text('Toggle from Builder'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ChildModelBoundaryWidget extends StatelessWidget {
  final bool boundaryCounter;
  final bool boundaryFlag;
  final Widget child;

  const ChildModelBoundaryWidget({
    super.key,
    required this.boundaryCounter,
    required this.boundaryFlag,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiModel(
      data: [
        if (boundaryCounter) const ModelBoundary<int>(#counter),
        if (boundaryFlag) const ModelBoundary<bool>(#flag),
      ],
      child: child,
    );
  }
}
