## [0.0.54]
### Added
- Requires Flutter 3.47.0 (Dart 3.13.0) or newer, matching `shadcn_flutter`.
- Initial release, split out of `shadcn_flutter` when that package dropped its
  Cupertino dependency.
- `CupertinoShadcnApp`, a drop-in replacement for `ShadcnApp` that registers the
  Cupertino localizations and installs the `CupertinoTheme` ancestor.
- `CupertinoLayer`, the same theme for a single subtree, plus
  `cupertinoThemeFor` and `kCupertinoLocalizationsDelegates`.
- `buildCupertinoEditableTextContextMenu` and
  `buildCupertinoSpellCheckSuggestionsToolbar`, replacing
  `TextField.cupertinoContextMenuBuilder()`.
- Re-exports of `CupertinoIcons`, `CupertinoPage`, `CupertinoPageRoute` and the
  Cupertino text selection controls that `shadcn_flutter` used to re-export.
