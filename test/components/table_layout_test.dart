import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  testWidgets('Table row height adjusts to wrapped text in Flex column',
      (WidgetTester tester) async {
    // A long text that is expected to wrap
    const longText =
        'This is some much longer text. This text should be too long to fit on one line and should wrap into additional lines.';

    await tester.pumpWidget(
      ShadcnApp(
        home: Scaffold(
          child: SizedBox(
            width: 400, // Constrained width to force wrapping
            child: Table(
              defaultRowHeight: const IntrinsicTableSize(),
              columnWidths: const {
                0: FixedTableSize(100), // Fixed width column
                1: FlexTableSize(), // Flex column that should take remaining space (300)
              },
              rows: [
                TableRow(
                  cells: [
                    const TableCell(child: Text('Short')),
                    TableCell(child: Text(longText)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find the text widget
    final textFinder = find.text(longText);
    expect(textFinder, findsOneWidget);

    // Get the size of the text widget
    final textSize = tester.getSize(textFinder);

    // The text should be wrapped, so its height should be significantly larger than a single line.
    // A single line of default text is usually around 14-20 pixels.
    // With 300px width, this text should wrap to at least 2 lines.
    expect(textSize.height, greaterThan(20.0),
        reason: 'Text should wrap and have height > 20');

    // Verify that the table row height is also adjusted.
    // We can check the height of the TableCell or the row itself if we can access it,
    // but checking the RenderTableLayout size or the cell container size is easier.
    // The TableCell wraps the child in a Container/DecoratedBox, so we can find that.

    // Let's find the RenderTableLayout and check its size.
    // final renderObject = tester.renderObject(tableFinder);
    // The table is inside a Container, which is inside the Table widget's build method.
    // Wait, Table widget builds a Container which contains RawTableLayout.
    // So we need to find RawTableLayout.
    final rawTableFinder = find.byType(RawTableLayout);
    expect(rawTableFinder, findsOneWidget);

    final renderTable = tester.renderObject(rawTableFinder) as RenderBox;
    // The total height of the table should be at least the height of the text + padding/borders if any.
    // In this simple case, it should be at least the text height.
    expect(renderTable.size.height, greaterThanOrEqualTo(textSize.height));
  });
}
