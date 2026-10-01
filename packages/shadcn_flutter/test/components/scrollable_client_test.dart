import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class _Host extends StatefulWidget {
  const _Host({this.reverse = false});

  final bool reverse;

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  String label = 'first';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button.primary(
          onPressed: () => setState(() => label = 'second'),
          child: const Text('flip'),
        ),
        SizedBox(
          height: 200,
          width: 300,
          child: ScrollableClient(
            horizontalDetails: ScrollableDetails.horizontal(
              reverse: widget.reverse,
            ),
            builder: (context, offset, viewportSize, child) {
              return SizedBox(
                height: 400,
                width: 500,
                child: Align(alignment: Alignment.topLeft, child: Text(label)),
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  group('ScrollableClient', () {
    testWidgets('re-runs its builder when the parent rebuilds', (tester) async {
      // The viewport widget supplied no updateRenderObject, so the render
      // object kept the delegate it was created with and the builder closure
      // was frozen at its first call.
      await tester.pumpWidget(const ShadcnApp(home: Scaffold(child: _Host())));
      await tester.pumpAndSettle();
      expect(find.text('first'), findsOneWidget);

      await tester.tap(find.text('flip'));
      await tester.pumpAndSettle();
      expect(find.text('second'), findsOneWidget);
    });

    testWidgets('honours a reversed horizontal axis', (tester) async {
      await tester.pumpWidget(const ShadcnApp(home: Scaffold(child: _Host())));
      await tester.pumpAndSettle();
      final forward = tester.getTopLeft(find.text('first')).dx;

      await tester.pumpWidget(
        const ShadcnApp(home: Scaffold(child: _Host(reverse: true))),
      );
      await tester.pumpAndSettle();
      final reversed = tester.getTopLeft(find.text('first')).dx;

      // Content is 500 wide in a 300 wide viewport, so at offset zero a
      // reversed axis starts scrolled to the far end: 200px further left.
      expect(reversed, closeTo(forward - 200, 0.01));
    });

    testWidgets('survives opening and closing a sheet overlay', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        showOverlay(
                          context,
                          const SheetConfiguration(
                            position: OverlayPosition.bottom,
                          ),
                          builder: (context) => PrimaryButton(
                            onPressed: () => closeSheet(context),
                            child: const Text('close sheet'),
                          ),
                        );
                      },
                      child: const Text('open sheet'),
                    ),
                    SizedBox(
                      width: 300,
                      height: 200,
                      child: ScrollableClient(
                        diagonalDragBehavior: DiagonalDragBehavior.free,
                        builder: (context, offset, viewportSize, child) {
                          return const SizedBox(width: 500, height: 400);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('open sheet'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('close sheet'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(ScrollableClient), findsOneWidget);
    });
  });
}
