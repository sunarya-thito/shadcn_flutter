import 'package:flutter/cupertino.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcnui;

class CupertinoExample1 extends StatefulWidget {
  @override
  State<CupertinoExample1> createState() => _CupertinoExample1State();
}

class _CupertinoExample1State extends State<CupertinoExample1> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
            shadcnui.gap(16),
            CupertinoButton.filled(
              onPressed: () => setState(() => _counter++),
              child: const Icon(CupertinoIcons.add),
            ),
            shadcnui.gap(64),
            shadcnui.ShadcnUI(
                child: shadcnui.Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'You can also use shadcn_flutter widgets inside Material widgets'),
                  shadcnui.gap(16),
                  shadcnui.PrimaryButton(
                    onPressed: () {
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
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Open Cupertino Dialog'),
                  ),
                  shadcnui.gap(8),
                  shadcnui.SecondaryButton(
                    onPressed: () {
                      shadcnui.showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: shadcnui.AlertDialog(
                              title: const Text('Hello'),
                              content:
                                  const Text('This is shadcn_flutter dialog'),
                              actions: [
                                shadcnui.PrimaryButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Open shadcn_flutter Dialog'),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
