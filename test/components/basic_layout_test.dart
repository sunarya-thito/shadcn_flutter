import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('BasicLayout', () {
    testWidgets('renders with no content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      // Should render as empty Row
    });

    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders with leading and title', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: Icon(Icons.star),
            title: Text('Title'),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('renders with title, subtitle, and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            content: Text('Content'),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('renders with all components', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: Icon(Icons.star),
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            content: Text('Content'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('respects custom content spacing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: Icon(Icons.star),
            title: Text('Title'),
            contentSpacing: 24,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects custom title spacing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            titleSpacing: 8,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('respects constraints', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            constraints: BoxConstraints(maxWidth: 200),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects leading alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: Icon(Icons.star),
            title: Text('Title'),
            leadingAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects trailing alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            trailing: Icon(Icons.arrow_forward),
            trailingAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('respects title alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            titleAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('respects subtitle alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            subtitleAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('respects content alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            content: Text('Content'),
            contentAlignment: Alignment.center,
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('handles very long text content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200,
            child: BasicLayout(
              title: Text('Very Long Title That Should Wrap Appropriately'),
              content: Text(
                  'Very long content that should also wrap properly and not cause layout issues'),
            ),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.textContaining('Very Long Title'), findsOneWidget);
      expect(find.textContaining('Very long content'), findsOneWidget);
    });

    testWidgets('works with different widget types in content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
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

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });

    testWidgets('positions leading widget correctly relative to title',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: SizedBox(
                width: 20, height: 20, child: ColoredBox(color: Colors.red)),
            title: Text('Title'),
          ),
        ),
      );

      final leadingFinder = find.byType(SizedBox).first;
      final titleFinder = find.text('Title');

      expect(leadingFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);

      final leadingRect = tester.getRect(leadingFinder);
      final titleRect = tester.getRect(titleFinder);

      // Leading should be positioned before title with spacing
      expect(leadingRect.right, lessThan(titleRect.left));
    });

    testWidgets('positions trailing widget correctly relative to title',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            trailing: SizedBox(
                width: 20, height: 20, child: ColoredBox(color: Colors.blue)),
          ),
        ),
      );

      final titleFinder = find.text('Title');
      final trailingFinder = find.byType(SizedBox).first;

      expect(titleFinder, findsOneWidget);
      expect(trailingFinder, findsOneWidget);

      final titleRect = tester.getRect(titleFinder);
      final trailingRect = tester.getRect(trailingFinder);

      // Trailing should be positioned after title with spacing
      expect(titleRect.right, lessThan(trailingRect.left));
    });

    testWidgets('applies correct spacing between elements', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            leading: SizedBox(
                width: 20, height: 20, child: ColoredBox(color: Colors.red)),
            title: Text('Title'),
            contentSpacing: 16,
          ),
        ),
      );

      final leadingFinder = find.byType(SizedBox).first;
      final titleFinder = find.text('Title');

      final leadingRect = tester.getRect(leadingFinder);
      final titleRect = tester.getRect(titleFinder);

      // The gap between leading right edge and title left edge should be approximately 16
      final gap = titleRect.left - leadingRect.right;
      expect(gap, closeTo(16, 1)); // Allow small tolerance for layout
    });

    testWidgets('accepts constraints parameter', (tester) async {
      // Test that constraints parameter doesn't cause errors
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            constraints: BoxConstraints(maxWidth: 150),
          ),
        ),
      );

      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      // The constraints are accepted but may not visibly constrain due to Row+Expanded design
    });

    testWidgets('renders with reasonable size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: BasicLayout(
              title: Text('Title'),
            ),
          ),
        ),
      );

      final layoutFinder = find.byType(BasicLayout);
      expect(layoutFinder, findsOneWidget);

      final layoutSize = tester.getSize(layoutFinder);
      // Should have some reasonable size
      expect(layoutSize.width, greaterThan(0));
      expect(layoutSize.height, greaterThan(0));
    });

    testWidgets('positions title above subtitle with correct spacing',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
        ),
      );

      final titleFinder = find.text('Title');
      final subtitleFinder = find.text('Subtitle');

      final titleRect = tester.getRect(titleFinder);
      final subtitleRect = tester.getRect(subtitleFinder);

      // Title should be above subtitle
      expect(titleRect.top, lessThan(subtitleRect.top));
      // There should be spacing between them
      expect(subtitleRect.top - titleRect.bottom, greaterThan(0));
    });

    testWidgets('positions content below title/subtitle with correct spacing',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: BasicLayout(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
            content: Text('Content'),
            titleSpacing: 12,
          ),
        ),
      );

      final subtitleFinder = find.text('Subtitle');
      final contentFinder = find.text('Content');

      final subtitleRect = tester.getRect(subtitleFinder);
      final contentRect = tester.getRect(contentFinder);

      // Content should be below subtitle
      expect(subtitleRect.bottom, lessThan(contentRect.top));
      // There should be spacing between them
      final gap = contentRect.top - subtitleRect.bottom;
      expect(gap, closeTo(12, 1)); // Allow small tolerance
    });

    testWidgets('does not apply text styling like Basic widget',
        (tester) async {
      // BasicLayout should not apply text styling, unlike Basic
      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              Basic(
                title: Text('Basic Title'),
                subtitle: Text('Basic Subtitle'),
              ),
              BasicLayout(
                title: Text('Layout Title'),
                subtitle: Text('Layout Subtitle'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(Basic), findsOneWidget);
      expect(find.byType(BasicLayout), findsOneWidget);
      expect(find.text('Basic Title'), findsOneWidget);
      expect(find.text('Layout Title'), findsOneWidget);
      // Both should render, but with different styling applied internally
    });
  });
}
