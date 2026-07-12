import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget _appWithPlatform(TargetPlatform platform, Widget child) {
  return ShadcnApp(
    theme: ThemeData(platform: platform),
    home: Scaffold(child: child),
  );
}

void main() {
  group('showOverlay / PopoverConfiguration', () {
    testWidgets('shows a real popover on desktop platforms', (tester) async {
      await tester.pumpWidget(
        _appWithPlatform(
          TargetPlatform.macOS,
          Builder(
            builder: (context) => Button.primary(
              onPressed: () {
                showOverlay(
                  context,
                  PopoverConfiguration(
                    alignment: Alignment.bottomCenter,
                    builder: (context) => const Text('Popover Content'),
                  ),
                );
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      expect(find.text('Popover Content'), findsNothing);

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Popover Content'), findsOneWidget);
      expect(find.byType(DrawerWrapper), findsNothing);
    });

    testWidgets('adapts to a bottom drawer on mobile platforms',
        (tester) async {
      await tester.pumpWidget(
        _appWithPlatform(
          TargetPlatform.android,
          Builder(
            builder: (context) => Button.primary(
              onPressed: () {
                showOverlay(
                  context,
                  PopoverConfiguration(
                    alignment: Alignment.bottomCenter,
                    builder: (context) => const Text('Popover Content'),
                  ),
                );
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Popover Content'), findsOneWidget);
      expect(find.byType(DrawerWrapper), findsOneWidget);
    });

    testWidgets('adaptive: false keeps a real popover on mobile platforms',
        (tester) async {
      await tester.pumpWidget(
        _appWithPlatform(
          TargetPlatform.android,
          Builder(
            builder: (context) => Button.primary(
              onPressed: () {
                showOverlay(
                  context,
                  PopoverConfiguration(
                    alignment: Alignment.bottomCenter,
                    builder: (context) => const Text('Popover Content'),
                  ),
                  adaptive: false,
                );
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Popover Content'), findsOneWidget);
      expect(find.byType(DrawerWrapper), findsNothing);
    });
  });

  group('showOverlay / DialogConfiguration', () {
    testWidgets('resolves .future with the popped result', (tester) async {
      String? result;
      await tester.pumpWidget(
        _appWithPlatform(
          TargetPlatform.macOS,
          Builder(
            builder: (context) => Button.primary(
              onPressed: () {
                showOverlay<String>(
                  context,
                  DialogConfiguration(
                    builder: (context) => Button.primary(
                      onPressed: () => Navigator.of(context).pop('confirmed'),
                      child: const Text('Confirm'),
                    ),
                  ),
                ).future.then((value) => result = value);
              },
              child: const Text('Open Dialog'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('Confirm'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(result, 'confirmed');
    });
  });
}
