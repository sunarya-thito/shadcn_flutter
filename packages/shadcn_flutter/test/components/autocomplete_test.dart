import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('AutoComplete', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: [],
            child: TextField(),
          ),
        ),
      );

      expect(find.byType(AutoComplete), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('shows suggestions when provided', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Apple', 'Banana', 'Cherry'],
            child: TextField(),
          ),
        ),
      );

      expect(find.byType(AutoComplete), findsOneWidget);
      // Suggestions should be available but not visible until triggered
    });

    testWidgets('handles empty suggestions list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: [],
            child: TextField(),
          ),
        ),
      );

      expect(find.byType(AutoComplete), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('accepts custom popover constraints', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            popoverConstraints: BoxConstraints(maxHeight: 200),
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.popoverConstraints, BoxConstraints(maxHeight: 200));
    });

    testWidgets('accepts custom popover width constraint', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            popoverWidthConstraint: PopoverConstraint.anchorFixedSize,
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.popoverWidthConstraint,
          PopoverConstraint.anchorFixedSize);
    });

    testWidgets('accepts custom popover alignments', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            popoverAnchorAlignment: AlignmentDirectional.topStart,
            popoverAlignment: AlignmentDirectional.bottomStart,
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(
          autoComplete.popoverAnchorAlignment, AlignmentDirectional.topStart);
      expect(autoComplete.popoverAlignment, AlignmentDirectional.bottomStart);
    });

    testWidgets('accepts custom mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            mode: AutoCompleteMode.append,
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.mode, AutoCompleteMode.append);
    });

    testWidgets('accepts custom completer', (tester) async {
      String customCompleter(String suggestion) => '$suggestion!';

      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            completer: customCompleter,
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.completer('Test'), 'Test!');
    });

    testWidgets('uses default completer when none provided', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.completer('Test'), 'Test');
    });

    testWidgets('works with TextField input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Apple', 'Banana'],
            child: TextField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'A');
      await tester.pump();

      expect(controller.text, 'A');
      expect(find.byType(AutoComplete), findsOneWidget);
    });

    testWidgets('handles large suggestions list', (tester) async {
      final suggestions = List.generate(100, (index) => 'Suggestion $index');

      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: suggestions,
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.suggestions.length, 100);
    });

    testWidgets('maintains child widget properties', (tester) async {
      const hintText = 'Enter text here';

      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: [],
            child: TextField(
              placeholder: Text(hintText),
            ),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: AutoComplete(
            suggestions: ['Test'],
            child: TextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<AutoComplete>(find.byType(AutoComplete));
      expect(autoComplete.popoverConstraints, null);
      expect(autoComplete.popoverWidthConstraint, null);
      expect(autoComplete.popoverAnchorAlignment, null);
      expect(autoComplete.popoverAlignment, null);
      expect(autoComplete.mode, null);
    });

    testWidgets('renders in RTL', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleApp(
            child: AutoComplete(
              suggestions: ['Test'],
              child: TextField(),
            ),
          ),
        ),
      );

      expect(find.byType(AutoComplete), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
