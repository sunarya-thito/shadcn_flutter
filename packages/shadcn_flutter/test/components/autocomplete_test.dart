import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

/// Mirrors the docs example: a text field whose suggestions are filtered from
/// the current word on every change.
class _FilteredAutoComplete extends StatefulWidget {
  const _FilteredAutoComplete();
  @override
  State<_FilteredAutoComplete> createState() => _FilteredAutoCompleteState();
}

class _FilteredAutoCompleteState extends State<_FilteredAutoComplete> {
  final List<String> _all = const [
    'Apple',
    'Banana',
    'Cherry',
    'Grape',
    'Pineapple',
  ];
  List<String> _current = [];
  final TextEditingController _controller = TextEditingController();

  void _update(String value) {
    final word = _controller.currentWord;
    if (word == null || word.isEmpty) {
      setState(() => _current = []);
      return;
    }
    setState(() {
      _current = _all
          .where((e) => e.toLowerCase().contains(word.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoComplete(
      suggestions: _current,
      child: TextField(controller: _controller, onChanged: _update),
    );
  }
}

// Suggestion items are SelectedButtons; the text field itself is not, so this
// counts only the entries of an open popover.
int _openSuggestionCount() => find.byType(SelectedButton).evaluate().length;

Future<void> _settle(WidgetTester tester) async {
  // The focused text field keeps a blinking-cursor animation alive, so
  // pumpAndSettle would never settle. Pump a bounded, generous amount instead.
  for (int i = 0; i < 30; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

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

    testWidgets('does not reopen the popover after selecting a suggestion',
        (tester) async {
      await tester.pumpWidget(const SimpleApp(child: _FilteredAutoComplete()));

      await tester.enterText(find.byType(TextField), 'App');
      await _settle(tester);
      expect(_openSuggestionCount(), greaterThan(0));

      // Completing "Pineapple" narrows the match set, which previously caused
      // the popover to reopen right after the selection.
      await tester.tap(find.text('Pineapple').first);
      await _settle(tester);

      expect(_openSuggestionCount(), 0,
          reason: 'popover should stay closed after selecting a suggestion');
    });

    testWidgets('reopens the popover when typing after a selection',
        (tester) async {
      await tester.pumpWidget(const SimpleApp(child: _FilteredAutoComplete()));

      await tester.enterText(find.byType(TextField), 'Ba');
      await _settle(tester);
      expect(_openSuggestionCount(), greaterThan(0));

      await tester.tap(find.text('Banana').first);
      await _settle(tester);
      expect(_openSuggestionCount(), 0);

      // Starting a new word must open the popover again.
      await tester.enterText(find.byType(TextField), 'Banana Gr');
      await _settle(tester);
      expect(_openSuggestionCount(), greaterThan(0),
          reason: 'typing after a selection should reopen suggestions');
      expect(find.text('Grape'), findsWidgets);
    });
  });
}
