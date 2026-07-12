import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  testWidgets(
    'validators<T> composes selected kinds via AND and ignores an unknown kind',
    (tester) async {
      final catalog = GenCatalog.asCatalog();
      final controller = SurfaceController(catalogs: [catalog]);
      controller.handleMessage(
        UpdateComponents(
          surfaceId: 'main',
          components: [
            Component(
              id: 'root',
              type: 'TextField',
              properties: const {
                'value': '',
                'value_validators': [
                  {'kind': 'notEmpty'},
                  {'kind': 'length', 'min': 3},
                  {'kind': 'bogus'},
                ],
              },
            ),
          ],
        ),
      );
      controller.handleMessage(
        CreateSurface(surfaceId: 'main', catalogId: catalog.catalogId!),
      );

      late FormController formController;
      await tester.pumpWidget(
        ShadcnApp(
          home: Form(
            child: Builder(
              builder: (context) {
                formController = Form.of(context);
                return Surface(surfaceContext: controller.contextFor('main'));
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      Future<void> submit() async {
        final ctx = tester.element(find.byType(TextField));
        final result = ctx.submitForm();
        if (result is Future) await result;
        await tester.pumpAndSettle();
      }

      // Empty: fails notEmpty. The unknown 'bogus' kind must not crash.
      await submit();
      expect(formController.errors.values.whereType<InvalidResult>(), isNotEmpty);

      // Too short: fails length (min 3).
      await tester.enterText(find.byType(TextField), 'ab');
      await submit();
      expect(formController.errors.values.whereType<InvalidResult>(), isNotEmpty);

      // Passes both.
      await tester.enterText(find.byType(TextField), 'abc');
      await submit();
      expect(formController.errors.values.whereType<InvalidResult>(), isEmpty);

      controller.dispose();
    },
  );
}
