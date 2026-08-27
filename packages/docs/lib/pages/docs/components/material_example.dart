import 'package:docs/code_highlighter.dart';
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/material/material_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'material/cupertino_example_1.dart';

class MaterialExample extends StatelessWidget {
  const MaterialExample({super.key});

  static TableCell _headerCell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text).muted().semiBold(),
      ),
    );
  }

  static TableCell _codeCell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text).mono().small(),
      ),
    );
  }

  static TableCell _textCell(String text) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'external',
      component: false,
      description:
          'shadcn_flutter no longer depends on Material or Cupertino. Add '
          'shadcn_flutter_material or shadcn_flutter_cupertino to use them side by side.',
      displayName: 'Material/Cupertino Widgets',
      children: [
        const Gap(24),
        const Alert(
          leading: Icon(LucideIcons.triangleAlert),
          title: Text('Breaking change'),
          content: Text(
            'Flutter moved Material and Cupertino out of the framework and into the '
            'material_ui and cupertino_ui packages. shadcn_flutter followed: the core '
            'package is now built on package:flutter/widgets.dart alone, and the '
            'Material and Cupertino integration lives in two new companion packages.',
          ),
        ),
        const Gap(32),
        const Text('The three packages').h2(),
        const Text(
          'Pick only what you need. Apps that use shadcn_flutter components '
          'exclusively need nothing beyond the core package.',
        ).p(),
        const Gap(16),
        Table(
          rows: [
            TableHeader(cells: [
              _headerCell('Package'),
              _headerCell('Use it when'),
            ]),
            TableRow(cells: [
              _codeCell('shadcn_flutter'),
              _textCell(
                'Always. Depends on package:flutter/widgets.dart only — no Material, '
                'no Cupertino, no MaterialIcons font.',
              ),
            ]),
            TableRow(cells: [
              _codeCell('shadcn_flutter_material'),
              _textCell(
                'You use Material widgets — Scaffold, AppBar, showDialog, '
                'ScaffoldMessenger, Icons — alongside shadcn_flutter components.',
              ),
            ]),
            TableRow(cells: [
              _codeCell('shadcn_flutter_cupertino'),
              _textCell(
                'You use Cupertino widgets — CupertinoPageScaffold, '
                'CupertinoNavigationBar, showCupertinoDialog, CupertinoIcons.',
              ),
            ]),
          ],
        ).p(),
        const Gap(16),
        const Text('Installation').h2(),
        const Text('Add the companion package next to shadcn_flutter:').p(),
        const CodeBlock(
          code: 'flutter pub add shadcn_flutter_material\n'
              '# or\n'
              'flutter pub add shadcn_flutter_cupertino',
          mode: 'shell',
        ).p(),
        const Text(
          'The companion package pulls in material_ui (or cupertino_ui) for you. Add '
          'that package directly as well if you import its widgets in your own code, '
          'which you almost always will.',
        ).p(),
        const Gap(16),
        const Text('At the root of the app').h2(),
        const Text(
          'MaterialShadcnApp is a drop-in replacement for ShadcnApp. It takes every '
          'parameter ShadcnApp takes, registers the Material localizations, and '
          'installs the Material theme, Material and ScaffoldMessenger ancestors that '
          'Material widgets need in order to build.',
        ).p(),
        const CodeBlock(
          code: '''
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';

void main() {
  runApp(
    MaterialShadcnApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorSchemes.lightZinc(),
        radius: 0.5,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Hybrid app')),
        body: const Center(
          child: PrimaryButton(child: Text('A shadcn button')),
        ),
      ),
    ),
  );
}''',
          mode: 'dart',
        ).p(),
        const Text(
          'CupertinoShadcnApp works the same way for Cupertino widgets.',
        ).p(),
        const Gap(16),
        const Alert(
          leading: Icon(LucideIcons.info),
          title: Text('Themes stay in sync'),
          content: Text(
            'The Material and Cupertino themes are derived from the shadcn theme, so '
            'they follow it automatically — including darkTheme and themeMode '
            'switches. Pass materialTheme or cupertinoTheme to override that.',
          ),
        ),
        const Gap(32),
        const Text('In one subtree only').h2(),
        const Text(
          'If Material widgets appear in only part of the app, keep the plain '
          'ShadcnApp and wrap that subtree in a MaterialLayer instead. Register the '
          'localizations delegates at the app level: delegates have to sit above the '
          'Localizations widget, so a layer alone cannot add them.',
        ).p(),
        const CodeBlock(
          code: '''
ShadcnApp(
  localizationsDelegates: kMaterialLocalizationsDelegates,
  home: Builder(
    builder: (context) {
      return MaterialLayer(
        child: Scaffold(
          appBar: AppBar(title: const Text('Only this screen')),
          body: const SizedBox.shrink(),
        ),
      );
    },
  ),
);''',
          mode: 'dart',
        ).p(),
        const Gap(16),
        const Text('The other direction').h2(),
        const Text(
          'To use shadcn_flutter components inside an existing MaterialApp or '
          'CupertinoApp you need neither companion package: wrap the subtree in a '
          'ShadcnLayer, or a single widget in ShadcnUI. ',
        )
            .thenButton(
              onPressed: () {
                context.goNamed('wrapper');
              },
              child: const Text('See the ShadcnLayer page.'),
            )
            .p(),
        const Gap(16),
        const Text('What moved').h2(),
        const Text(
          'The symbols below used to come from shadcn_flutter itself. Core '
          'replacements need no extra dependency; the rest moved to a companion '
          'package.',
        ).p(),
        const Gap(16),
        Table(
          rows: [
            TableHeader(cells: [
              _headerCell('Before'),
              _headerCell('Now'),
            ]),
            TableRow(cells: [
              _codeCell('Icons.add'),
              _textCell(
                'LucideIcons.plus (core), or Icons.add from shadcn_flutter_material',
              ),
            ]),
            TableRow(cells: [
              _codeCell('MaterialPageRoute, MaterialPage'),
              _textCell('ShadcnPageRoute, ShadcnPage (core)'),
            ]),
            TableRow(cells: [
              _codeCell('SliverAppBar'),
              _textCell(
                'SliverPersistentHeader (core), or SliverAppBar from '
                'shadcn_flutter_material',
              ),
            ]),
            TableRow(cells: [
              _codeCell('cupertinoDesktopTextSelectionHandleControls'),
              _textCell(
                'shadcnTextSelectionHandleControls (core), or the original from '
                'shadcn_flutter_cupertino',
              ),
            ]),
            TableRow(cells: [
              _codeCell('TextField.nativeContextMenuBuilder()'),
              _textCell(
                'buildAdaptiveEditableTextContextMenu from shadcn_flutter_material',
              ),
            ]),
            TableRow(cells: [
              _codeCell('TextField.materialContextMenuBuilder()'),
              _textCell(
                'buildMaterialEditableTextContextMenu from shadcn_flutter_material',
              ),
            ]),
            TableRow(cells: [
              _codeCell('TextField.cupertinoContextMenuBuilder()'),
              _textCell(
                'buildCupertinoEditableTextContextMenu from shadcn_flutter_cupertino',
              ),
            ]),
            TableRow(cells: [
              _codeCell('CupertinoSpellCheckSuggestionsToolbar'),
              _textCell(
                'SpellCheckSuggestionsToolbar (core), which renders shadcn styled '
                'menus',
              ),
            ]),
            TableRow(cells: [
              _codeCell('ShadcnApp.materialTheme / .cupertinoTheme'),
              _textCell(
                'MaterialShadcnApp.materialTheme / CupertinoShadcnApp.cupertinoTheme',
              ),
            ]),
            TableRow(cells: [
              _codeCell('ShadcnApp.debugShowMaterialGrid'),
              _textCell('ShadcnApp.debugShowGrid (core)'),
            ]),
            TableRow(cells: [
              _codeCell('SelectableText.useNativeContextMenu'),
              _textCell(
                'Pass contextMenuBuilder directly, e.g. '
                'buildAdaptiveEditableTextContextMenu',
              ),
            ]),
          ],
        ).p(),
        const Gap(16),
        Alert(
          leading: const Icon(LucideIcons.info),
          title: const Text('Note'),
          content: const Text(
                  'By default, Material/Cupertino Theme will follow shadcn_flutter theme. ')
              .thenButton(
                  onPressed: () {
                    context.goNamed('theme');
                  },
                  child: const Text(
                      'Try changing the shadcn_flutter theme right here!')),
        ),
        WidgetUsageExample(
          title: 'Material Example',
          path: 'lib/pages/docs/components/material/material_example_1.dart',
          summarize: false,
          child: const MaterialExample1().sized(width: 500, height: 900),
        ),
        WidgetUsageExample(
          title: 'Cupertino Example',
          path: 'lib/pages/docs/components/material/cupertino_example_1.dart',
          summarize: false,
          child: const CupertinoExample1().sized(width: 500, height: 900),
        ),
      ],
    );
  }
}
