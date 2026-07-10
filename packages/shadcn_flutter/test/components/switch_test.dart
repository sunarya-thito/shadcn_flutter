import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Switch', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Switch(
            value: true,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Switch(
                value: currentValue,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(currentValue, isTrue);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(currentValue, isFalse);
    });

    testWidgets('respects enabled state', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Switch(
            value: false,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(currentValue, isFalse);
    });
  });

  group('ControlledSwitch', () {
    testWidgets('works with controller', (tester) async {
      final controller = SwitchController(false);
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledSwitch(
            controller: controller,
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);

      controller.toggle();
      await tester.pump();

      // Verify visual state implicitly by checking if it didn't crash
      // and finding the widget.
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledSwitch(
            initialValue: true,
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
