import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcnui;
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart'
    show MaterialLayer;

class MaterialExample1 extends StatefulWidget {
  const MaterialExample1({super.key});

  @override
  State<MaterialExample1> createState() => _MaterialExample1State();
}

class _MaterialExample1State extends State<MaterialExample1> {
  int _counter = 0;

  void _incrementCounter() {
    // Demonstrates using a Material SnackBar inside a typical Scaffold app.
    // ScaffoldMessenger is installed by MaterialLayer (or by
    // MaterialShadcnApp, which wraps the whole app in one).
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have pushed the button $_counter times'),
      ),
    );
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialLayer supplies the Theme, Material and ScaffoldMessenger
    // ancestors that Material widgets need. At the root of a real app you would
    // reach for MaterialShadcnApp instead, which does this once for everything.
    return MaterialLayer(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('My Material App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const shadcnui.Gap(64),
              // You can compose shadcn_flutter widgets inside a Material app.
              // Wrapping with ShadcnUI ensures inherited theme/semantics are
              // properly applied.
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
                        // Show a native Material dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Hello'),
                              content: const Text('This is Material dialog'),
                              actions: [
                                TextButton(
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
                      child: const Text('Open Material Dialog'),
                    ),
                    const shadcnui.Gap(8),
                    shadcnui.SecondaryButton(
                      onPressed: () {
                        // Show a shadcn_flutter dialog side-by-side for comparison
                        shadcnui.showOverlay(
                          context,
                          shadcnui.DialogConfiguration(),
                          builder: (context) {
                            return shadcnui.AlertDialog(
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
                            );
                          },
                        );
                      },
                      child: const Text('Open shadcn_flutter Dialog'),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
