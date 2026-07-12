import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  testWidgets('a sequence action (setVar then setValue) mutates the data model', (
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
            type: 'Button',
            properties: const {
              'child': 'label',
              'onPressed': {
                'sequence': [
                  {
                    'setVar': {'name': 'x', 'value': 5},
                  },
                  {
                    'setValue': {
                      'path': '/result',
                      'value': {'var': 'x'},
                    },
                  },
                ],
              },
            },
          ),
          Component(
            id: 'label',
            type: 'Text',
            properties: const {'text': 'Go'},
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

    expect(dataModel.getValue<int>(DataPath('/result')), isNull);
    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();
    expect(dataModel.getValue<int>(DataPath('/result')), 5);

    controller.dispose();
  });

  testWidgets(
    'a conditional action picks the matching branch and a system functionCall runs',
    (tester) async {
      final called = <String, Object?>{};
      final catalog = GenCatalog.asCatalog(
        systemFunctions: [_RecordFunction(called)],
      );
      final controller = SurfaceController(catalogs: [catalog]);
      final dataModel = controller.store.getDataModel('main');
      dataModel.update(DataPath('/confirmed'), true);
      controller.handleMessage(
        UpdateComponents(
          surfaceId: 'main',
          components: [
            Component(
              id: 'root',
              type: 'Button',
              properties: const {
                'child': 'label',
                'onPressed': {
                  'conditional': {
                    'condition': {'path': '/confirmed'},
                    'then': {
                      'functionCall': {
                        'call': 'record',
                        'args': {'value': 'yes'},
                      },
                    },
                    'else': {
                      'functionCall': {
                        'call': 'record',
                        'args': {'value': 'no'},
                      },
                    },
                  },
                },
              },
            ),
            Component(
              id: 'label',
              type: 'Text',
              properties: const {'text': 'Go'},
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

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();
      expect(called['value'], 'yes');

      controller.dispose();
    },
  );

  test('a GenSystemFunction bridged as a ClientFunction returns a real value', () async {
    final catalog = GenCatalog.asCatalog();
    final add = catalog.functions.firstWhere((f) => f.name == 'add');
    final results = <Object?>[];
    await for (final value in add.execute({
      'a': 2,
      'b': 3,
    }, _NoOpExecutionContext())) {
      results.add(value);
    }
    expect(results, [5.0]);
  });
}

class _RecordFunction extends GenSystemFunction {
  _RecordFunction(this.sink);
  final Map<String, Object?> sink;

  late GenDataField<String> value;

  @override
  String get name => 'record';
  @override
  String get description => 'Records its argument for test assertions.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    value = descriptor.string('value', label: 'Value');
  }

  @override
  Future<Object?> invoke([BuildContext? context]) async {
    sink['value'] = value.value;
    return null;
  }
}

class _NoOpExecutionContext implements ExecutionContext {
  @override
  DataPath get path => DataPath.root;
  @override
  ClientFunction? getFunction(String name) => null;
  @override
  ValueListenable<T?> subscribe<T>(DataPath path) =>
      throw UnimplementedError();
  @override
  Stream<T?> subscribeStream<T>(DataPath path) => throw UnimplementedError();
  @override
  T? getValue<T>(DataPath path) => null;
  @override
  void update(DataPath path, Object? contents) {}
  @override
  ExecutionContext nested(DataPath relativePath) => this;
  @override
  DataPath resolvePath(DataPath pathToResolve) => pathToResolve;
  @override
  Stream<Object?> resolve(Object? value) => Stream.value(value);
  @override
  Stream<bool> evaluateConditionStream(Object? condition) =>
      Stream.value(condition == true);
}
