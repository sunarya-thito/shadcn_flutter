## Unreleased

This release moves the catalog from `genui` to the A2UI Dart SDKs,
`a2ui_core` and `a2ui_flutter`, which replace `genui`. It is breaking. Agents
keep speaking A2UI v0.9.

* Replaced the `genui` dependency with `a2ui_core` and `a2ui_flutter`. Render
  surfaces with `MessageProcessor` and `A2uiSurface` instead of
  `SurfaceController` and `Surface`, and prompt a model with `a2ui_agent`
  instead of `PromptBuilder`.
* Changed the `GenCatalog` components from genui `CatalogItem`s to
  `ComponentImplementation`s. `asCatalog` now returns a
  `CatalogImplementation`, takes `ComponentImplementation` items and
  `FunctionImplementation` functions, and puts `systemPromptFragments` in the
  catalog's instructions. An item with the name of a built-in component
  replaces it.
* Added `locale` and `openUrl` arguments to `asCatalog` for the basic
  functions. An `openUrl` call fails unless the app passes a callback.
* Added `GenCatalog.asCatalogs`, which returns the catalog under its own ID and
  under each standard basic catalog ID. The catalog from `asCatalog` no longer
  accepts the basic catalog IDs, since an A2UI catalog has a single ID.
* Switched the basic components to the A2UI v0.9 basic catalog schemas, as they
  used genui's before. `Tabs` takes `tabs[].title` and `tabs[].child` instead of
  `label` and `content`, and keeps the selected tab itself instead of binding
  `activeTab`. `DateTimeInput` takes `enableDate` and `enableTime` instead of
  `variant`. `TextField` requires `label` and no longer takes
  `onSubmittedAction`, `Slider` requires `max`, and `ChoicePicker` takes its
  `options` as a list rather than a data binding.
* Made inputs whose value is a literal read-only. genui wrote their edits to an
  implicit `<id>.value` path, which A2UI does not have. A `TextField` still
  keeps the edit in the field.
* Declared `closeModal` as a catalog function, since A2UI rejects calls to
  functions a catalog does not declare. It still closes the `Modal` around the
  button.
* Declared `weight` and `accessibility` on `Switch` and `Progress`. A2UI rejects
  properties a component does not declare, where genui accepted any.
* Updated the example and documentation to use the A2UI SDKs.

## 0.0.2

This release replaces the experimental custom schema and action system with a
standard A2UI catalog. It is intentionally breaking while the package is still
in alpha.

* Added shadcn renderers for the complete no-asset A2UI basic component set,
  plus `Switch` and `Progress` extensions.
* Made input values real two-way GenUI DataModel bindings. Text fields,
  checkboxes, choice pickers, sliders, date inputs, switches, and tabs now
  update their declared paths without model-authored synchronization actions.
* Switched buttons and text submission to standard A2UI `event` and
  `functionCall` actions.
* Added a stable catalog ID with aliases for the standard A2UI basic catalog
  IDs.
* Removed the hidden Material theme and localization requirement.
* Fixed text fields so remote DataModel updates refresh their controllers
  without echoing a second local edit.
* Removed the package-specific `GenSchema`, `GenField`, validator, form, and
  action DSL APIs. Custom additions should now use GenUI's `CatalogItem` and
  `ClientFunction` APIs directly.
* Updated the example and documentation to use the current GenUI surface API.

## 0.0.1

* Added the initial experimental shadcn_flutter GenUI catalog.
