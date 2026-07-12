import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Slider;
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  testWidgets('every catalog item renders from its exampleData without throwing', (
    tester,
  ) async {
    final catalog = GenCatalog.asCatalog(
      systemFunctions: [_ToggleFullscreenFunction()],
    );
    await tester.pumpWidget(ShadcnApp(home: DebugCatalogView(catalog: catalog)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    // Spot-check a few of the auto-generated example values actually made
    // it onto the screen (DebugCatalogView lazily builds a ListView, so
    // only items within the initial viewport are checked here).
    expect(find.text('Check me'), findsOneWidget); // CheckBox trailing label
    expect(find.text('Press me'), findsOneWidget); // Button -> Text child
  });

  testWidgets('a live DataModel update propagates to the rendered Checkbox', (
    tester,
  ) async {
    final catalog = GenCatalog.asCatalog();
    final controller = SurfaceController(catalogs: [catalog]);
    final dataModel = controller.store.getDataModel('main');
    controller.handleMessage(
      UpdateComponents(
        surfaceId: 'main',
        components: [
          Component(
            id: 'root',
            type: 'CheckBox',
            properties: const {
              'value': {'path': '/agreed'},
              'label': 'I agree',
            },
          ),
        ],
      ),
    );
    controller.handleMessage(
      CreateSurface(surfaceId: 'main', catalogId: catalog.catalogId!),
    );

    await tester.pumpWidget(
      ShadcnApp(home: Surface(surfaceContext: controller.contextFor('main'))),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<Checkbox>(find.byType(Checkbox)).state,
      CheckboxState.unchecked,
    );

    dataModel.update(DataPath('/agreed'), true);
    await tester.pumpAndSettle();
    expect(
      tester.widget<Checkbox>(find.byType(Checkbox)).state,
      CheckboxState.checked,
    );

    controller.dispose();
  });
}

class _ToggleFullscreenFunction extends GenSystemFunction {
  @override
  String get name => 'toggleFullscreen';
  @override
  String get description => 'Toggles fullscreen mode.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {}
  @override
  Future<Object?> invoke([BuildContext? context]) async => null;
}
