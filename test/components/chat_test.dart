import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  testWidgets('ChatBubble applies widthFactor', (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        child: ChatBubble(
          widthFactor: 0.8,
          child: Text('Hello'),
        ),
      ),
    );

    final chatConstrainedBox = tester.widget<ChatConstrainedBox>(
      find.byType(ChatConstrainedBox),
    );
    expect(chatConstrainedBox.widthFactor, 0.8);
  });

  testWidgets('ChatBubble applies widthFactor from ChatTheme', (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        child: ComponentTheme<ChatTheme>(
          data: ChatTheme(widthFactor: 0.7),
          child: ChatBubble(
            child: Text('Hello'),
          ),
        ),
      ),
    );

    final chatConstrainedBox = tester.widget<ChatConstrainedBox>(
      find.byType(ChatConstrainedBox),
    );
    expect(chatConstrainedBox.widthFactor, 0.7);
  });

  testWidgets('ChatBubble prefers local widthFactor over ChatTheme',
      (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        child: ComponentTheme<ChatTheme>(
          data: ChatTheme(widthFactor: 0.7),
          child: ChatBubble(
            widthFactor: 0.6,
            child: Text('Hello'),
          ),
        ),
      ),
    );

    final chatConstrainedBox = tester.widget<ChatConstrainedBox>(
      find.byType(ChatConstrainedBox),
    );
    expect(chatConstrainedBox.widthFactor, 0.6);
  });

  testWidgets('ChatBubble defaults to 0.5 widthFactor', (tester) async {
    await tester.pumpWidget(
      SimpleApp(
        child: ChatBubble(
          child: Text('Hello'),
        ),
      ),
    );

    final chatConstrainedBox = tester.widget<ChatConstrainedBox>(
      find.byType(ChatConstrainedBox),
    );
    expect(chatConstrainedBox.widthFactor, 0.5);
  });
}
