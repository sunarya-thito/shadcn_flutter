# shadcn_flutter_genui

A [`genui`](https://pub.dev/packages/genui) `Catalog` that renders AI-generated interfaces with `shadcn_flutter` widgets instead of Material ones. Everything genui already gives you — `Conversation`, `SurfaceController`, `Surface`, the data model, event handling — works exactly the same; this package just supplies the catalog of widgets the AI is allowed to build with.

If you're new to `genui` itself, read its own [README](https://pub.dev/packages/genui) first — the concepts below (`Conversation`, `SurfaceController`, `Surface`, `DataModel`) are genui's, not this package's.

## Getting started

Add both packages:

```bash
flutter pub add genui shadcn_flutter_genui
```

Wire up a `Conversation` the same way you would with genui's own `CoreCatalogItems`, but pass `GenCatalog.asCatalog()` as the catalog:

```dart
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

class _MyHomePageState extends State<MyHomePage> {
  late final SurfaceController _controller;
  late final A2uiTransportAdapter _transport;
  late final Conversation _conversation;

  @override
  void initState() {
    super.initState();

    // The only difference from a plain genui setup: use this package's
    // catalog instead of (or merged with) genui's own CoreCatalogItems.
    _controller = SurfaceController(catalogs: [GenCatalog.asCatalog()]);

    _transport = A2uiTransportAdapter(onSend: _onSendToLLM);

    _conversation = Conversation(controller: _controller, transport: _transport);
  }

  Future<void> _onSendToLLM(ChatMessage message) async {
    // Call your LLM of choice and pipe the response stream in.
    final responseStream = myLlmClient.streamGenerateContent(message);
    await for (final chunk in responseStream) {
      _transport.addChunk(chunk);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Render active surfaces with genui's own Surface widget, inside a
    // ShadcnApp so the rendered widgets pick up your shadcn_flutter theme.
    return Surface(host: _conversation.host, surfaceId: mySurfaceId);
  }

  @override
  void dispose() {
    _conversation.dispose();
    _transport.dispose();
    _controller.dispose();
    super.dispose();
  }
}
```

From here, everything is standard genui: `conversation.sendRequest(ChatMessage.user(text))` to talk to the model, `conversation.events` to track surfaces being added/removed, and a `Surface` widget per surface id to render them. The AI now builds with `TextField`, `Checkbox`, `Select`, `Button`, `Form`, and the rest of this package's widgets — styled by whatever `shadcn_flutter` theme your `ShadcnApp` sets up — alongside genui's own basics (`Text`, `Column`, `Row`, ...), which stay available too since `GenCatalog.asCatalog()` merges both.

## Trying it without an LLM

genui ships `DebugCatalogView`, which renders a catalog's built-in example data directly — no model, no network:

```dart
runApp(ShadcnApp(home: DebugCatalogView(catalog: GenCatalog.asCatalog())));
```

Useful for sanity-checking that the catalog itself (and any widgets you've added to it) renders correctly before wiring up a real conversation.

## Widgets in the catalog

`TextField`, `TextArea`, `CheckBox`, `Switch`, `Select`, `RadioGroup`, `Slider`, `DatePicker`, `Button`, `Card`, `Alert`, `Badge`, `Avatar`, `Progress`, `Accordion`, `Tabs`, `Form`, `FormFieldError` — plus `Text`/`Column`/`Row`/etc. from genui's own basics.

Value-bearing widgets (`TextField`, `Checkbox`, `Select`, ...) participate in a real `shadcn_flutter` `Form` when one is present — either one the AI composes with the `Form` widget, or one your app wraps around a whole `Surface`. `Form`'s `onSubmit` only fires once every field passes validation; a nested `Button` reaches it via a `submitForm` action.

## Giving the AI custom capabilities

Beyond widgets, you can register your own non-UI operations the AI can call directly (or a widget can trigger from an action):

```dart
class SetVolumeFunction extends GenSystemFunction {
  late GenDataField<double> level;

  @override
  String get name => 'setVolume';
  @override
  String get description => 'Sets the system output volume, from 0.0 to 1.0.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {
    level = descriptor.decimal('level', label: 'Volume level (0.0-1.0)');
  }
  @override
  Future<Object?> invoke([BuildContext? context]) async {
    await MyVolumeApi.setVolume(level.value);
    return null;
  }
}

_controller = SurfaceController(
  catalogs: [GenCatalog.asCatalog(systemFunctions: [SetVolumeFunction()])],
);
```

`GenFunctions` also ships a small built-in library of arithmetic/string/boolean helpers (`add`, `round`, `concat`, `trim`, `xor`, ...), always available to the AI alongside anything you register.

## Extending the catalog with your own widgets

Everything above is enough for most apps. If you want to add a widget of your own to the catalog — one styled with `shadcn_flutter`, following the same conventions as the ones this package ships — see below.

Each widget is a `GenSchema`: it declares its AI-fillable fields once in `describeFields`, then reads/writes them by name in `buildWidget`.

```dart
class GenButtonSchema extends GenSchema {
  late final GenField<Widget> child;
  late final GenField<GenActionDispatcher?> onPressed;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    child = descriptor.widget(
      'child',
      label: 'Button content',
      example: TextSchema.new.withExample((s) => s.text.example = 'Press me'),
    );
    onPressed = descriptor.optionalAction(
      'onPressed',
      label: 'Triggered when the button is pressed',
      example: const EventExample('pressed'),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Button.primary(
      onPressed: onPressed[context].toVoidCallback(context),
      child: child[context],
    );
  }
}

const genButton = GenCatalogItem(name: 'Button', label: 'Button', schema: GenButtonSchema.new);

// Merge it into the catalog alongside this package's own widgets:
_controller = SurfaceController(
  catalogs: [GenCatalog.asCatalog().copyWith(newItems: [genButton.asCatalogItem])],
);
```

Every field gets an `example:` — there's no hand-typed JSON `exampleData` anywhere in this DSL. Each widget's example is generated entirely from its fields' own declarations.

### Field types

`GenFieldDescriptor` (passed into `describeFields`) covers:

| Method | Value type |
|---|---|
| `string` / `optionalString` | `String` |
| `boolean` / `optionalBoolean` | `bool` |
| `integer` / `optionalInteger` | `int` |
| `decimal` / `optionalDecimal` | `double` |
| `enumerated<T>` / `optionalEnumerated<T>` | a Dart `enum` |
| `list` / `optionalList`, `set` / `optionalSet`, `map` / `optionalMap` | collections of another field |
| `widget` / `optionalWidget` | a single child component, by id |
| `widgetList` | a list of child components, by id |
| `object<T extends GenObject>` | a nested, reusable data shape |
| `action` / `optionalAction` | fully AI-controlled interaction (see below) |
| `valueAction` / `optionalValueAction` | an action with exactly one typed parameter |
| `validators<T>` | AI-selectable validation rules |

`GenObject` lets you declare a reusable nested shape (e.g. `{title, body}`) whose own fields are described via `GenDataFieldDescriptor` — the same field-kind vocabulary, minus `action`/`widget`, since a `GenObject` has no `BuildContext` of its own.

### Actions are fully AI-controlled

There's no schema-author-hardcoded "default" behavior for interactions. A field declared via `action`/`optionalAction` resolves, at runtime, to whatever the AI's JSON configured: doing nothing, notifying the AI (`event`), calling a registered `GenSystemFunction` (`functionCall`), writing to the data model (`setValue`), storing a temporary variable (`setVar`), composing several steps (`sequence`), branching (`conditional`), catching errors (`try`), firing-and-forgetting (`async`), or submitting the ambient `Form` (`submitForm`).

For the common case — a callback that hands the AI exactly one new value (`onChanged`, `onSubmitted`, ...) — use `valueAction`/`optionalValueAction`:

```dart
static const newValueParam = GenStringParameter('value', description: 'The new text');

onChanged = descriptor.optionalValueAction<String>(
  'onChanged',
  label: 'Triggered on every keystroke',
  parameter: newValueParam,
  example: const SetValueExample('root.value', {'var': 'value'}),
);

// buildWidget:
onChanged: onChanged[context].toValueCallback(context),
```

`GenActionParameter<T>` ships typed subclasses (`GenStringParameter`, `GenBoolParameter`, `GenIntParameter`, `GenDecimalParameter`, `GenDateTimeParameter`, `GenOptionalStringParameter`) and is itself extensible. Use `.map<N>(...)` when a widget's native callback value (e.g. `SliderValue`, `CheckboxState`) needs projecting to the parameter's own type first.

### Validation

A field never renders its own error text — that's not an individual widget's concern. Instead, `descriptor.validators<T>(fieldName, available: [...])` lets the AI attach a JSON-selectable list of `GenValidator<T>` kinds (`GenNotEmptyValidator`, `GenLengthValidator`, `GenRegexValidator`, `GenEmailValidator`, `GenUrlValidator`, `GenRangeValidator<T>`, `GenNonNullValidator<T>`), each backed by a real `shadcn_flutter` `Validator` and composed with AND semantics; `wrapFormEntry` registers the field with whatever ambient `Form` exists. `FormFieldError` is a separate, AI-placed catalog item that shows another field's live error by id.
