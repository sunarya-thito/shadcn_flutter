import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Chip', () {
    testWidgets('renders with child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Chip(
            child: Text('Chip Label'),
          ),
        ),
      );

      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('Chip Label'), findsOneWidget);
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Chip(
            leading: Icon(Icons.star),
            child: Text('Chip Label'),
            trailing: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Chip Label'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('handles onPressed', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Chip(
            onPressed: () => pressed = true,
            child: Text('Clickable Chip'),
          ),
        ),
      );

      await tester.tap(find.byType(Chip));
      expect(pressed, isTrue);
    });

    testWidgets('applies custom style', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Chip(
            style: ButtonVariance.destructive,
            child: Text('Destructive Chip'),
          ),
        ),
      );

      expect(find.byType(Chip), findsOneWidget);
      // Visual style verification is limited in widget tests without golden files,
      // but we can verify no crash and widget presence.
    });
  });

  group('ChipButton', () {
    testWidgets('renders with child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ChipButton(
            child: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byType(ChipButton), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('handles onPressed', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: ChipButton(
            onPressed: () => pressed = true,
            child: Icon(Icons.close),
          ),
        ),
      );

      await tester.tap(find.byType(ChipButton));
      expect(pressed, isTrue);
    });
  });
}
