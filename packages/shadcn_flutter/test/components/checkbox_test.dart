import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('Checkbox', () {
    testWidgets('renders in unchecked state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Checkbox(
            state: CheckboxState.unchecked,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
      // Verify unchecked visual state (border only, no checkmark)
      // This is hard to verify without goldens or inspecting render object,
      // but we can ensure it renders without error.
    });

    testWidgets('renders in checked state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Checkbox(
            state: CheckboxState.checked,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('renders in indeterminate state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Checkbox(
            state: CheckboxState.indeterminate,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      CheckboxState? newState;
      await tester.pumpWidget(
        SimpleApp(
          child: Checkbox(
            state: CheckboxState.unchecked,
            onChanged: (value) => newState = value,
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      expect(newState, equals(CheckboxState.checked));
    });

    testWidgets('cycles tristate correctly', (tester) async {
      // Unchecked -> Checked -> Indeterminate -> Unchecked
      // Note: The logic in CheckboxState.toggleTristate or Checkbox widget might differ.
      // Let's check the implementation in checkbox.dart lines 608-628.
      // case checked: unchecked
      // case unchecked: indeterminate
      // case indeterminate: checked
      // Wait, let's re-read the code.
      // 611: case CheckboxState.checked: _changeTo(CheckboxState.unchecked);
      // 614: case CheckboxState.unchecked: _changeTo(CheckboxState.indeterminate);
      // 617: case CheckboxState.indeterminate: _changeTo(CheckboxState.checked);

      CheckboxState state = CheckboxState.unchecked;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Checkbox(
                state: state,
                tristate: true,
                onChanged: (value) {
                  setState(() {
                    state = value;
                  });
                },
              );
            },
          ),
        ),
      );

      // Unchecked -> Indeterminate
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(state, equals(CheckboxState.indeterminate));

      // Indeterminate -> Checked
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(state, equals(CheckboxState.checked));

      // Checked -> Unchecked
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(state, equals(CheckboxState.unchecked));
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Checkbox(
            state: CheckboxState.unchecked,
            onChanged: (value) {},
            leading: Text('Leading'),
            trailing: Text('Trailing'),
          ),
        ),
      );

      expect(find.text('Leading'), findsOneWidget);
      expect(find.text('Trailing'), findsOneWidget);
    });
  });

  group('ControlledCheckbox', () {
    testWidgets('works with controller', (tester) async {
      final controller = CheckboxController(CheckboxState.unchecked);
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledCheckbox(
            controller: controller,
            trailing: Text('Label'),
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);

      // Tap to toggle
      await tester.tap(find
          .text('Label')); // Tapping label should work if wrapped in Clickable?
      // Checkbox implementation wraps Row in Clickable (line 675 in checkbox.dart).
      // So tapping anywhere in the row (including leading/trailing) should work.

      await tester.pumpAndSettle();
      expect(controller.value, equals(CheckboxState.checked));
    });

    testWidgets('works with initialValue and onChanged', (tester) async {
      CheckboxState? state;
      await tester.pumpWidget(
        SimpleApp(
          child: ControlledCheckbox(
            initialValue: CheckboxState.unchecked,
            onChanged: (value) => state = value,
          ),
        ),
      );

      await tester.tap(find.byType(ControlledCheckbox));
      await tester.pumpAndSettle();

      expect(state, equals(CheckboxState.checked));
    });
  });
}
