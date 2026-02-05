import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChatExample2 extends StatefulWidget {
  const ChatExample2({super.key});

  @override
  State<ChatExample2> createState() => _ChatExample2State();
}

class _ChatExample2State extends State<ChatExample2> {
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
          avatarPrefix: Avatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: ChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: const [
            ChatBubble(child: Text('Around 6 or 7?')),
            ChatBubble(child: Text('New phone who dis?')),
          ],
        ),
        ChatBubble(
          color: Colors.blue,
          alignment: AxisAlignmentDirectional.end,
          type:
              ChatBubbleType.tail.copyWith(position: () => AxisDirectional.end),
          child: Text('SIX SEVENNN 🤤🤪'),
        ),
        ChatGroup(
          color: Colors.gray,
          avatarPrefix: Avatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: ChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: const [
            ChatBubble(child: Text('?')),
            ChatBubble(child: Text('Seriously who is this')),
            ChatBubble(child: Text('gonna have to block you')),
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
