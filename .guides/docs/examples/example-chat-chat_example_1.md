---
title: "Example: components/chat/chat_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChatExample1 extends StatefulWidget {
  const ChatExample1({super.key});

  @override
  State<ChatExample1> createState() => _ChatExample1State();
}

class _ChatExample1State extends State<ChatExample1> {
  AxisDirectional selfPosition = AxisDirectional.end;
  AxisDirectional otherPosition = AxisDirectional.start;
  AxisAlignmentDirectional selfAlignment = AxisAlignmentDirectional.end;
  AxisAlignmentDirectional otherAlignment = AxisAlignmentDirectional.start;
  AxisAlignmentDirectional selfTailAlignment = AxisAlignmentDirectional.end;
  AxisAlignmentDirectional otherTailAlignment = AxisAlignmentDirectional.end;
  TailBehavior selfBehavior = TailBehavior.last;
  TailBehavior otherBehavior = TailBehavior.last;
  ChatType type = ChatType.tail;

  ChatBubbleType get selfType => switch (type) {
        ChatType.tail => ChatBubbleType.tail.copyWith(
            position: () => selfPosition,
            tailAlignment: () => selfTailAlignment,
            tailBehavior: () => selfBehavior,
          ),
        ChatType.sharpCorner => ChatBubbleType.sharpCorner.copyWith(
            tailBehavior: () => selfBehavior,
          ),
        _ => ChatBubbleType.plain,
      };

  ChatBubbleType get otherType => switch (type) {
        ChatType.tail => ChatBubbleType.tail.copyWith(
            position: () => otherPosition,
            tailAlignment: () => otherTailAlignment,
            tailBehavior: () => otherBehavior,
          ),
        ChatType.sharpCorner => ChatBubbleType.sharpCorner.copyWith(
            tailBehavior: () => otherBehavior,
          ),
        _ => ChatBubbleType.plain,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        // ChatGroup example
        ChatGroup(
          color: Colors.blue,
          type: selfType,
          alignment: selfAlignment,
          children: const [
            ChatBubble(
                child: Text(
                    'John, did you remember what time you took the call with Mrs. Smith?')),
            ChatBubble(child: Text('Reply ASAP')),
          ],
```
