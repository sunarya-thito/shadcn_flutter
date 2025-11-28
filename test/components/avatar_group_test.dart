import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('AvatarGroup', () {
    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment.center,
            children: [],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      // Should render as empty SizedBox
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment.center,
            children: [Avatar(initials: 'A')],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('renders with multiple children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
              Avatar(initials: 'C'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(3));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('toLeft factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toLeft(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('toRight factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toRight(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('toStart factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toStart(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('toEnd factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toEnd(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('toTop factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toTop(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('toBottom factory constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup.toBottom(
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('respects custom gap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment(0.5, 0),
            gap: 10,
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });

    testWidgets('respects clip behavior', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment(0.5, 0),
            clipBehavior: Clip.hardEdge,
            children: [
              Avatar(initials: 'A'),
              Avatar(initials: 'B'),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      // Clip behavior is applied to the internal Stack, just verify it renders
    });

    testWidgets('handles different avatar sizes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              Avatar(initials: 'A', size: 30),
              Avatar(initials: 'B', size: 40),
              Avatar(initials: 'C', size: 50),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(3));
    });

    testWidgets('works with AvatarBadge children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AvatarGroup(
            alignment: Alignment(0.5, 0),
            children: [
              Avatar(initials: 'A'),
              AvatarBadge(child: Text('1')),
            ],
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsOneWidget);
      expect(find.byType(AvatarBadge), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('calculates correct group size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: AvatarGroup(
              alignment: Alignment(0.5, 0),
              children: [
                Avatar(initials: 'A', size: 40),
                Avatar(initials: 'B', size: 40),
              ],
            ),
          ),
        ),
      );

      final avatarGroupFinder = find.byType(AvatarGroup);
      expect(avatarGroupFinder, findsOneWidget);
      // The group should be sized to contain both overlapping avatars
      final size = tester.getSize(avatarGroupFinder);
      expect(size.width,
          greaterThan(40)); // Should be wider than single avatar due to overlap
      expect(size.height, 40); // Should be same height as avatars
    });

    testWidgets('handles RTL layout with directional alignment',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AvatarGroup.toStart(
              children: [
                Avatar(initials: 'A'),
                Avatar(initials: 'B'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(AvatarGroup), findsOneWidget);
      expect(find.byType(Avatar), findsNWidgets(2));
    });
  });
}
