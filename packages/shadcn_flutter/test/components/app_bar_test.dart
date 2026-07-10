import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('AppBar', () {
    testWidgets('renders and is visible', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                title: const Text('Test Title'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                leading: const [Text('Menu')],
                title: const Text('Test Title'),
                trailing: const [Text('Search')],
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Menu'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with header and subtitle', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                header: const Text('Header'),
                title: const Text('Title'),
                subtitle: const Text('Subtitle'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('renders with custom child', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                child: const Text('Custom Child'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Custom Child'), findsOneWidget);
    });

    testWidgets('respects height constraint', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                height: 100,
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.height, 100);
    });

    testWidgets('respects alignment', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                alignment: Alignment.centerLeft,
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.alignment, Alignment.centerLeft);
    });

    testWidgets('respects trailingExpanded', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                trailingExpanded: true,
                title: const Text('Test'),
                trailing: const [Text('Trailing')],
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.trailingExpanded, true);
    });

    testWidgets('respects backgroundColor', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                backgroundColor: const Color(0xFFFF0000),
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, const Color(0xFFFF0000));
    });

    testWidgets('respects padding', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                padding: const EdgeInsets.all(20),
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.padding, const EdgeInsets.all(20));
    });

    testWidgets('respects useSafeArea', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                useSafeArea: false,
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.useSafeArea, false);
    });

    testWidgets('respects leadingGap', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                leadingGap: 10,
                leading: const [Text('L1'), Text('L2')],
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.leadingGap, 10);
    });

    testWidgets('respects trailingGap', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                trailingGap: 15,
                title: const Text('Test'),
                trailing: const [Text('T1'), Text('T2')],
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.trailingGap, 15);
    });

    testWidgets('respects surfaceBlur', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                surfaceBlur: 5.0,
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.surfaceBlur, 5.0);
    });

    testWidgets('respects surfaceOpacity', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                surfaceOpacity: 0.5,
                title: const Text('Test'),
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.surfaceOpacity, 0.5);
    });

    testWidgets('handles empty lists gracefully', (tester) async {
      await tester.pumpWidget(
        ShadcnApp(
          home: Scaffold(
            headers: [
              AppBar(
                leading: const [],
                trailing: const [],
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('asserts when both child and title are provided',
        (tester) async {
      expect(
        () => AppBar(
          title: const Text('Title'),
          child: const Text('Child'),
        ),
        throwsAssertionError,
      );
    });
  });
}
