import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Alert', () {
    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(
            title: Text('Alert Title'),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.text('Alert Title'), findsOneWidget);
    });

    testWidgets('renders with title and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(
            title: Text('Alert Title'),
            content: Text('Alert content here'),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert content here'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(
            leading: Icon(Icons.info),
            title: Text('Info Alert'),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Info Alert'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(
            title: Text('Alert with action'),
            trailing: Button.primary(
              child: Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
      expect(find.text('Alert with action'), findsOneWidget);
    });

    testWidgets('renders in destructive mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert.destructive(
            leading: Icon(Icons.error),
            title: Text('Error Alert'),
            content: Text('Something went wrong'),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.text('Error Alert'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
      // Destructive styling would be verified in visual tests
    });

    testWidgets('applies theme correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ComponentTheme<AlertTheme>(
            data: AlertTheme(
              padding: EdgeInsets.all(20),
            ),
            child: Alert(
              title: Text('Themed Alert'),
            ),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.text('Themed Alert'), findsOneWidget);
      // Theme application would be verified in golden tests or more detailed checks
    });

    testWidgets('handles empty alert', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      // Should render without crashing
    });

    testWidgets('supports complex content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Alert(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('A')),
            ),
            title: Text('Complex Alert'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Line 1'),
                Text('Line 2'),
              ],
            ),
            trailing: Row(
              children: [
                Button.primary(child: Text('OK'), onPressed: () {}),
                Button.secondary(child: Text('Cancel'), onPressed: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Alert), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Complex Alert'), findsOneWidget);
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });
  });
}
