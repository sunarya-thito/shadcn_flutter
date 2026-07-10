import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/chat/chat_example_1.dart';
import 'package:docs/pages/docs/components/chat/chat_example_2.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChatExample extends StatelessWidget {
  const ChatExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'chat',
      description: 'A chat widget',
      displayName: 'Chat',
      children: [
        WidgetUsageExample(
          title: 'Chat Example',
          path: 'lib/pages/docs/components/chat/chat_example_2.dart',
          child: ChatExample2(),
        ),
        WidgetUsageExample(
          title: 'Sandbox Chat Example',
          path: 'lib/pages/docs/components/chat/chat_example_1.dart',
          child: ChatExample1(),
        ),
      ],
    );
  }
}
