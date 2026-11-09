# shadcn_flutter_genui

An A2UI catalog for [`a2ui_flutter`](https://pub.dev/packages/a2ui_flutter)
that renders generated interfaces with `shadcn_flutter`.

This package does not replace the A2UI runtime. `MessageProcessor`,
`A2uiSurface`, validation, and the data model still come from
[`a2ui_core`](https://pub.dev/packages/a2ui_core) and `a2ui_flutter`, and
prompting a model comes from [`a2ui_agent`](https://pub.dev/packages/a2ui_agent).
This package supplies a protocol-compatible component catalog and its shadcn
renderers.

## Setup

```bash
flutter pub add a2ui_core a2ui_flutter shadcn_flutter_genui
```

Create one catalog and give it to the message processor:

```dart
import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

final catalog = GenCatalog.asCatalog();
final processor = MessageProcessor<ComponentImplementation>(
  catalogs: [catalog],
  validationConfig: ValidationConfig.relaxed,
  reportErrorsOnly: true,
);

// Apply each A2UI message from the agent, as decoded JSON.
processor.processMessages(message);
```

If the app prompts a model itself, build the prompt and read the reply with
`a2ui_agent` (`flutter pub add a2ui_agent`):

```dart
import 'package:a2ui_agent/a2ui_agent.dart';

final agent = A2uiGenerator(
  catalogs: [CatalogConfig(catalog)],
  inferenceFormatFactory: const DirectJsonFormatFactory(
    allowedMessages: ['createSurface', 'updateComponents', 'updateDataModel'],
  ),
).createProcessor(
  A2uiRendererCapabilities.forCatalogIds([
    catalog.id,
  ], version: A2uiProtocolVersion.v0_9),
);

final prompt = agent.promptSnippet;
```

Render a surface inside `ShadcnApp`:

```dart
ShadcnApp(
  home: A2uiSurface(
    surface: processor.model.getSurface(surfaceId)!,
  ),
)
```

No Material theme or localization wrapper is required by the catalog.

## Data binding

Inputs use normal A2UI two-way DataModel bindings. The model declares the
path; the widget reads it and writes user edits back automatically:

```json
{
  "id": "name",
  "component": "TextField",
  "label": "Name",
  "value": {"path": "/profile/name"}
}
```

The same rule applies to `CheckBox`, `ChoicePicker`, `Slider`,
`DateTimeInput`, and the shadcn extension `Switch`. Do not generate an
`onChanged` action just to keep an input synchronized. An input whose value is
a literal has no path to write to, so it is read-only, except a `TextField`,
which keeps the edit in the field.

Buttons use standard A2UI actions:

```json
{
  "id": "save",
  "component": "Button",
  "child": "saveLabel",
  "action": {
    "event": {
      "name": "save_profile",
      "context": {"name": {"path": "/profile/name"}}
    }
  }
}
```

`functionCall` actions are also supported and run the catalog's functions. A
`closeModal` call closes the `Modal` around the button.

## Components

The catalog implements the no-asset A2UI basic surface:

- `Button`, `Card`, `CheckBox`, `ChoicePicker`
- `Column`, `Row`, `List`
- `DateTimeInput`, `Slider`, `Tabs`, `TextField`
- `Divider`, `Icon`, `Modal`, `Text`

It also includes `Switch` and `Progress` shadcn extensions. `TextField`'s
`variant` supports `shortText`, `longText`, `number`, and `obscured`.

The canonical catalog ID is `dev.shadcn_flutter.genui`. For interoperability
with agents that address the standard A2UI basic catalog, `asCatalogs()`
returns the catalog under the canonical ID and under each basic catalog ID:

```dart
final processor = MessageProcessor<ComponentImplementation>(
  catalogs: GenCatalog.asCatalogs(),
);
```

## Adding app-specific components and functions

Use the A2UI SDK's regular `ComponentImplementation` and
`FunctionImplementation` APIs. Additional functions can be included directly:

```dart
final catalog = GenCatalog.asCatalog(
  items: [myComponent],
  functions: [myFunction],
  systemPromptFragments: [
    'Use save_profile only after the user reviews the form.',
  ],
);
```

Create app-specific components with `a2ui_flutter`'s standard
`ComponentImplementation` API and pass them through `items`; a component with
the name of a built-in one replaces it. There is intentionally no second schema
or action DSL in this package: using the A2UI SDK's public types keeps custom
components interoperable with the rest of the ecosystem.

The basic `openUrl` function fails unless the app passes a callback, such as
`openUrl: launchUrl` from `url_launcher`. `locale` sets the locale of the
formatting functions, `en-US` by default.

See the included OpenRouter chat example for complete model, prompt, and
surface wiring.
