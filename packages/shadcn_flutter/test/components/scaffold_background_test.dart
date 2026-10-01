import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  testWidgets('header color does not replace the scaffold body background', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ShadcnApp(
        home: Scaffold(
          backgroundColor: Colors.yellow,
          headerBackgroundColor: Colors.red,
          child: SizedBox.expand(key: Key('body')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final redContainer = find.byWidgetPredicate(
      (widget) => widget is Container && widget.color == Colors.red,
    );
    final yellowContainer = find.byWidgetPredicate(
      (widget) => widget is Container && widget.color == Colors.yellow,
    );

    expect(redContainer, findsOneWidget);
    expect(tester.getSize(redContainer).height, 0);
    expect(yellowContainer, findsOneWidget);
    expect(
      tester.getSize(yellowContainer),
      tester.getSize(find.byKey(const Key('body'))),
    );
  });
}
