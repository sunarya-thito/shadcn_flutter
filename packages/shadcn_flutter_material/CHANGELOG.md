## [0.0.54]
### Added
- Requires Flutter 3.47.0 (Dart 3.13.0) or newer, matching `shadcn_flutter`.
- Initial release, split out of `shadcn_flutter` when that package dropped its
  Material dependency.
- `MaterialShadcnApp`, a drop-in replacement for `ShadcnApp` that registers the
  Material localizations and installs the Material theme, `Material` and
  `ScaffoldMessenger` ancestors.
- `MaterialLayer`, the same ancestors for a single subtree, plus
  `materialThemeFor` and `kMaterialLocalizationsDelegates`.
- `buildAdaptiveEditableTextContextMenu`,
  `buildMaterialEditableTextContextMenu` and
  `buildMaterialSpellCheckSuggestionsToolbar`, replacing
  `TextField.nativeContextMenuBuilder()` and
  `TextField.materialContextMenuBuilder()`.
- Re-exports of `Icons`, `MaterialPage`, `MaterialPageRoute` and `SliverAppBar`,
  which `shadcn_flutter` used to re-export itself.
