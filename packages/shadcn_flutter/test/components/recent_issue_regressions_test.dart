import 'dart:ui' show PointerDeviceKind;

import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/navigation/navigation_bar/misc.dart';

import '../test_helper.dart';

void main() {
  testWidgets('text field clips editable text to its reserved area', (
    tester,
  ) async {
    await tester.pumpWidget(
      const SimpleApp(
        child: SizedBox(
          width: 160,
          child: TextField(
            initialValue: 'A very long value that exceeds the field width',
            features: [InputFeature.trailing(Text('x'))],
          ),
        ),
      ),
    );

    final editableFinder = find.byType(EditableText);
    final editable = tester.widget<EditableText>(editableFinder);
    final contentStacks = tester.widgetList<Stack>(
      find.ancestor(of: editableFinder, matching: find.byType(Stack)),
    );
    expect(editable.clipBehavior, Clip.none);
    expect(
      contentStacks.any((stack) => stack.clipBehavior == Clip.hardEdge),
      isTrue,
    );
  });

  testWidgets('chip input preserves unclipped inline widget spans', (
    tester,
  ) async {
    await tester.pumpWidget(
      SimpleApp(
        child: ChipInput<String>(
          initialChips: const ['chip'],
          chipBuilder: (context, chip) => Text(chip),
          onChipSubmitted: (value) => value,
        ),
      ),
    );

    final editableFinder = find.byType(EditableText);
    final editable = tester.widget<EditableText>(editableFinder);
    final contentStacks = tester.widgetList<Stack>(
      find.ancestor(of: editableFinder, matching: find.byType(Stack)),
    );
    expect(editable.clipBehavior, Clip.none);
    expect(
      contentStacks.any((stack) => stack.clipBehavior == Clip.hardEdge),
      isTrue,
    );
  });

  testWidgets('navigation label uses direction-aware horizontal spacing', (
    tester,
  ) async {
    await tester.pumpWidget(
      const SimpleApp(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: NavigationLabeled(
            spacing: 12,
            position: NavigationLabelPosition.end,
            showLabel: true,
            labelType: NavigationLabelType.all,
            direction: Axis.horizontal,
            keepCrossAxisSize: false,
            keepMainAxisSize: false,
            child: Icon(LucideIcons.house),
            label: Text('Home'),
          ),
        ),
      ),
    );

    final padding = tester.widget<Padding>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding.resolve(TextDirection.rtl).right == 12,
      ),
    );
    final resolved = padding.padding.resolve(TextDirection.rtl);
    expect(resolved.left, 0);
    expect(resolved.right, 12);
  });

  testWidgets('disposing a waiting tooltip does not show an overlay', (
    tester,
  ) async {
    await tester.pumpWidget(
      const SimpleApp(
        child: Tooltip(
          waitDuration: Duration(milliseconds: 500),
          tooltip: _buildTooltip,
          child: SizedBox(width: 100, height: 40, child: Text('target')),
        ),
      ),
    );

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: Offset.zero);
    await mouse.moveTo(tester.getCenter(find.text('target')));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.pumpWidget(const SimpleApp(child: SizedBox()));
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
    await mouse.removePointer();
  });
}

Widget _buildTooltip(BuildContext context) => const Text('tooltip');
