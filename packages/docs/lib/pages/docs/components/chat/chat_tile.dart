import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChatTile extends StatelessWidget implements IComponentPage {
  const ChatTile({super.key});

  @override
  String get title => 'Chat Bubble';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Chat Bubble',
      name: 'chat',
      center: true,
      scale: 1.1,
      example: SizedBox(
        width: 260,
        child: Column(
          spacing: 8,
          children: [
            ChatGroup(
              color: Colors.gray,
              avatarPrefix: const Avatar(initials: 'JO'),
              alignment: AxisAlignmentDirectional.start,
              children: const [
                ChatBubble(child: Text('Around 6 or 7?')),
                ChatBubble(child: Text('New phone who dis?')),
              ],
            ),
            const ChatBubble(
              color: Colors.blue,
              alignment: AxisAlignmentDirectional.end,
              child: Text('SIX SEVENNN'),
            ),
          ],
        ),
      ),
    );
  }
}
