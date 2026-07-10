import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  Future<List<FlutterErrorDetails>> pumpAndCollectErrors(
    WidgetTester tester,
    Widget child,
  ) async {
    final errors = <FlutterErrorDetails>[];
    final originalOnError = FlutterError.onError;
    FlutterError.onError = errors.add;
    await tester.pumpWidget(SimpleApp(child: child));
    FlutterError.onError = originalOnError;
    return errors;
  }

  testWidgets('VerticalDivider does not throw in vertically-unbounded context',
      (tester) async {
    final errors = await pumpAndCollectErrors(
      tester,
      SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: Text('Left')),
            VerticalDivider(),
            Expanded(child: Text('Right')),
          ],
        ),
      ),
    );
    expect(errors, isEmpty);
  });

  testWidgets(
      'VerticalDivider with child does not throw in vertically-unbounded context',
      (tester) async {
    final errors = await pumpAndCollectErrors(
      tester,
      SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: Text('Left')),
            VerticalDivider(child: Text('OR')),
            const Expanded(child: Text('Right')),
          ],
        ),
      ),
    );
    expect(errors, isEmpty);
  });

  testWidgets('Divider does not throw in horizontally-unbounded context',
      (tester) async {
    final errors = await pumpAndCollectErrors(
      tester,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Top'),
            Divider(),
            Text('Bottom'),
          ],
        ),
      ),
    );
    expect(errors, isEmpty);
  });

  testWidgets(
      'Divider with child does not throw in horizontally-unbounded context',
      (tester) async {
    final errors = await pumpAndCollectErrors(
      tester,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Top'),
            Divider(child: Text('OR')),
            const Text('Bottom'),
          ],
        ),
      ),
    );
    expect(errors, isEmpty);
  });

  testWidgets('Divider still stretches to fill a bounded width', (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        useScaffold: false,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Top'),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
    final size = tester.getSize(find.byType(Divider));
    expect(size.width, 300);
  });

  testWidgets('VerticalDivider still stretches to fill a bounded height',
      (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        useScaffold: false,
        child: Center(
          child: SizedBox(
            height: 200,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Left'),
                VerticalDivider(),
              ],
            ),
          ),
        ),
      ),
    );
    final size = tester.getSize(find.byType(VerticalDivider));
    expect(size.height, 200);
  });
}
