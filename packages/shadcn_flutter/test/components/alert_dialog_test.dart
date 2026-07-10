import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('AlertDialog', () {
    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            title: Text('Alert Title'),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Alert Title'), findsOneWidget);
    });

    testWidgets('renders with title and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            title: Text('Alert Title'),
            content: Text('Alert content here'),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert content here'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            leading: Icon(Icons.info),
            title: Text('Info Alert'),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Info Alert'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            title: Text('Alert with action'),
            trailing: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Alert with action'), findsOneWidget);
    });

    testWidgets('renders with actions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            title: Text('Confirm Action'),
            content: Text('Are you sure?'),
            actions: [
              Button.primary(child: Text('OK'), onPressed: () {}),
              Button.secondary(child: Text('Cancel'), onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('handles empty dialog', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      // Should render without crashing
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            padding: EdgeInsets.all(40),
            title: Text('Padded Dialog'),
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Padded Dialog'), findsOneWidget);
    });

    testWidgets('renders complex layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('!')),
            ),
            title: Text('Warning'),
            content: Text('This is a warning message with more details.'),
            trailing: Icon(Icons.warning),
            actions: [
              Button.outline(child: Text('Ignore'), onPressed: () {}),
              Button.primary(child: Text('Acknowledge'), onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('This is a warning message with more details.'),
          findsOneWidget);
      expect(find.byType(Button), findsNWidgets(2));
    });

    testWidgets('uses ModalBackdrop and ModalContainer', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AlertDialog(
            title: Text('Modal Test'),
          ),
        ),
      );

      expect(find.byType(ModalBackdrop), findsOneWidget);
      expect(find.byType(ModalContainer), findsOneWidget);
    });
  });
}
