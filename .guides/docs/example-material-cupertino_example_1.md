---
title: "Example: components/material/cupertino_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:flutter/cupertino.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcnui;

class CupertinoExample1 extends StatefulWidget {
  const CupertinoExample1({super.key});

  @override
  State<CupertinoExample1> createState() => _CupertinoExample1State();
}

class _CupertinoExample1State extends State<CupertinoExample1> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('My Cupertino App'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            const shadcnui.Gap(16),
            CupertinoButton.filled(
              onPressed: () => setState(() => _counter++),
              child: const Icon(CupertinoIcons.add),
            ),
            const shadcnui.Gap(64),
            // shadcn_flutter widgets can also be used in a Cupertino app.
            // This card mirrors the Material example but uses Cupertino dialogs.
            shadcnui.ShadcnUI(
                child: shadcnui.Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'You can also use shadcn_flutter widgets inside Material widgets'),
                  const shadcnui.Gap(16),
                  shadcnui.PrimaryButton(
                    onPressed: () {
                      // Show a native Cupertino dialog
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Hello'),
                            content: const Text('This is Cupertino dialog'),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
```
