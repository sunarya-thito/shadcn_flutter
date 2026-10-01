import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  testWidgets('toast can be shown from inside a sheet overlay', (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        child: Builder(
          builder: (pageContext) {
            return PrimaryButton(
              onPressed: () {
                showOverlay(
                  pageContext,
                  const SheetConfiguration(position: OverlayPosition.bottom),
                  builder: (sheetContext) {
                    return PrimaryButton(
                      onPressed: () {
                        showToast(
                          context: sheetContext,
                          showDuration: const Duration(seconds: 1),
                          builder: (context, overlay) => const Text('toast'),
                        );
                      },
                      child: const Text('Show toast'),
                    );
                  },
                );
              },
              child: const Text('Open sheet'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show toast'));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('toast'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });
}
