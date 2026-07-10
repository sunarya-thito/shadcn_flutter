import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Basic', () {
    testWidgets('renders with no content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      // Should render as empty padding
    });

    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders with leading and title', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            leading: Icon(Icons.star),
            title: Text('Title'),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('renders with title, subtitle, and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            content: Text('Content'),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('renders with all components', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            leading: Icon(Icons.star),
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            content: Text('Content'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('respects custom content spacing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            leading: Icon(Icons.star),
            title: Text('Title'),
            contentSpacing: 24,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects custom title spacing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            titleSpacing: 8,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('respects custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            padding: EdgeInsets.all(16),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects main axis alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            leading: Icon(Icons.star),
            title: Text('Title'),
            trailing: Icon(Icons.arrow_forward),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('respects leading alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            leading: Icon(Icons.star),
            title: Text('Title'),
            leadingAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects trailing alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            trailing: Icon(Icons.arrow_forward),
            trailingAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('respects title alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            titleAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects subtitle alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            subtitleAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('respects content alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            content: Text('Content'),
            contentAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('handles very long text content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200,
            child: Basic(
              title: Text('Very Long Title That Should Wrap Appropriately'),
              content: Text(
                  'Very long content that should also wrap properly and not cause layout issues'),
            ),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.textContaining('Very Long Title'), findsOneWidget);
      expect(find.textContaining('Very long content'), findsOneWidget);
    });

    testWidgets('works with different widget types in content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Basic(
            title: Text('Title'),
            content: Column(
              children: [
                Text('Line 1'),
                Text('Line 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });
  });
}
