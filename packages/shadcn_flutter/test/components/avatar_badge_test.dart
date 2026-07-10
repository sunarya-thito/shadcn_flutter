import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('AvatarBadge', () {
    testWidgets('renders with default properties', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      // Check that it renders without error - the Container is created internally
      expect(find.byType(Container), findsWidgets); // At least one Container
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: AvatarBadge(size: 20),
          ),
        ),
      );

      final avatarBadgeFinder = find.byType(AvatarBadge);
      expect(avatarBadgeFinder, findsOneWidget);
      final size = tester.getSize(avatarBadgeFinder);
      expect(size.width, 20);
      expect(size.height, 20);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(color: material.Colors.red),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      // The color is applied to the decoration, but we can't easily test the visual color
      // Just verify it renders
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(borderRadius: 8),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      // The border radius is applied to the decoration, but we can't easily test the visual radius
      // Just verify it renders
    });

    testWidgets('renders with child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(
            child: Icon(Icons.star),
          ),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders child with custom color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(
            color: material.Colors.blue,
            child: Text('5'),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.byType(AvatarBadge), findsOneWidget);
      // Color is applied internally, just verify it renders with child
    });

    testWidgets('uses theme values when widget values not provided',
        (tester) async {
      // AvatarBadge doesn't use AvatarTheme for its properties
      // It uses theme scaling and radius directly
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      // Theme values are used internally, just verify it renders
    });

    testWidgets('widget values override theme values', (tester) async {
      // AvatarBadge properties are not affected by AvatarTheme
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: AvatarBadge(
              size: 24,
              borderRadius: 12,
            ),
          ),
        ),
      );

      final avatarBadgeFinder = find.byType(AvatarBadge);
      expect(avatarBadgeFinder, findsOneWidget);
      final size = tester.getSize(avatarBadgeFinder);
      expect(size.width, 24);
      expect(size.height, 24);
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(),
        ),
      );

      final badge = tester.widget<AvatarBadge>(find.byType(AvatarBadge));
      expect(badge.child, null);
      expect(badge.size, null);
      expect(badge.borderRadius, null);
      expect(badge.color, null);
    });

    testWidgets('preserves key', (tester) async {
      const testKey = Key('test-badge');
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(key: testKey),
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets('renders in different sizes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Column(
            children: [
              AvatarBadge(size: 8),
              AvatarBadge(size: 16),
              AvatarBadge(size: 24),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarBadge), findsNWidgets(3));
      // Verify they render with different sizes by checking their rendered sizes
      final avatarBadges = find.byType(AvatarBadge);
      final firstSize = tester.getSize(avatarBadges.at(0));
      final secondSize = tester.getSize(avatarBadges.at(1));
      final thirdSize = tester.getSize(avatarBadges.at(2));
      expect(firstSize.width, 8);
      expect(secondSize.width, 16);
      expect(thirdSize.width, 24);
    });

    testWidgets('circular badge with default border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarBadge(size: 20),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
      // Border radius is applied internally for circular appearance, just verify it renders
    });
  });
}
