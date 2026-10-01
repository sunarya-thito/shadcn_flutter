import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  test('catalog exposes the standard no-asset A2UI surface', () {
    final catalog = GenCatalog.asCatalog();
    final names = catalog.items.map((item) => item.name).toSet();

    expect(catalog.catalogId, shadcnFlutterCatalogId);
    expect(catalog.matchesId(basicCatalogId), isTrue);
    expect(
      names,
      containsAll({
        'Button',
        'Card',
        'CheckBox',
        'ChoicePicker',
        'Column',
        'DateTimeInput',
        'Divider',
        'Icon',
        'List',
        'Modal',
        'Row',
        'Slider',
        'Tabs',
        'Text',
        'TextField',
      }),
    );
    expect(names, isNot(contains('Image')));
    expect(names, containsAll({'Switch', 'Progress'}));
  });

  testWidgets('CheckBox is two-way bound without an authored action', (
    tester,
  ) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'CheckBox',
          'label': 'I agree',
          'value': {'path': '/agreed'},
        },
      ],
      data: const {'agreed': false},
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('I agree'));
    await tester.pumpAndSettle();
    expect(fixture.model.getValue<bool>(DataPath('/agreed')), isTrue);

    fixture.model.update(DataPath('/agreed'), false);
    await tester.pumpAndSettle();
    expect(
      tester.widget<shad.Checkbox>(find.byType(shad.Checkbox)).state,
      shad.CheckboxState.unchecked,
    );
  });

  testWidgets('TextField follows external DataModel updates', (tester) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'TextField',
          'label': 'Name',
          'value': {'path': '/name'},
        },
      ],
      data: const {'name': 'Ada'},
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(find.text('Ada'), findsOneWidget);

    fixture.model.update(DataPath('/name'), 'Grace');
    await tester.pumpAndSettle();
    expect(find.text('Grace'), findsOneWidget);

    await tester.enterText(find.byType(shad.TextField), 'Lin');
    await tester.pump();
    expect(fixture.model.getValue<String>(DataPath('/name')), 'Lin');
  });

  testWidgets('Button dispatches a standard A2UI event', (tester) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Button',
          'child': 'label',
          'action': {
            'event': {
              'name': 'save',
              'context': {
                'name': {'path': '/name'},
              },
            },
          },
        },
        {'id': 'label', 'component': 'Text', 'text': 'Save'},
      ],
      data: const {'name': 'Ada'},
    );
    addTearDown(fixture.dispose);
    final submitted = fixture.controller.onSubmit.first;

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(
      await submitted.timeout(const Duration(seconds: 1)),
      isA<ChatMessage>(),
    );
  });

  testWidgets('core catalog renders under ShadcnApp without Material host', (
    tester,
  ) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Column',
          'children': ['title', 'card', 'check', 'field', 'progress'],
        },
        {
          'id': 'title',
          'component': 'Text',
          'text': 'Profile',
          'variant': 'h2',
        },
        {'id': 'card', 'component': 'Card', 'child': 'body'},
        {'id': 'body', 'component': 'Text', 'text': 'Ready'},
        {
          'id': 'check',
          'component': 'CheckBox',
          'label': 'Enabled',
          'value': true,
        },
        {
          'id': 'field',
          'component': 'TextField',
          'label': 'Name',
          'value': 'Ada',
        },
        {'id': 'progress', 'component': 'Progress', 'value': 0.5},
      ],
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Ready'), findsOneWidget);
  });
}

class _SurfaceFixture {
  _SurfaceFixture({required List<JsonMap> components, JsonMap? data}) {
    controller.handleMessage(
      core.CreateSurfaceMessage(
        version: 'v0.9',
        surfaceId: surfaceId,
        catalogId: catalog.catalogId!,
      ),
    );
    controller.handleMessage(
      core.UpdateDataModelMessage(
        version: 'v0.9',
        surfaceId: surfaceId,
        path: '/',
        value: <String, Object?>{...?data},
      ),
    );
    controller.handleMessage(
      core.UpdateComponentsMessage(
        version: 'v0.9',
        surfaceId: surfaceId,
        components: components,
      ),
    );
  }

  static const surfaceId = 'test';
  final Catalog catalog = GenCatalog.asCatalog();
  late final SurfaceController controller = SurfaceController(
    catalogs: [catalog],
  );

  DataModel get model => controller.contextFor(surfaceId).dataModel;

  shad.ShadcnApp get app => shad.ShadcnApp(
    home: Surface(surfaceContext: controller.contextFor(surfaceId)),
  );

  void dispose() => controller.dispose();
}
