import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  testWidgets(
      'Button shape transition does not throw AssertionError and preserves values',
      (tester) async {
    bool isCircle = false;
    const Color buttonColor = Color(0xFF00FF00);

    await tester.pumpWidget(
      ShadcnApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              child: Center(
                child: Button(
                  style: ButtonStyle.outline(
                    shape:
                        isCircle ? ButtonShape.circle : ButtonShape.rectangle,
                  ).withBackgroundColor(color: buttonColor),
                  onPressed: () {
                    setState(() {
                      isCircle = !isCircle;
                    });
                  },
                  child: const Text('Button'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Initial state: rectangle
    Finder buttonFinder = find.byType(Button);
    expect(buttonFinder, findsOneWidget);

    // Get the Clickable's internal OverflowDecoratedBox
    Decoration getDecoration() {
      final decoratedBox = tester.widget<OverflowDecoratedBox>(find.descendant(
        of: buttonFinder,
        matching: find.byType(OverflowDecoratedBox),
      ));
      return decoratedBox.decoration;
    }

    Decoration startDecoration = getDecoration();
    expect(startDecoration, isA<BoxDecoration>());
    expect((startDecoration as BoxDecoration).shape, BoxShape.rectangle);
    expect(startDecoration.color, buttonColor);

    // Trigger transition to circle
    await tester.tap(find.text('Button'));
    await tester.pump(); // Start animation

    // Check middle of animation (t ~ 0.5)
    await tester.pump(const Duration(milliseconds: 100));
    Decoration midDecoration = getDecoration();

    // It should be a ShapeDecoration because shapes are different
    expect(midDecoration, isA<ShapeDecoration>(),
        reason:
            'Should use ShapeDecoration for smooth morphing during transition');

    // Verify values are being preserved/lerped
    final shapeDecoration = midDecoration as ShapeDecoration;
    expect(shapeDecoration.color, buttonColor);
    expect(shapeDecoration.shape, isA<ShapeBorder>());

    await tester.pump(const Duration(seconds: 1)); // End animation
    Decoration endDecoration = getDecoration();
    expect(endDecoration, isA<BoxDecoration>());
    expect((endDecoration as BoxDecoration).shape, BoxShape.circle);
    expect(endDecoration.color, buttonColor);
    expect(endDecoration.borderRadius, isNull);

    // Trigger transition back to rectangle
    await tester.tap(find.text('Button'));
    await tester.pump(); // Start
    await tester.pump(const Duration(milliseconds: 100));
    expect(getDecoration(), isA<ShapeDecoration>());
    expect((getDecoration() as ShapeDecoration).color, buttonColor);

    await tester.pump(const Duration(seconds: 1)); // End
    expect(getDecoration(), isA<BoxDecoration>());
    expect((getDecoration() as BoxDecoration).shape, BoxShape.rectangle);
    expect((getDecoration() as BoxDecoration).color, buttonColor);
  });
}
