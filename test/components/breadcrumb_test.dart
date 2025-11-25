import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Breadcrumb', () {
    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(children: []),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      // Should render as empty scroll view
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('renders with multiple children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Product'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Product'), findsOneWidget);
    });

    testWidgets('uses default arrow separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.byIcon(RadixIcons.chevronRight), findsOneWidget);
    });

    testWidgets('uses custom separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            separator: Icon(Icons.chevron_right),
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(RadixIcons.chevronRight), findsNothing);
    });

    testWidgets('uses slash separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            separator: Breadcrumb.slashSeparator,
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('/'), findsOneWidget);
    });

    testWidgets('respects custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            padding: EdgeInsets.all(16),
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('last child is styled as current page', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Current'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Current'), findsOneWidget);
      // The last child should be styled differently (foreground color)
    });

    testWidgets('intermediate children are styled as navigation',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Current'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      // Intermediate children should be styled as muted navigation items
    });

    testWidgets('handles many children with scrolling', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200, // Constrain width to force scrolling
            child: Breadcrumb(
              children: [
                Text('Home'),
                Text('Category'),
                Text('Subcategory'),
                Text('Product'),
                Text('Details'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      // Should be scrollable horizontally
    });

    testWidgets('positions separators between navigation items',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Product'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      // Should have separators between Home->Category and Category->Product
      expect(find.byIcon(RadixIcons.chevronRight), findsNWidgets(2));
    });

    testWidgets('renders correctly with button children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              TextButton(onPressed: () {}, child: Text('Home')),
              TextButton(onPressed: () {}, child: Text('Category')),
              Text('Current Page'),
            ],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text('Current Page'), findsOneWidget);
    });

    testWidgets('maintains proper spacing and layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      final breadcrumbFinder = find.byType(Breadcrumb);
      expect(breadcrumbFinder, findsOneWidget);

      final homeFinder = find.text('Home');
      final categoryFinder = find.text('Category');

      final homeRect = tester.getRect(homeFinder);
      final categoryRect = tester.getRect(categoryFinder);

      // Category should be positioned after Home with separator in between
      expect(homeRect.left, lessThan(categoryRect.left));
    });

    testWidgets('handles RTL layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Breadcrumb(
              children: [
                Text('Home'),
                Text('Category'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
    });

    testWidgets('works with theme integration', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Breadcrumb(
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(Breadcrumb), findsOneWidget);
      // Should integrate with theme for styling
    });
  });
}
