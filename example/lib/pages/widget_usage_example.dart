import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WidgetUsageExample extends StatefulWidget {
  final WidgetBuilder builder;
  final String code;

  const WidgetUsageExample({
    Key? key,
    required this.builder,
    required this.code,
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
            Button(
              type: ButtonType.static,
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              child: Text('Preview').semiBold(),
            ),
            Button(
              type: ButtonType.static,
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              child: Text('Code').semiBold(),
            ),
          ],
        ),
        gap(12),
        index == 0
            ? OutlinedContainer(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  constraints: const BoxConstraints(minHeight: 350),
                  child: Center(child: widget.builder(context)),
                ),
              )
            : CodeSnippet(
                code: widget.code,
                mode: 'dart',
              ),
      ],
    );
  }
}
