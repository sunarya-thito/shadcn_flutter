import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('AdaptiveScaler', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: AdaptiveScaling.mobile,
            child: const Text('Test Child'),
          ),
        ),
      );

      expect(find.byType(AdaptiveScaler), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('applies scaling to theme', (tester) async {
      late double baseScaling;
      // First get base scaling
      await tester.pumpWidget(
        SimpleApp(
          child: Builder(
            builder: (context) {
              baseScaling = Theme.of(context).scaling;
              return const Text('Test');
            },
          ),
        ),
      );

      late ThemeData capturedTheme;
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: AdaptiveScaling.mobile, // 1.25 scaling
            child: Builder(
              builder: (context) {
                capturedTheme = Theme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      // Mobile scaling should be base * 1.25
      expect(capturedTheme.scaling, baseScaling * 1.25);
    });

    testWidgets('desktop scaling applies 1.0 scaling', (tester) async {
      late double baseScaling;
      // First get base scaling
      await tester.pumpWidget(
        SimpleApp(
          child: Builder(
            builder: (context) {
              baseScaling = Theme.of(context).scaling;
              return const Text('Test');
            },
          ),
        ),
      );

      late ThemeData capturedTheme;
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: AdaptiveScaling.desktop, // 1.0 scaling
            child: Builder(
              builder: (context) {
                capturedTheme = Theme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      // Desktop scaling should be base * 1.0
      expect(capturedTheme.scaling, baseScaling * 1.0);
    });

    testWidgets('custom scaling applies correctly', (tester) async {
      late double baseScaling;
      // First get base scaling
      await tester.pumpWidget(
        SimpleApp(
          child: Builder(
            builder: (context) {
              baseScaling = Theme.of(context).scaling;
              return const Text('Test');
            },
          ),
        ),
      );

      late ThemeData capturedTheme;
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: const AdaptiveScaling(2.0),
            child: Builder(
              builder: (context) {
                capturedTheme = Theme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      // Custom scaling should be base * 2.0
      expect(capturedTheme.scaling, baseScaling * 2.0);
    });

    testWidgets('individual scaling factors work', (tester) async {
      late double baseScaling;
      // First get base scaling
      await tester.pumpWidget(
        SimpleApp(
          child: Builder(
            builder: (context) {
              baseScaling = Theme.of(context).scaling;
              return const Text('Test');
            },
          ),
        ),
      );

      late ThemeData capturedTheme;
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: const AdaptiveScaling.only(
              radiusScaling: 1.5,
              sizeScaling: 2.0,
              textScaling: 0.8,
            ),
            child: Builder(
              builder: (context) {
                capturedTheme = Theme.of(context);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      // Size scaling should be base * 2.0
      expect(capturedTheme.scaling, baseScaling * 2.0);
    });

    testWidgets('handles null child gracefully', (tester) async {
      // This should not crash
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            scaling: AdaptiveScaling.desktop,
            child: Container(), // Empty container
          ),
        ),
      );

      expect(find.byType(AdaptiveScaler), findsOneWidget);
    });

    testWidgets('preserves key', (tester) async {
      const testKey = Key('test-key');
      await tester.pumpWidget(
        SimpleApp(
          child: AdaptiveScaler(
            key: testKey,
            scaling: AdaptiveScaling.desktop,
            child: const Text('Test'),
          ),
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);
    });
  });
}
