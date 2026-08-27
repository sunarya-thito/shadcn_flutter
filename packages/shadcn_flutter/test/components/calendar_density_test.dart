import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget _calendar(Density density, CalendarSelectionMode mode) {
  return ShadcnApp(
    theme: ThemeData(colorScheme: ColorSchemes.lightZinc, density: density),
    home: Scaffold(
      child: Center(
        child: DatePickerDialog(
          initialViewType: CalendarViewType.date,
          selectionMode: mode,
          initialView: CalendarView.now(),
        ),
      ),
    ),
  );
}

void main() {
  group('Calendar header density', () {
    // The month/year header button used to be pinned to a fixed height derived
    // from the default density's padding. Denser padding needs more room, so
    // at spacious density the label was silently clipped — the button is now
    // floored at that height rather than fixed to it.
    for (final entry in <String, Density>{
      'compact': Density.compactDensity,
      'default': Density.defaultDensity,
      'spacious': Density.spaciousDensity,
    }.entries) {
      for (final mode in CalendarSelectionMode.values) {
        testWidgets('${entry.key} density fits the ${mode.name} header', (
          tester,
        ) async {
          await tester.pumpWidget(_calendar(entry.value, mode));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          final headers = find.byType(GhostButton);
          expect(headers, findsWidgets);
          for (final element in headers.evaluate()) {
            final box = element.renderObject! as RenderBox;
            expect(
              box.size.height,
              greaterThanOrEqualTo(box.getMaxIntrinsicHeight(box.size.width)),
              reason: 'a header button is shorter than its content needs',
            );
          }
        });
      }
    }
  });
}
