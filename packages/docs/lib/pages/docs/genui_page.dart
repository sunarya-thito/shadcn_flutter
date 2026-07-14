import 'package:docs/code_highlighter.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class GenUIPage extends StatefulWidget {
  const GenUIPage({super.key});
  @override
  State<GenUIPage> createState() => _GenUIPageState();
}

class _GenUIPageState extends State<GenUIPage> {
  final keyGettingStarted = OnThisPage();
  final keyWithoutLlm = OnThisPage();
  final keyWidgets = OnThisPage();
  final keyForms = OnThisPage();
  final keyCustomCapabilities = OnThisPage();
  final keyExtending = OnThisPage();
  final keyFieldTypes = OnThisPage();
  final keyActions = OnThisPage();
  final keyValidation = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'genui',
      onThisPage: {
        'Getting Started': keyGettingStarted,
        'Trying It Without an LLM': keyWithoutLlm,
        'Widgets in the Catalog': keyWidgets,
        'Forms and Values': keyForms,
        'Custom Capabilities': keyCustomCapabilities,
        'Extending the Catalog': keyExtending,
        'Field Types': keyFieldTypes,
        'Actions': keyActions,
        'Validation': keyValidation,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SelectableText('GenUI').h1(),
          const SelectableText(
                  'Render AI-generated interfaces with shadcn_flutter widgets.')
              .lead(),
          Alert.destructive(
            leading: const Icon(Icons.new_releases_outlined),
            title: const SelectableText('Experimental'),
            content: const SelectableText(
                'This package is in early development. The API may change, and some widgets may be missing or incomplete.'),
          ).p(),
          const SelectableText('')
              .thenInlineCode('shadcn_flutter_genui')
              .thenText(' is a ')
              .thenInlineCode('genui')
              .thenText(
                  ' Catalog that renders AI-generated interfaces with shadcn_flutter widgets '
                  'instead of Material ones. Everything genui already gives you — ')
              .thenInlineCode('Conversation')
              .thenText(', ')
              .thenInlineCode('SurfaceController')
              .thenText(', ')
              .thenInlineCode('Surface')
              .thenText(
                  ', the data model, event handling — works exactly the same; this package just '
                  'supplies the catalog of widgets the AI is allowed to build with.')
              .p(),
          const Alert(
            leading: Icon(Icons.info_outline),
            title: SelectableText('New to genui?'),
            content: SelectableText(
                'Read the genui package README first. The concepts below (Conversation, '
                'SurfaceController, Surface, DataModel) are genui\'s, not this package\'s.'),
          ).p(),
          const SelectableText('Getting Started')
              .h2()
              .anchored(keyGettingStarted),
          const SelectableText('Add both packages:').p(),
          const CodeBlock(
            code: 'flutter pub add genui shadcn_flutter_genui',
            mode: 'shell',
          ).p(),
          const SelectableText('Wire up a ')
              .thenInlineCode('Conversation')
              .thenText(' the same way you would with genui\'s own ')
              .thenInlineCode('CoreCatalogItems')
              .thenText(', but pass ')
              .thenInlineCode('GenCatalog.asCatalog()')
              .thenText(' as the catalog:')
              .p(),
          const CodeBlock(
            code: "import 'package:genui/genui.dart';\n"
                "import 'package:shadcn_flutter/shadcn_flutter.dart';\n"
                "import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';\n"
                '\n'
                'class _MyHomePageState extends State<MyHomePage> {\n'
                '  late final SurfaceController _controller;\n'
                '  late final A2uiTransportAdapter _transport;\n'
                '  late final Conversation _conversation;\n'
                '\n'
                '  @override\n'
                '  void initState() {\n'
                '    super.initState();\n'
                '\n'
                '    // The only difference from a plain genui setup: use this\n'
                "    // package's catalog instead of (or merged with) genui's\n"
                '    // own CoreCatalogItems.\n'
                '    _controller = SurfaceController(catalogs: [GenCatalog.asCatalog()]);\n'
                '\n'
                '    _transport = A2uiTransportAdapter(onSend: _onSendToLLM);\n'
                '\n'
                '    _conversation = Conversation(controller: _controller, transport: _transport);\n'
                '  }\n'
                '\n'
                '  Future<void> _onSendToLLM(ChatMessage message) async {\n'
                '    // Call your LLM of choice and pipe the response stream in.\n'
                '    final responseStream = myLlmClient.streamGenerateContent(message);\n'
                '    await for (final chunk in responseStream) {\n'
                '      _transport.addChunk(chunk);\n'
                '    }\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return Surface(host: _conversation.host, surfaceId: mySurfaceId);\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  void dispose() {\n'
                '    _conversation.dispose();\n'
                '    _transport.dispose();\n'
                '    _controller.dispose();\n'
                '    super.dispose();\n'
                '  }\n'
                '}',
            mode: 'dart',
          ).p(),
          const SelectableText('From here, everything is standard genui: ')
              .thenInlineCode(
                  'conversation.sendRequest(ChatMessage.user(text))')
              .thenText(' to talk to the model, ')
              .thenInlineCode('conversation.events')
              .thenText(' to track surfaces being added or removed, and a ')
              .thenInlineCode('Surface')
              .thenText(
                  ' widget per surface id to render them. The AI now builds with shadcn_flutter widgets, '
                  'styled by whatever theme your ShadcnApp sets up.')
              .p(),
          const SelectableText('Trying It Without an LLM')
              .h2()
              .anchored(keyWithoutLlm),
          const SelectableText('genui ships ')
              .thenInlineCode('DebugCatalogView')
              .thenText(
                  ', which renders a catalog\'s built-in example data directly — no model, no network:')
              .p(),
          const CodeBlock(
            code:
                'runApp(ShadcnApp(home: DebugCatalogView(catalog: GenCatalog.asCatalog())));',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'Useful for sanity-checking that the catalog itself (and any widgets you\'ve added to it) '
                  'renders correctly before wiring up a real conversation.')
              .p(),
          const SelectableText('Widgets in the Catalog')
              .h2()
              .anchored(keyWidgets),
          const SelectableText(
                  'The catalog ships these shadcn_flutter widgets:')
              .p(),
          const SelectableText(
                  'TextField, TextArea, CheckBox, Switch, Select, RadioGroup, Slider, DatePicker, Button, '
                  'Card, Alert, Badge, Avatar, Progress, Accordion, Tabs, Form, FormFieldError.')
              .p(),
          const SelectableText('')
              .thenInlineCode('GenCatalog.asCatalog()')
              .thenText(' merges these with genui\'s own basics (')
              .thenInlineCode('Text')
              .thenText(', ')
              .thenInlineCode('Column')
              .thenText(', ')
              .thenInlineCode('Row')
              .thenText(', ...), so both remain available to the AI.')
              .p(),
          const SelectableText('Forms and Values').h2().anchored(keyForms),
          const SelectableText(
                  'Value-bearing widgets (TextField, Checkbox, Select, ...) participate in a real '
                  'shadcn_flutter Form when one is present — either one the AI composes with the Form widget, '
                  'or one your app wraps around a whole Surface.')
              .p(),
          const SelectableText('')
              .thenInlineCode('Form')
              .thenText('\'s ')
              .thenInlineCode('onSubmit')
              .thenText(
                  ' only fires once every field passes validation; a nested Button reaches it via a ')
              .thenInlineCode('submitForm')
              .thenText(' action.')
              .p(),
          const SelectableText('Custom Capabilities')
              .h2()
              .anchored(keyCustomCapabilities),
          const SelectableText(
                  'Beyond widgets, you can register your own non-UI operations the AI can call directly '
                  '(or a widget can trigger from an action):')
              .p(),
          const CodeBlock(
            code: 'class SetVolumeFunction extends GenSystemFunction {\n'
                '  late GenDataField<double> level;\n'
                '\n'
                '  @override\n'
                "  String get name => 'setVolume';\n"
                '  @override\n'
                "  String get description => 'Sets the system output volume, from 0.0 to 1.0.';\n"
                '  @override\n'
                '  void describeFields(GenDataFieldDescriptor descriptor) {\n'
                "    level = descriptor.decimal('level', label: 'Volume level (0.0-1.0)');\n"
                '  }\n'
                '  @override\n'
                '  Future<Object?> invoke([BuildContext? context]) async {\n'
                '    await MyVolumeApi.setVolume(level.value);\n'
                '    return null;\n'
                '  }\n'
                '}\n'
                '\n'
                '_controller = SurfaceController(\n'
                '  catalogs: [GenCatalog.asCatalog(systemFunctions: [SetVolumeFunction()])],\n'
                ');',
            mode: 'dart',
          ).p(),
          const SelectableText('')
              .thenInlineCode('GenFunctions')
              .thenText(
                  ' also ships a small built-in library of arithmetic, string, and boolean helpers (')
              .thenInlineCode('add')
              .thenText(', ')
              .thenInlineCode('round')
              .thenText(', ')
              .thenInlineCode('concat')
              .thenText(', ')
              .thenInlineCode('trim')
              .thenText(', ')
              .thenInlineCode('xor')
              .thenText(
                  ', ...), always available to the AI alongside anything you register.')
              .p(),
          const SelectableText('Extending the Catalog')
              .h2()
              .anchored(keyExtending),
          const SelectableText(
                  'To add a widget of your own to the catalog — styled with shadcn_flutter, following the same '
                  'conventions as the ones this package ships — declare a ')
              .thenInlineCode('GenSchema')
              .thenText('. It declares its AI-fillable fields once in ')
              .thenInlineCode('describeFields')
              .thenText(', then reads and writes them by name in ')
              .thenInlineCode('buildWidget')
              .thenText('.')
              .p(),
          const CodeBlock(
            code: 'class GenButtonSchema extends GenSchema {\n'
                '  late final GenField<Widget> child;\n'
                '  late final GenField<GenActionDispatcher?> onPressed;\n'
                '\n'
                '  @override\n'
                '  void describeFields(GenFieldDescriptor descriptor) {\n'
                '    child = descriptor.widget(\n'
                "      'child',\n"
                "      label: 'Button content',\n"
                "      example: TextSchema.new.withExample((s) => s.text.example = 'Press me'),\n"
                '    );\n'
                '    onPressed = descriptor.optionalAction(\n'
                "      'onPressed',\n"
                "      label: 'Triggered when the button is pressed',\n"
                "      example: const EventExample('pressed'),\n"
                '    );\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget buildWidget(BuildContext context) {\n'
                '    return Button.primary(\n'
                '      onPressed: onPressed[context].toVoidCallback(context),\n'
                '      child: child[context],\n'
                '    );\n'
                '  }\n'
                '}\n'
                '\n'
                "const genButton = GenCatalogItem(name: 'Button', label: 'Button', schema: GenButtonSchema.new);\n"
                '\n'
                "// Merge it into the catalog alongside this package's own widgets:\n"
                '_controller = SurfaceController(\n'
                '  catalogs: [GenCatalog.asCatalog().copyWith(newItems: [genButton.asCatalogItem])],\n'
                ');',
            mode: 'dart',
          ).p(),
          const SelectableText('Every field gets an ')
              .thenInlineCode('example:')
              .thenText(
                  ' — there\'s no hand-typed JSON exampleData anywhere in this DSL. Each widget\'s example '
                  'is generated entirely from its fields\' own declarations.')
              .p(),
          const SelectableText('Field Types').h2().anchored(keyFieldTypes),
          const SelectableText('')
              .thenInlineCode('GenFieldDescriptor')
              .thenText(' (passed into ')
              .thenInlineCode('describeFields')
              .thenText(') covers:')
              .p(),
          const SelectableText(
                  'string / optionalString — String; boolean / optionalBoolean — bool; '
                  'integer / optionalInteger — int; decimal / optionalDecimal — double; '
                  'enumerated<T> / optionalEnumerated<T> — a Dart enum.')
              .li(),
          const SelectableText(
                  'list / optionalList, set / optionalSet, map / optionalMap — collections of another field.')
              .li(),
          const SelectableText(
                  'widget / optionalWidget — a single child component, by id; widgetList — a list of child components, by id.')
              .li(),
          const SelectableText(
                  'object<T extends GenObject> — a nested, reusable data shape.')
              .li(),
          const SelectableText(
                  'action / optionalAction — fully AI-controlled interaction; valueAction / optionalValueAction — '
                  'an action with exactly one typed parameter; validators<T> — AI-selectable validation rules.')
              .li(),
          const SelectableText('')
              .thenInlineCode('GenObject')
              .thenText(
                  ' lets you declare a reusable nested shape (e.g. {title, body}) whose own fields are described via ')
              .thenInlineCode('GenDataFieldDescriptor')
              .thenText(
                  ' — the same field-kind vocabulary, minus action/widget, since a GenObject has no BuildContext of its own.')
              .p(),
          const SelectableText('Actions').h2().anchored(keyActions),
          const SelectableText(
                  'There\'s no schema-author-hardcoded "default" behavior for interactions. A field declared via ')
              .thenInlineCode('action')
              .thenText('/')
              .thenInlineCode('optionalAction')
              .thenText(
                  ' resolves, at runtime, to whatever the AI\'s JSON configured: doing nothing, notifying the AI '
                  '(event), calling a registered GenSystemFunction (functionCall), writing to the data model (setValue), '
                  'storing a temporary variable (setVar), composing several steps (sequence), branching (conditional), '
                  'catching errors (try), firing-and-forgetting (async), or submitting the ambient Form (submitForm).')
              .p(),
          const SelectableText(
                  'For the common case — a callback that hands the AI exactly one new value (onChanged, onSubmitted, ...) — use ')
              .thenInlineCode('valueAction')
              .thenText('/')
              .thenInlineCode('optionalValueAction')
              .thenText(':')
              .p(),
          const CodeBlock(
            code:
                "static const newValueParam = GenStringParameter('value', description: 'The new text');\n"
                '\n'
                'onChanged = descriptor.optionalValueAction<String>(\n'
                "  'onChanged',\n"
                "  label: 'Triggered on every keystroke',\n"
                '  parameter: newValueParam,\n'
                "  example: const SetValueExample('root.value', {'var': 'value'}),\n"
                ');\n'
                '\n'
                '// buildWidget:\n'
                'onChanged: onChanged[context].toValueCallback(context),',
            mode: 'dart',
          ).p(),
          const SelectableText('')
              .thenInlineCode('GenActionParameter<T>')
              .thenText(' ships typed subclasses (')
              .thenInlineCode('GenStringParameter')
              .thenText(', ')
              .thenInlineCode('GenBoolParameter')
              .thenText(', ')
              .thenInlineCode('GenIntParameter')
              .thenText(', ...) and is itself extensible. Use ')
              .thenInlineCode('.map<N>(...)')
              .thenText(
                  ' when a widget\'s native callback value (e.g. SliderValue, CheckboxState) needs projecting to '
                  'the parameter\'s own type first.')
              .p(),
          const SelectableText('Validation').h2().anchored(keyValidation),
          const SelectableText(
                  'A field never renders its own error text — that\'s not an individual widget\'s concern. Instead, ')
              .thenInlineCode(
                  'descriptor.validators<T>(fieldName, available: [...])')
              .thenText(
                  ' lets the AI attach a JSON-selectable list of GenValidator<T> kinds (GenNotEmptyValidator, '
                  'GenLengthValidator, GenRegexValidator, GenEmailValidator, GenUrlValidator, GenRangeValidator<T>, '
                  'GenNonNullValidator<T>), each backed by a real shadcn_flutter Validator and composed with AND semantics.')
              .p(),
          const SelectableText('')
              .thenInlineCode('wrapFormEntry')
              .thenText(
                  ' registers the field with whatever ambient Form exists. ')
              .thenInlineCode('FormFieldError')
              .thenText(
                  ' is a separate, AI-placed catalog item that shows another field\'s live error by id.')
              .p(),
        ],
      ),
    );
  }
}
