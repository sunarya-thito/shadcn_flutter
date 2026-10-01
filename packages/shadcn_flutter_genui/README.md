# shadcn_flutter_genui

An A2UI catalog for [`genui`](https://pub.dev/packages/genui) that renders
generated interfaces with `shadcn_flutter`.

This package does not replace GenUI's runtime. `Conversation`,
`SurfaceController`, `Surface`, transport, validation, and the DataModel still
come from `genui`. This package supplies a protocol-compatible component
catalog and its shadcn renderers.

## Setup

```bash
flutter pub add genui shadcn_flutter_genui
```

Create one catalog and give it to the controller and prompt builder:

```dart
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

final catalog = GenCatalog.asCatalog();
final controller = SurfaceController(catalogs: [catalog]);

final prompt = PromptBuilder.custom(
  catalog: catalog,
  allowedOperations: SurfaceOperations.createAndUpdate(dataModel: true),
).systemPromptJoined();
```

Render a surface inside `ShadcnApp`:

```dart
ShadcnApp(
  home: Surface(
    surfaceContext: controller.contextFor(surfaceId),
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
`DateTimeInput`, `Tabs`, and the shadcn extension `Switch`. Do not generate an
`onChanged` action just to keep an input synchronized.

Buttons and submitted text fields use standard A2UI actions:

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

`functionCall` actions are also supported and resolve through the GenUI client
function registry.

## Components

The catalog implements the no-asset A2UI basic surface:

- `Button`, `Card`, `CheckBox`, `ChoicePicker`
- `Column`, `Row`, `List`
- `DateTimeInput`, `Slider`, `Tabs`, `TextField`
- `Divider`, `Icon`, `Modal`, `Text`

It also includes `Switch` and `Progress` shadcn extensions. `TextField`'s
`variant` supports `shortText`, `longText`, `number`, and `obscured`.

The canonical catalog ID is `dev.shadcn_flutter.genui`. The standard A2UI basic
catalog IDs are accepted as aliases for interoperability.

## Adding app-specific components and functions

Use GenUI's regular `CatalogItem` and `ClientFunction` APIs. Additional client
functions can be included directly:

```dart
final catalog = GenCatalog.asCatalog(
  items: [myCatalogItem],
  functions: [myClientFunction],
  systemPromptFragments: [
    'Use save_profile only after the user reviews the form.',
  ],
);
```

Create app-specific components with GenUI's standard `CatalogItem` API and pass
them through `items`. There is intentionally no second schema or action DSL in
this package: using GenUI's public A2UI types keeps custom components
interoperable with the rest of the ecosystem.

See the included OpenRouter chat example for complete transport,
`Conversation`, prompt, and surface wiring.
