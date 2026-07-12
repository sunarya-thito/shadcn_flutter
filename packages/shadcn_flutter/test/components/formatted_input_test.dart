import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

const _partWidth = 40.0;

FormattedValue _dateLikeValue() {
  return const FormattedValue([
    FormattedValuePart(
        InputPart.editable(length: 2, width: _partWidth), 'AB'),
    FormattedValuePart(InputPart.static('/')),
    FormattedValuePart(
        InputPart.editable(length: 2, width: _partWidth), 'CD'),
    FormattedValuePart(InputPart.static('/')),
    FormattedValuePart(
        InputPart.editable(length: 2, width: _partWidth), 'EF'),
  ]);
}

void _mockClipboard(WidgetTester tester, List<MethodCall> log) {
  tester.binding.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, (call) async {
    log.add(call);
    return null;
  });
  addTearDown(() {
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });
}

void main() {
  group('FormattedInput cross-part selection', () {
    testWidgets('Select All selects every editable part', (tester) async {
      await tester.pumpWidget(SimpleApp(
        child: FormattedInput(initialValue: _dateLikeValue()),
      ));

      final fields = find.byType(TextField);
      expect(fields, findsNWidgets(3));

      Actions.invoke(tester.element(fields.first),
          const SelectAllTextIntent(SelectionChangedCause.keyboard));
      await tester.pump();

      for (final field in tester.widgetList<TextField>(fields)) {
        final controller = field.controller!;
        expect(
          controller.selection,
          TextSelection(baseOffset: 0, extentOffset: controller.text.length),
        );
      }
    });

    testWidgets('Copy after Select All copies the combined formatted value',
        (tester) async {
      final log = <MethodCall>[];
      _mockClipboard(tester, log);

      await tester.pumpWidget(SimpleApp(
        child: FormattedInput(initialValue: _dateLikeValue()),
      ));

      final context = tester.element(find.byType(TextField).first);
      Actions.invoke(
          context, const SelectAllTextIntent(SelectionChangedCause.keyboard));
      await tester.pump();
      Actions.invoke(context, CopySelectionTextIntent.copy);
      await tester.pump();

      final copyCall =
          log.firstWhere((call) => call.method == 'Clipboard.setData');
      expect(copyCall.arguments['text'], 'AB/CD/EF');
    });

    testWidgets(
        'a single field selection (no cross-part state) still copies just '
        'that field', (tester) async {
      final log = <MethodCall>[];
      _mockClipboard(tester, log);

      await tester.pumpWidget(SimpleApp(
        child: FormattedInput(initialValue: _dateLikeValue()),
      ));

      final firstField = find.byType(TextField).first;
      final controller = tester.widget<TextField>(firstField).controller!;

      // Focus the field for real (a tap moves the cursor too, so re-apply
      // the desired selection afterward) so that FocusManager.primaryFocus
      // -- the context real keyboard shortcuts dispatch from -- resolves
      // inside EditableText's own subtree. That's required for Flutter's
      // overridable-action search to find EditableText's default copy
      // action first and correctly thread it through as `callingAction`.
      await tester.tap(firstField);
      await tester.pump();
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      await tester.pump();

      Actions.invoke(primaryFocus!.context!, CopySelectionTextIntent.copy);
      await tester.pump();

      final copyCall =
          log.firstWhere((call) => call.method == 'Clipboard.setData');
      expect(copyCall.arguments['text'], 'AB');
    });

    testWidgets(
        'dragging from the first field into the last selects across the '
        'intervening parts', (tester) async {
      await tester.pumpWidget(SimpleApp(
        child: FormattedInput(initialValue: _dateLikeValue()),
      ));

      final fields = find.byType(TextField);
      final firstCenter = tester.getCenter(fields.first);
      final lastCenter = tester.getCenter(fields.last);

      final gesture =
          await tester.startGesture(firstCenter, kind: PointerDeviceKind.mouse);
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.moveTo(lastCenter);
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.up();
      await tester.pump();

      final controllers =
          tester.widgetList<TextField>(fields).map((f) => f.controller!);
      for (final controller in controllers) {
        expect(controller.selection.isCollapsed, isFalse,
            reason: 'every part should end up with a non-empty selection');
      }
    });

    testWidgets('a plain tap in another part clears the stale selection',
        (tester) async {
      await tester.pumpWidget(SimpleApp(
        child: FormattedInput(initialValue: _dateLikeValue()),
      ));

      final fields = find.byType(TextField);
      Actions.invoke(tester.element(fields.first),
          const SelectAllTextIntent(SelectionChangedCause.keyboard));
      await tester.pump();

      await tester.tap(fields.at(2));
      await tester.pump();

      final controllers =
          tester.widgetList<TextField>(fields).map((f) => f.controller!).toList();
      expect(controllers[0].selection, const TextSelection.collapsed(offset: 0));
      expect(controllers[1].selection, const TextSelection.collapsed(offset: 0));
    });
  });
}
