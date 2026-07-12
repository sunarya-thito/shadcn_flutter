import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  testWidgets(
    'a Form only fires onSubmit once every field passes validation',
    (tester) async {
      final submitted = <String>[];
      final catalog = GenCatalog.asCatalog(
        systemFunctions: [_RecordSubmitFunction(submitted)],
      );
      final controller = SurfaceController(catalogs: [catalog]);
      controller.handleMessage(
        UpdateComponents(
          surfaceId: 'main',
          components: [
            Component(
              id: 'root',
              type: 'Form',
              properties: const {
                'child': 'col',
                'onSubmit': {
                  'functionCall': {'call': 'recordSubmit'},
                },
              },
            ),
            Component(
              id: 'col',
              type: 'Column',
              properties: const {
                'children': ['field1', 'submitBtn'],
              },
            ),
            Component(
              id: 'field1',
              type: 'TextField',
              properties: const {
                'value': '',
                'value_validators': [
                  {'kind': 'notEmpty'},
                ],
              },
            ),
            Component(
              id: 'submitBtn',
              type: 'Button',
              properties: const {
                'child': 'btnLabel',
                'onPressed': {'submitForm': {}},
              },
            ),
            Component(
              id: 'btnLabel',
              type: 'Text',
              properties: const {'text': 'Submit'},
            ),
          ],
        ),
      );
      controller.handleMessage(
        CreateSurface(surfaceId: 'main', catalogId: catalog.catalogId!),
      );

      await tester.pumpWidget(
        ShadcnApp(
          home: Surface(surfaceContext: controller.contextFor('main')),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(submitted, isEmpty);

      await tester.enterText(find.byType(TextField), 'hello');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(submitted, ['submitted']);

      controller.dispose();
    },
  );

  testWidgets(
    'a genui field is visible to an app-level Form the AI did not author',
    (tester) async {
      final catalog = GenCatalog.asCatalog();
      final controller = SurfaceController(catalogs: [catalog]);
      controller.handleMessage(
        UpdateComponents(
          surfaceId: 'main',
          components: [
            Component(
              id: 'root',
              type: 'CheckBox',
              properties: const {
                'value': false,
                'label': 'I agree',
                'onChanged': {
                  'setValue': {
                    'path': 'root.value',
                    'value': {'var': 'value'},
                  },
                },
              },
            ),
          ],
        ),
      );
      controller.handleMessage(
        CreateSurface(surfaceId: 'main', catalogId: catalog.catalogId!),
      );

      final appController = FormController();
      await tester.pumpWidget(
        ShadcnApp(
          home: Form(
            controller: appController,
            child: Surface(surfaceContext: controller.contextFor('main')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        appController.getValue(const FormKey<CheckboxState>('root')),
        CheckboxState.unchecked,
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(
        appController.getValue(const FormKey<CheckboxState>('root')),
        CheckboxState.checked,
      );

      controller.dispose();
    },
  );
}

class _RecordSubmitFunction extends GenSystemFunction {
  _RecordSubmitFunction(this.sink);
  final List<String> sink;

  @override
  String get name => 'recordSubmit';
  @override
  String get description => 'Records that the form was submitted.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {}

  @override
  Future<Object?> invoke([BuildContext? context]) async {
    sink.add('submitted');
    return null;
  }
}
