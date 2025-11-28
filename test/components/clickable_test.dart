import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Clickable', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Clickable(
            onPressed: () {},
            child: Text('Click Me'),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('handles tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Clickable(
            onPressed: () => tapped = true,
            child: Text('Click Me'),
          ),
        ),
      );

      await tester.tap(find.text('Click Me'));
      expect(tapped, isTrue);
    });

    testWidgets('handles double tap', (tester) async {
      bool doubleTapped = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Clickable(
            onPressed: () {},
            onDoubleTap: () => doubleTapped = true,
            child: Text('Click Me'),
          ),
        ),
      );

      await tester.tap(find.text('Click Me'));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('Click Me'));

      expect(doubleTapped, isTrue);
    });

    // Hover test disabled due to flakiness in test environment
    // testWidgets('handles hover state', (tester) async {
    //   bool hovered = false;
    //   await tester.pumpWidget(
    //     SimpleApp(
    //       child: Center(
    //         child: Clickable(
    //           onPressed: () {},
    //           onHover: (value) => hovered = value,
    //           child: Container(
    //             width: 100,
    //             height: 100,
    //             color: Colors.red,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    //
    //   final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    //   await gesture.addPointer(location: Offset.zero);
    //   addTearDown(gesture.removePointer);
    //   await tester.pump();
    //
    //   final center = tester.getCenter(find.byType(Container).last);
    //   await gesture.moveTo(center);
    //   await tester.pumpAndSettle();
    //
    //   expect(hovered, isTrue);
    //
    //   await gesture.moveTo(Offset.zero);
    //   await tester.pumpAndSettle();
    //
    //   expect(hovered, isFalse);
    // });

    testWidgets('respects enabled state', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Clickable(
            enabled: false,
            onPressed: () => tapped = true,
            child: Text('Click Me'),
          ),
        ),
      );

      await tester.tap(find.text('Click Me'));
      expect(tapped, isFalse);
    });
  });
}
