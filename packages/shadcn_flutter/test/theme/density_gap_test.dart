import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  const firstKey = ValueKey('first');
  const secondKey = ValueKey('second');

  testWidgets('DensityGap follows a Row axis automatically', (tester) async {
    await tester.pumpWidget(
      const SimpleApp(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(key: firstKey, width: 10, height: 10),
              DensityGap(2),
              SizedBox(key: secondKey, width: 10, height: 10),
            ],
          ),
        ),
      ),
    );

    final first = tester.getTopLeft(find.byKey(firstKey));
    final second = tester.getTopLeft(find.byKey(secondKey));
    final gapSize = tester.getSize(find.byType(DensityGap));
    expect(gapSize.width, greaterThan(0));
    expect(gapSize.height, 0);
    expect(second.dx - first.dx, 10 + gapSize.width);
    expect(second.dy, first.dy);
  });

  testWidgets('DensityGap follows a Column axis automatically', (tester) async {
    await tester.pumpWidget(
      const SimpleApp(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(key: firstKey, width: 10, height: 10),
              DensityGap(2),
              SizedBox(key: secondKey, width: 10, height: 10),
            ],
          ),
        ),
      ),
    );

    final first = tester.getTopLeft(find.byKey(firstKey));
    final second = tester.getTopLeft(find.byKey(secondKey));
    final gapSize = tester.getSize(find.byType(DensityGap));
    expect(gapSize.width, 0);
    expect(gapSize.height, greaterThan(0));
    expect(second.dy - first.dy, 10 + gapSize.height);
    expect(second.dx, first.dx);
  });
}
