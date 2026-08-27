# Example

`MaterialShadcnApp` is a drop-in replacement for `ShadcnApp` that lets Material
widgets build inside a shadcn_flutter app.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
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
    // Scaffold, AppBar and ScaffoldMessenger all work: MaterialShadcnApp
    // installed the Theme, Material and ScaffoldMessenger ancestors, and
    // registered the Material localizations.
    return Scaffold(
      appBar: AppBar(title: const Text('Material + shadcn_flutter')),
      body: Center(
        // shadcn_flutter components need ShadcnUI to inherit the right text
        // and icon styling when they sit under Material widgets.
        child: ShadcnUI(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('A shadcn Card inside a Material Scaffold'),
                const Gap(16),
                PrimaryButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('A Material SnackBar')),
                    );
                  },
                  child: const Text('Show a SnackBar'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

If Material widgets only appear in part of the app, keep plain `ShadcnApp` and
wrap that subtree in a `MaterialLayer`, passing
`kMaterialLocalizationsDelegates` to `ShadcnApp.localizationsDelegates`.
