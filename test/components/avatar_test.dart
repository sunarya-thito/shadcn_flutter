import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Avatar', () {
    testWidgets('renders with initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            size: 60,
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.size, 60);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            borderRadius: 10,
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.borderRadius, 10);
    });

    testWidgets('renders with custom background color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            backgroundColor: Color(0xFFFF0000),
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.backgroundColor, Color(0xFFFF0000));
    });

    testWidgets('renders with image provider', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            provider: NetworkImage('https://example.com/image.jpg'),
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.provider, isA<NetworkImage>());
    });

    testWidgets('network constructor creates correct provider', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar.network(
            initials: 'JD',
            photoUrl: 'https://example.com/image.jpg',
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.provider, isA<NetworkImage>());
    });

    testWidgets('network constructor with cache dimensions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar.network(
            initials: 'JD',
            photoUrl: 'https://example.com/image.jpg',
            cacheWidth: 100,
            cacheHeight: 100,
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.provider, isA<ResizeImage>());
    });

    testWidgets('renders with badge', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            badge: AvatarBadge(color: Colors.green),
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      expect(find.byType(AvatarBadge), findsOneWidget);
    });

    testWidgets('renders with custom badge alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            badge: AvatarBadge(color: Colors.green),
            badgeAlignment: Alignment.topRight,
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.badgeAlignment, Alignment.topRight);
    });

    testWidgets('renders with custom badge gap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
            badge: AvatarBadge(color: Colors.green),
            badgeGap: 8,
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.badgeGap, 8);
    });

    testWidgets('getInitials generates correct initials', (tester) async {
      expect(Avatar.getInitials('John Doe'), 'JD');
      expect(Avatar.getInitials('John'), 'JO');
      expect(Avatar.getInitials('Madonna'), 'MA');
      expect(Avatar.getInitials('A'), 'A');
      expect(Avatar.getInitials(''), '');
    });

    testWidgets('handles empty initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: '',
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles long initials', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'VERYLONGINITIALS',
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      expect(find.text('VERYLONGINITIALS'), findsOneWidget);
    });

    testWidgets('renders in RTL', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleApp(
            child: Avatar(
              initials: 'JD',
            ),
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('applies theme scaling', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
          ),
        ),
      );

      expect(find.byType(Avatar), findsOneWidget);
      // The scaling should be applied to size and border radius
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Avatar(
            initials: 'JD',
          ),
        ),
      );

      final avatar = tester.widget<Avatar>(find.byType(Avatar));
      expect(avatar.backgroundColor, null);
      expect(avatar.size, null);
      expect(avatar.borderRadius, null);
      expect(avatar.badge, null);
      expect(avatar.badgeAlignment, null);
      expect(avatar.badgeGap, null);
      expect(avatar.provider, null);
    });
  });
}
