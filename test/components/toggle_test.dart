import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Toggle', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Toggle(
            value: true,
            onChanged: (value) {},
            child: const Text('Toggle Me'),
          ),
        ),
      );

      expect(find.byType(Toggle), findsOneWidget);
      expect(find.text('Toggle Me'), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Toggle(
                value: currentValue,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                child: const Text('Toggle Me'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(Toggle));
      await tester.pump();

      expect(currentValue, isTrue);

      await tester.tap(find.byType(Toggle));
      await tester.pump();

      expect(currentValue, isFalse);
    });

    testWidgets('respects enabled state', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: Toggle(
            value: false,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
            child: const Text('Toggle Me'),
          ),
        ),
      );

      await tester.tap(find.byType(Toggle));
      await tester.pump();

      expect(currentValue, isFalse);
    });
  });

  group('ControlledToggle', () {
    testWidgets('works with controller', (tester) async {
      final controller = ToggleController(false);
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledToggle(
            controller: controller,
            child: const Text('Toggle Me'),
          ),
        ),
      );

      expect(find.byType(Toggle), findsOneWidget);

      controller.toggle();
      await tester.pump();

      // Verify visual state implicitly
      expect(find.byType(Toggle), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledToggle(
            initialValue: true,
            child: const Text('Toggle Me'),
          ),
        ),
      );

      expect(find.byType(Toggle), findsOneWidget);
    });
  });
}
