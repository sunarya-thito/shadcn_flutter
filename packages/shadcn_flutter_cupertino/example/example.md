# Example

`CupertinoShadcnApp` is a drop-in replacement for `ShadcnApp` that lets
Cupertino widgets build inside a shadcn_flutter app.

```dart
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_cupertino/shadcn_flutter_cupertino.dart';

void main() {
  runApp(
    CupertinoShadcnApp(
      title: 'Hybrid app',
      theme: ThemeData(
        colorScheme: ColorSchemes.lightZinc(),
        radius: 0.5,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorSchemes.darkZinc(),
        radius: 0.5,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // CupertinoPageScaffold and CupertinoNavigationBar both work:
    // CupertinoShadcnApp installed the CupertinoTheme ancestor and registered
    // the Cupertino localizations.
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino + shadcn_flutter'),
      ),
      child: Center(
        // shadcn_flutter components need ShadcnUI to inherit the right text
        // and icon styling when they sit under Cupertino widgets.
        child: ShadcnUI(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('A shadcn Card inside a CupertinoPageScaffold'),
                const Gap(16),
                PrimaryButton(
                  onPressed: () {
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Hello'),
                        content: const Text('A Cupertino dialog'),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Show a Cupertino dialog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

If Cupertino widgets only appear in part of the app, keep plain `ShadcnApp` and
wrap that subtree in a `CupertinoLayer`, passing
`kCupertinoLocalizationsDelegates` to `ShadcnApp.localizationsDelegates`.
