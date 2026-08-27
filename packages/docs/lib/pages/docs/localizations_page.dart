import 'package:docs/code_highlighter.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LocalizationsPage extends StatefulWidget {
  const LocalizationsPage({super.key});

  @override
  State<LocalizationsPage> createState() => _LocalizationsPageState();
}

class _LocalizationsPageState extends State<LocalizationsPage> {
  final keySetup = OnThisPage();
  final keyReading = OnThisPage();
  final keyOverriding = OnThisPage();
  final keyNewLocale = OnThisPage();
  final keyFormatting = OnThisPage();
  final keyDirectionality = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'localizations',
      onThisPage: {
        'Setting Up': keySetup,
        'Reading Strings': keyReading,
        'Overriding Strings': keyOverriding,
        'Adding a Locale': keyNewLocale,
        'Formatting Helpers': keyFormatting,
        'Right-to-Left Layouts': keyDirectionality,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SelectableText('Localizations').h1(),
          const SelectableText(
                  'Translating the text that shadcn_flutter components render on their own.')
              .lead(),
          const SelectableText(
                  'Components ship with built-in text: the "Cancel" on a dialog button, the month names in a '
                  'calendar, the validation message a form shows for an empty field. Those strings come from '
                  'ShadcnLocalizations rather than from your widget code, so this is where you change them.')
              .p(),
          const SelectableText(
                  'shadcn_flutter ships English only. Every other locale is something you supply.')
              .p(),
          const SelectableText('Setting Up').h2().anchored(keySetup),
          const SelectableText(
                  'ShadcnApp registers ShadcnLocalizations.delegate for you, so an app that only needs English '
                  'has nothing to do. Add the Flutter delegates and your supported locales when you localize '
                  'the rest of your app:')
              .p(),
          const CodeBlock(
            code: 'ShadcnApp(\n'
                '  localizationsDelegates: const [\n'
                '    GlobalMaterialLocalizations.delegate,\n'
                '    GlobalWidgetsLocalizations.delegate,\n'
                '    GlobalCupertinoLocalizations.delegate,\n'
                '  ],\n'
                '  supportedLocales: const [\n'
                "    Locale('en'),\n"
                "    Locale('id'),\n"
                '  ],\n'
                '  home: const MyHomePage(),\n'
                ');',
            mode: 'dart',
          ).p(),
          const SelectableText('Those delegates come from ')
              .thenInlineCode('flutter_localizations')
              .thenText(', which you add to your own pubspec:')
              .p(),
          const CodeBlock(
            code: 'dependencies:\n'
                '  flutter_localizations:\n'
                '    sdk: flutter',
            mode: 'yaml',
          ).p(),
          const SelectableText('Reading Strings').h2().anchored(keyReading),
          const SelectableText(
                  'Your own widgets can read the same strings the components use. This keeps a screen consistent '
                  'with the components on it, and means one translation covers both:')
              .p(),
          const CodeBlock(
            code: 'Widget build(BuildContext context) {\n'
                '  final localizations = ShadcnLocalizations.of(context);\n'
                '  return Text(localizations.buttonCancel);\n'
                '}',
            mode: 'dart',
          ).p(),
          const SelectableText('Overriding Strings')
              .h2()
              .anchored(keyOverriding),
          const SelectableText(
                  'To change wording without adding a language, subclass the English implementation and override '
                  'only what you want. Everything you leave alone keeps its default:')
              .p(),
          const CodeBlock(
            code: 'class MyLocalizations extends ShadcnLocalizationsEn {\n'
                '  @override\n'
                "  String get buttonCancel => 'Never mind';\n"
                '\n'
                '  @override\n'
                "  String get formNotEmpty => 'Please fill this in';\n"
                '}',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'Serve it through a delegate. ShadcnApp puts the delegates you pass ahead of its own, so yours '
                  'is the one Flutter resolves:')
              .p(),
          const CodeBlock(
            code: 'class MyLocalizationsDelegate\n'
                '    extends LocalizationsDelegate<ShadcnLocalizations> {\n'
                '  const MyLocalizationsDelegate();\n'
                '\n'
                '  @override\n'
                "  bool isSupported(Locale locale) => locale.languageCode == 'en';\n"
                '\n'
                '  @override\n'
                '  Future<ShadcnLocalizations> load(Locale locale) {\n'
                '    return SynchronousFuture(MyLocalizations());\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  bool shouldReload(MyLocalizationsDelegate old) => false;\n'
                '}\n'
                '\n'
                'ShadcnApp(\n'
                '  localizationsDelegates: const [MyLocalizationsDelegate()],\n'
                '  home: const MyHomePage(),\n'
                ');',
            mode: 'dart',
          ).p(),
          const SelectableText('Adding a Locale').h2().anchored(keyNewLocale),
          const SelectableText(
                  'A new language is the same shape of work, with two differences: extend ShadcnLocalizations '
                  'directly so the compiler lists everything still untranslated, and have isSupported answer for '
                  'your language code.')
              .p(),
          const CodeBlock(
            code: 'class ShadcnLocalizationsId extends ShadcnLocalizations {\n'
                "  ShadcnLocalizationsId([super.locale = 'id']);\n"
                '\n'
                '  @override\n'
                "  String get formNotEmpty => 'Bidang ini tidak boleh kosong';\n"
                '\n'
                '  @override\n'
                "  String get buttonCancel => 'Batal';\n"
                '\n'
                '  // ... the analyzer names the rest.\n'
                '}',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'Register the delegate the same way, and add the locale to supportedLocales so Flutter will '
                  'resolve to it. If every delegate reports a locale unsupported, Flutter falls back to the '
                  'first entry in supportedLocales.')
              .p(),
          const SelectableText('The English strings live in ')
              .thenInlineCode('lib/l10n/shadcn_en.arb')
              .thenText(
                  ' in the package. Reading it is the quickest way to see everything a locale has to cover.')
              .p(),
          const SelectableText('Formatting Helpers')
              .h2()
              .anchored(keyFormatting),
          const SelectableText(
                  'ShadcnLocalizations is a flat list of strings. Anything that combines them — naming a month '
                  'from its number, laying out a date, rendering a duration — lives on the '
                  'ShadcnLocalizationsExtensions extension:')
              .p(),
          const CodeBlock(
            code: 'final localizations = ShadcnLocalizations.of(context);\n'
                '\n'
                'localizations.getMonth(3); // March\n'
                'localizations.formatDateTime(DateTime.now());\n'
                'localizations.formatDuration(const Duration(minutes: 90));',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'These read through overridable members, so translating monthMarch changes what getMonth '
                  'returns.')
              .p(),
          const Alert.destructive(
            leading: Icon(LucideIcons.circleAlert),
            title: Text('Extension members cannot be overridden'),
            content: Text(
                'Dart resolves extension members against the static type, and components hold their '
                'localizations as ShadcnLocalizations. Declaring datePartsOrder or formatDateTime on a '
                'subclass therefore overrides nothing — the defaults (month/day/year ordering, YYYY/MM/DD '
                'abbreviations, "January 1, 2024" date layout) apply in every locale. Widgets that need a '
                'different order take it as a parameter instead.'),
          ).p(),
          const SelectableText('Right-to-Left Layouts')
              .h2()
              .anchored(keyDirectionality),
          const SelectableText(
                  'Translation and layout direction are separate concerns. Components read the ambient '
                  'Directionality, which Flutter sets from the active locale, so an Arabic or Hebrew locale '
                  'mirrors them without extra configuration.')
              .p(),
          const SelectableText(
                  'To force a direction — for a preview, or for one subtree — wrap it:')
              .p(),
          const CodeBlock(
            code: 'Directionality(\n'
                '  textDirection: TextDirection.rtl,\n'
                '  child: MyForm(),\n'
                ');',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'Table and ResizableTable also take a textDirection directly, which overrides the ambient one '
                  'for that table. Column indices stay logical either way: column 0 is the first column, and '
                  'under RTL it is laid out at the right edge, with frozen columns pinned there and horizontal '
                  'scrolling running leftwards.')
              .p(),
          const CodeBlock(
            code: 'Table(\n'
                '  textDirection: TextDirection.rtl,\n'
                '  columnWidths: const {0: FixedTableSize(120)},\n'
                '  rows: const [\n'
                '    TableRow(\n'
                '      cells: [\n'
                "        TableCell(child: Text('الاسم')),\n"
                "        TableCell(child: Text('البريد')),\n"
                '      ],\n'
                '    ),\n'
                '  ],\n'
                ');',
            mode: 'dart',
          ).p(),
        ],
      ),
    );
  }
}
