import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  test('catalog exposes the standard no-asset A2UI surface', () {
    final catalog = GenCatalog.asCatalog();
    final names = catalog.components.keys.toSet();

    expect(catalog.id, shadcnFlutterCatalogId);
    expect(GenCatalog.asCatalogs().map((catalog) => catalog.id), [
      shadcnFlutterCatalogId,
      BasicCatalog.v0_9Id,
      'https://a2ui.org/specification/v0_9/basic_catalog.json',
    ]);
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
    expect(fixture.model.get('/agreed'), isTrue);

    fixture.model.set('/agreed', false);
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

    fixture.model.set('/name', 'Grace');
    await tester.pumpAndSettle();
    expect(find.text('Grace'), findsOneWidget);

    await tester.enterText(find.byType(shad.TextField), 'Lin');
    await tester.pump();
    expect(fixture.model.get('/name'), 'Lin');
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

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(fixture.actions.single.name, 'save');
    expect(fixture.actions.single.context, {'name': 'Ada'});
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
    expect(fixture.errors, isEmpty);
  });

  testWidgets('inputs with a literal value are read-only', (tester) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Column',
          'children': ['check', 'toggle'],
        },
        {
          'id': 'check',
          'component': 'CheckBox',
          'label': 'Enabled',
          'value': true,
        },
        {
          'id': 'toggle',
          'component': 'Switch',
          'label': 'Dark mode',
          'value': false,
        },
      ],
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();

    final checkbox = tester.widget<shad.Checkbox>(find.byType(shad.Checkbox));
    expect(checkbox.state, shad.CheckboxState.checked);
    expect(checkbox.onChanged, isNull);
    expect(
      tester.widget<shad.Switch>(find.byType(shad.Switch)).onChanged,
      isNull,
    );
  });

  testWidgets('Switch and Progress take a weight and accessibility', (
    tester,
  ) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Row',
          'children': ['toggle', 'progress'],
        },
        {
          'id': 'toggle',
          'component': 'Switch',
          'label': 'Dark mode',
          'value': {'path': '/dark'},
          'accessibility': {'label': 'Dark mode switch'},
        },
        {'id': 'progress', 'component': 'Progress', 'value': 0.5, 'weight': 1},
      ],
      data: const {'dark': false},
    );
    addTearDown(fixture.dispose);
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('^Dark mode switch')), findsOneWidget);
    semantics.dispose();

    await tester.tap(find.byType(shad.Switch));
    await tester.pumpAndSettle();
    expect(fixture.model.get('/dark'), isTrue);
    expect(fixture.errors, isEmpty);
  });

  testWidgets('Tabs show the child of the selected tab', (tester) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Tabs',
          'tabs': [
            {'title': 'Profile', 'child': 'profile'},
            {
              'title': {'path': '/billingTitle'},
              'child': 'billing',
            },
          ],
        },
        {'id': 'profile', 'component': 'Text', 'text': 'Profile details'},
        {'id': 'billing', 'component': 'Text', 'text': 'Billing details'},
      ],
      data: const {'billingTitle': 'Billing'},
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    final stack = find.byType(shad.IndexedStack);
    expect(tester.widget<shad.IndexedStack>(stack).index, 0);

    await tester.tap(find.text('Billing'));
    await tester.pumpAndSettle();
    expect(tester.widget<shad.IndexedStack>(stack).index, 1);
    expect(fixture.errors, isEmpty);
  });

  testWidgets('DateTimeInput shows the pickers its flags enable', (
    tester,
  ) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Column',
          'children': ['date', 'time', 'both'],
        },
        {
          'id': 'date',
          'component': 'DateTimeInput',
          'label': 'Date only',
          'value': {'path': '/date'},
          'enableDate': true,
        },
        {
          'id': 'time',
          'component': 'DateTimeInput',
          'label': 'Time only',
          'value': {'path': '/time'},
          'enableTime': true,
        },
        {
          'id': 'both',
          'component': 'DateTimeInput',
          'label': 'Date and time',
          'value': {'path': '/both'},
          'enableDate': true,
          'enableTime': true,
        },
      ],
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();

    expect(find.byType(shad.DatePicker), findsNWidgets(2));
    expect(find.byType(shad.TimePicker), findsNWidgets(2));
    expect(fixture.errors, isEmpty);
  });

  testWidgets('Button is disabled while a check fails', (tester) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Column',
          'children': ['name', 'save'],
        },
        {
          'id': 'name',
          'component': 'TextField',
          'label': 'Name',
          'value': {'path': '/name'},
          'checks': [
            {
              'condition': {
                'call': 'required',
                'args': {
                  'value': {'path': '/name'},
                },
              },
              'message': 'Enter a name',
            },
          ],
        },
        {
          'id': 'save',
          'component': 'Button',
          'child': 'label',
          'action': {
            'event': {'name': 'save'},
          },
          'checks': [
            {
              'condition': {
                'call': 'required',
                'args': {
                  'value': {'path': '/name'},
                },
              },
              'message': 'Enter a name',
            },
          ],
        },
        {'id': 'label', 'component': 'Text', 'text': 'Save'},
      ],
      data: const {'name': ''},
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(find.text('Enter a name'), findsOneWidget);
    expect(
      tester.widget<shad.Button>(find.byType(shad.Button)).onPressed,
      isNull,
    );

    await tester.enterText(find.byType(shad.TextField), 'Ada');
    await tester.pumpAndSettle();
    expect(find.text('Enter a name'), findsNothing);

    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(fixture.actions.single.name, 'save');
  });

  testWidgets('Modal shows its content and closeModal closes it', (
    tester,
  ) async {
    final fixture = _SurfaceFixture(
      components: [
        {
          'id': 'root',
          'component': 'Modal',
          'trigger': 'open',
          'content': 'body',
        },
        {'id': 'open', 'component': 'Text', 'text': 'Open'},
        {
          'id': 'body',
          'component': 'Column',
          'children': ['agree', 'close'],
        },
        {
          'id': 'agree',
          'component': 'CheckBox',
          'label': 'I agree',
          'value': {'path': '/agreed'},
        },
        {
          'id': 'close',
          'component': 'Button',
          'child': 'closeLabel',
          'action': {
            'functionCall': {'call': 'closeModal'},
          },
        },
        {'id': 'closeLabel', 'component': 'Text', 'text': 'Close'},
      ],
      data: const {'agreed': false},
    );
    addTearDown(fixture.dispose);

    await tester.pumpWidget(fixture.app);
    await tester.pumpAndSettle();
    expect(find.text('I agree'), findsNothing);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I agree'));
    await tester.pumpAndSettle();
    expect(fixture.model.get('/agreed'), isTrue);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('I agree'), findsNothing);
    expect(fixture.errors, isEmpty);
  });
}

