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
