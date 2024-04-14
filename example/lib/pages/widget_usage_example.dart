import 'package:shadcn_flutter/shadcn_flutter.dart';

class WidgetUsageExample extends StatefulWidget {
  final Widget child;
  final String path;

  const WidgetUsageExample({
    Key? key,
    required this.child,
    required this.path,
  }) : super(key: key);

  @override
  State<WidgetUsageExample> createState() => _WidgetUsageExampleState();
}

class _WidgetUsageExampleState extends State<WidgetUsageExample> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabList(
          index: index,
          children: [
            TabButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              child: Text('Preview').semiBold().textSmall(),
            ),
            TabButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              child: Text('Code').semiBold().textSmall(),
            ),
          ],
        ),
        gap(12),
        index == 0
            ? OutlinedContainer(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  constraints: const BoxConstraints(minHeight: 350),
                  child: Center(
                    child: widget.child,
                  ),
                ),
              )
            : CodeSnippet(
                code: widget.path,
                mode: 'dart',
              ),
      ],
    );
  }
}