class _SurfaceFixture {
  _SurfaceFixture({
    required List<Map<String, Object?>> components,
    Map<String, Object?>? data,
  }) {
    processor.model.onAction.subscribe(actions.add);
    processor.model.onError.subscribe(errors.add);
    processor.processMessages(
      AgentToRendererMessagePayload([
        CreateSurfaceMessage(
          version: 'v0.9',
          surfaceId: surfaceId,
          catalogId: catalog.id,
        ),
        UpdateDataModelMessage(
          version: 'v0.9',
          surfaceId: surfaceId,
          path: '/',
          value: <String, Object?>{...?data},
        ),
        UpdateComponentsMessage(
          version: 'v0.9',
          surfaceId: surfaceId,
          components: components,
        ),
      ]),
    );
  }

  static const surfaceId = 'test';
  final CatalogImplementation catalog = GenCatalog.asCatalog();
  late final MessageProcessor<ComponentImplementation> processor =
      MessageProcessor(
        catalogs: [catalog],
        validationConfig: ValidationConfig.strict,
      );
  final actions = <A2uiRendererAction>[];
  final errors = <A2uiRendererError>[];

  DataModel get model => processor.model.getSurface(surfaceId)!.dataModel;

  shad.ShadcnApp get app => shad.ShadcnApp(
    home: A2uiSurface(surface: processor.model.getSurface(surfaceId)!),
  );

  void dispose() => processor.dispose();
}
