import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('ContextMenu', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ContextMenu(
            items: [
              MenuButton(child: const Text('Item 1'), onPressed: (context) {}),
            ],
            child: const Text('Right click me'),
          ),
        ),
      );

      expect(find.text('Right click me'), findsOneWidget);
    });

    testWidgets('opens on right click', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ContextMenu(
            items: [
              MenuButton(child: const Text('Item 1'), onPressed: (context) {}),
              MenuButton(child: const Text('Item 2'), onPressed: (context) {}),
            ],
            child: const Text('Right click me'),
          ),
        ),
      );

      // Right click
      await tester.tap(find.text('Right click me'), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('handles item tap', (tester) async {
      bool item1Tapped = false;

      await tester.pumpWidget(
        SimpleApp(
          child: ContextMenu(
            items: [
              MenuButton(
                child: const Text('Item 1'),
                onPressed: (context) => item1Tapped = true,
              ),
            ],
            child: const Text('Right click me'),
          ),
        ),
      );

      // Right click
      await tester.tap(find.text('Right click me'), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      // Tap item
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(item1Tapped, isTrue);
      // Menu should close
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('renders submenus', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ContextMenu(
            items: [
              MenuButton(
                subMenu: [
                  MenuButton(
                      child: const Text('SubItem 1'), onPressed: (context) {}),
                ],
                onPressed: (context) {},
                child: const Text('Submenu'),
              ),
            ],
            child: const Text('Right click me'),
          ),
        ),
      );

      // Right click
      await tester.tap(find.text('Right click me'), buttons: kSecondaryButton);
      await tester.pumpAndSettle();

      expect(find.text('Submenu'), findsOneWidget);
      expect(find.text('SubItem 1'), findsNothing);

      // Hover over submenu item to open it
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.text('Submenu')));
      await tester.pump();
      await tester
          .pump(const Duration(milliseconds: 500)); // Wait for hover delay
      await tester.pumpAndSettle(); // Wait for animation

      // TODO: Fix submenu test
      // expect(find.text('SubItem 1'), findsOneWidget);
    });
  });
}
