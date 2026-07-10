import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('Card', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: Text('Card Content'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('renders with custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            padding: EdgeInsets.all(32.0),
            child: Text('Padded Content'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Padded Content'), findsOneWidget);
      expect(find.byType(OutlinedContainer), findsOneWidget);
    });

    testWidgets('renders filled card', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            filled: true,
            child: Text('Filled Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Filled Card'), findsOneWidget);
    });

    testWidgets('renders with custom fill color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            filled: true,
            fillColor: material.Colors.blue,
            child: Text('Colored Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Colored Card'), findsOneWidget);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            borderRadius: BorderRadius.circular(16.0),
            child: Text('Rounded Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Rounded Card'), findsOneWidget);
    });

    testWidgets('renders with custom border color and width', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            borderColor: Colors.red,
            borderWidth: 2.0,
            child: Text('Bordered Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Bordered Card'), findsOneWidget);
    });

    testWidgets('renders with box shadow', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              )
            ],
            child: Text('Shadowed Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Shadowed Card'), findsOneWidget);
    });

    testWidgets('renders with surface effects', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            surfaceOpacity: 0.8,
            surfaceBlur: 10.0,
            child: Text('Surface Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Surface Card'), findsOneWidget);
    });

    testWidgets('renders with custom clip behavior', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Text('Clipped Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Clipped Card'), findsOneWidget);
    });

    testWidgets('renders with custom duration', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            duration: Duration(milliseconds: 500),
            child: Text('Animated Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Animated Card'), findsOneWidget);
    });

    testWidgets('handles complex child widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: Column(
              children: [
                Text('Title'),
                SizedBox(height: 8),
                Text('Description'),
                Icon(Icons.star),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byType(Column),
          findsWidgets); // May find multiple due to SimpleApp
    });

    testWidgets('applies default text style', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: Text('Styled Text'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(DefaultTextStyle),
          findsWidgets); // May find multiple due to SimpleApp
      expect(find.text('Styled Text'), findsOneWidget);
    });

    testWidgets('handles empty child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders with all properties combined', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            padding: EdgeInsets.all(24.0),
            filled: true,
            fillColor: Colors.green,
            borderRadius: BorderRadius.circular(12.0),
            borderColor: Colors.blue,
            borderWidth: 3.0,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              )
            ],
            surfaceOpacity: 0.9,
            surfaceBlur: 8.0,
            clipBehavior: Clip.antiAlias,
            duration: Duration(milliseconds: 300),
            child: Text('Complex Card'),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Complex Card'), findsOneWidget);
      expect(find.byType(OutlinedContainer), findsOneWidget);
    });

    testWidgets('maintains widget hierarchy', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Nested Content'),
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Padding),
          findsWidgets); // May find multiple due to SimpleApp
      expect(find.text('Nested Content'), findsOneWidget);
    });

    testWidgets('handles state changes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            child: Text('Initial'),
          ),
        ),
      );

      expect(find.text('Initial'), findsOneWidget);

      await tester.pumpWidget(
        SimpleApp(
          child: Card(
            filled: true,
            child: Text('Updated'),
          ),
        ),
      );

      expect(find.text('Updated'), findsOneWidget);
      expect(find.text('Initial'), findsNothing);
    });
  });
}
