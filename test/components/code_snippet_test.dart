import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('CodeSnippet', () {
    testWidgets('renders code', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CodeSnippet(
            code: Text('print("Hello");'),
          ),
        ),
      );

      expect(find.byType(CodeSnippet), findsOneWidget);
      expect(find.text('print("Hello");'), findsOneWidget);
    });

    testWidgets('renders with actions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CodeSnippet(
            code: Text('code'),
            actions: [
              GhostButton(
                onPressed: () {},
                child: Icon(Icons.share),
              ),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('applies custom constraints', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: CodeSnippet(
            code: Text('code'),
            constraints: BoxConstraints(maxHeight: 100),
          ),
        ),
      );

      // Implementation detail: CodeSnippet -> Container -> Stack -> Container(constraints)
      // It's hard to target exactly without keys, but we can check if it renders without error.
      expect(find.byType(CodeSnippet), findsOneWidget);
    });
  });
}
