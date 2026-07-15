import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChatExample3 extends StatefulWidget {
  const ChatExample3({super.key});

  @override
  State<ChatExample3> createState() => _ChatExample3State();
}

class _ChatExample3State extends State<ChatExample3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        // ChatGroup example
        ChatGroup(
          color: Colors.blue,
          type:
              ChatBubbleType.tail.copyWith(position: () => AxisDirectional.end),
          alignment: AxisAlignmentDirectional.end,
          children: const [
            ChatBubble(
                child: Text(
                    'John, did you remember what time you took the call with Mrs. Smith?')),
            ChatBubble(child: Text('Reply ASAP')),
          ],
        ),
        ChatGroup(
          color: Colors.gray,
          avatarPrefix: const Avatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: ChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: const [
            ChatBubble(child: Text('Around 6 or 7?')),
            ChatBubble(child: Text('New phone who dis?')),
          ],
        ),
        ChatReaction(
          reaction: ChatReactionContainer(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: const [
                Text('❓'),
              ],
            ),
          ),
          child: ChatBubble(
            color: Colors.blue,
            alignment: AxisAlignmentDirectional.end,
            type: ChatBubbleType.tail
                .copyWith(position: () => AxisDirectional.end),
            child: const Text('SIX SEVENNN 🤤🤪'),
          ),
        ),
        ChatGroup(
          color: Colors.gray,
          avatarPrefix: const Avatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: ChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: [
            ChatBubble(child: Text('?')),
            ChatBubble(
              child: Text('Seriously who is this'),
            ),
            ChatReaction(
              child: ChatBubble(child: Text('gonna have to block you')),
              reaction: ChatReactionContainer(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Text('🤪'),
                    Text('👍'),
                    Text('+2').small.muted,
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum ChatType {
  plain,
  tail,
  sharpCorner,
}
