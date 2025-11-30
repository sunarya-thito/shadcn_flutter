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
        ),
        ChatGroup(
          color: Colors.gray,
          avatarPrefix: const Avatar(initials: 'JO'),
          type: otherType,
          alignment: otherAlignment,
          children: const [
            ChatBubble(child: Text('Around 6 or 7?')),
            ChatBubble(child: Text('New phone who dis?')),
          ],
        ),
        ChatBubble(
          color: Colors.blue,
          type: selfType,
          alignment: selfAlignment,
          child: const Text('SIX SEVENNN 🤤🤪'),
        ),
        ChatGroup(
          color: Colors.gray,
          avatarPrefix: const Avatar(initials: 'JO'),
          type: otherType,
          alignment: otherAlignment,
          children: const [
            ChatBubble(child: Text('?')),
            ChatBubble(child: Text('Seriously who is this')),
            ChatBubble(child: Text('gonna have to block you')),
          ],
        ),
        // controls
        gap(24),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _withLabel(
            label: 'Type',
            child: Select(
              value: type,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              },
              popup: SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                for (var e in ChatType.values)
                  SelectItemButton(value: e, child: Text(e.name)),
              ])),
              itemBuilder: (BuildContext context, ChatType value) {
                return Text(value.name);
              },
            ),
          ),
          _withLabel(
            label: 'Self Position',
            child: Select(
              value: selfPosition,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selfPosition = value;
                  });
                }
              },
              popup: const SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                SelectItemButton(
                    value: AxisDirectional.start, child: Text('Start')),
                SelectItemButton(
                    value: AxisDirectional.end, child: Text('End')),
                SelectItemButton(value: AxisDirectional.up, child: Text('Up')),
                SelectItemButton(
                    value: AxisDirectional.down, child: Text('Down')),
              ])),
              itemBuilder: (BuildContext context, AxisDirectional value) {
                return Text(value == AxisDirectional.start ? 'Start' : 'End');
              },
            ),
          ),
          _withLabel(
            label: 'Other Position',
            child: Select(
              value: otherPosition,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    otherPosition = value;
                  });
                }
              },
              popup: const SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                SelectItemButton(
                    value: AxisDirectional.start, child: Text('Start')),
                SelectItemButton(
                    value: AxisDirectional.end, child: Text('End')),
              ])),
              itemBuilder: (BuildContext context, AxisDirectional value) {
                return Text(value == AxisDirectional.start ? 'Start' : 'End');
              },
            ),
          ),
          _withLabel(
            label: 'Self Alignment',
            child: Select(
              value: selfAlignment,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selfAlignment = value;
                  });
                }
              },
              popup: const SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                SelectItemButton(
                    value: AxisAlignmentDirectional.start,
                    child: Text('Start')),
                SelectItemButton(
                    value: AxisAlignmentDirectional.end, child: Text('End')),
              ])),
              itemBuilder:
                  (BuildContext context, AxisAlignmentDirectional value) {
                return Text(
                    value == AxisAlignmentDirectional.start ? 'Start' : 'End');
              },
            ),
          ),
          _withLabel(
            label: 'Self Tail Alignment',
            child: Select(
              value: selfTailAlignment,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selfTailAlignment = value;
                  });
                }
              },
              popup: const SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                SelectItemButton(
                    value: AxisAlignmentDirectional.start,
                    child: Text('Start')),
                SelectItemButton(
                    value: AxisAlignmentDirectional.end, child: Text('End')),
              ])),
              itemBuilder:
                  (BuildContext context, AxisAlignmentDirectional value) {
                return Text(
                    value == AxisAlignmentDirectional.start ? 'Start' : 'End');
              },
            ),
          ),
          _withLabel(
              label: 'Self Behavior',
              child: Select(
                value: selfBehavior,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selfBehavior = value;
                    });
                  }
                },
                popup: const SelectPopup.noVirtualization(
                    items: SelectItemList(children: [
                  SelectItemButton(
                      value: TailBehavior.first, child: Text('First')),
                  SelectItemButton(
                      value: TailBehavior.last, child: Text('Last')),
                ])),
                itemBuilder: (BuildContext context, TailBehavior value) {
                  return Text(value == TailBehavior.first ? 'First' : 'Last');
                },
              )),
        ]),
        gap(24),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _withLabel(
            label: 'Other Position',
            child: Select(
              value: otherPosition,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    otherPosition = value;
                  });
                }
              },
              popup: const SelectPopup.noVirtualization(
                  items: SelectItemList(children: [
                SelectItemButton(
                    value: AxisDirectional.start, child: Text('Start')),
                SelectItemButton(
                    value: AxisDirectional.end, child: Text('End')),
                SelectItemButton(value: AxisDirectional.up, child: Text('Up')),
                SelectItemButton(
                    value: AxisDirectional.down, child: Text('Down')),
              ])),
              itemBuilder: (BuildContext context, AxisDirectional value) {
                return Text(value == AxisDirectional.start ? 'Start' : 'End');
              },
            ),
          ),
          _withLabel(
              label: 'Other Alignment',
              child: Select(
                value: otherAlignment,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      otherAlignment = value;
                    });
                  }
                },
                popup: const SelectPopup.noVirtualization(
                    items: SelectItemList(children: [
                  SelectItemButton(
                      value: AxisAlignmentDirectional.start,
                      child: Text('Start')),
                  SelectItemButton(
                      value: AxisAlignmentDirectional.end, child: Text('End')),
                ])),
                itemBuilder:
                    (BuildContext context, AxisAlignmentDirectional value) {
                  return Text(value == AxisAlignmentDirectional.start
                      ? 'Start'
                      : 'End');
                },
              )),
          _withLabel(
              label: 'Other Tail Alignment',
              child: Select(
                value: otherTailAlignment,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      otherTailAlignment = value;
                    });
                  }
                },
                popup: const SelectPopup.noVirtualization(
                    items: SelectItemList(children: [
                  SelectItemButton(
                      value: AxisAlignmentDirectional.start,
                      child: Text('Start')),
                  SelectItemButton(
                      value: AxisAlignmentDirectional.end, child: Text('End')),
                ])),
                itemBuilder:
                    (BuildContext context, AxisAlignmentDirectional value) {
                  return Text(value == AxisAlignmentDirectional.start
                      ? 'Start'
                      : 'End');
                },
              )),
          _withLabel(
              label: 'Other Behavior',
              child: Select(
                value: otherBehavior,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      otherBehavior = value;
                    });
                  }
                },
                popup: const SelectPopup.noVirtualization(
                    items: SelectItemList(children: [
                  SelectItemButton(
                      value: TailBehavior.first, child: Text('First')),
                  SelectItemButton(
                      value: TailBehavior.last, child: Text('Last')),
                ])),
                itemBuilder: (BuildContext context, TailBehavior value) {
                  return Text(value == TailBehavior.first ? 'First' : 'Last');
                },
              )),
        ]),
      ],
    );
  }

  Widget _withLabel({required String label, required Widget child}) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label),
          gap(8),
          child,
        ],
      ),
    );
  }
}

enum ChatType {
  plain,
  tail,
  sharpCorner,
}
