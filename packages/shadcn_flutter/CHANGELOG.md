## [0.0.54]
### Breaking
- Minimum Flutter is now 3.47.0 (Dart 3.13.0), up from 3.32.3 (Dart 3.6.0).
  `ShadcnPreview` builds on `package:flutter/widget_previews.dart`, whose
  `Preview` API only settled in 3.47.0, and this is the version the package is
  built and tested against.
- **shadcn_flutter no longer depends on Material or Cupertino.** The package now
  imports `package:flutter/widgets.dart` only, following Flutter's move of those
  libraries into the `material_ui` and `cupertino_ui` packages. Two companion
  packages provide interop: `shadcn_flutter_material` and
  `shadcn_flutter_cupertino`.
- Removed the Material and Cupertino re-exports: `Icons`, `MaterialPageRoute`,
  `MaterialPage`, `SliverAppBar`, `FlutterLogo` (still available from
  `package:flutter/widgets.dart`), `cupertinoDesktopTextSelectionControls` and
  `cupertinoDesktopTextSelectionHandleControls`.
- `ShadcnApp.materialTheme` and `ShadcnApp.cupertinoTheme` removed. Use
  `MaterialShadcnApp.materialTheme` / `CupertinoShadcnApp.cupertinoTheme`, or
  pass a theme to `MaterialLayer` / `CupertinoLayer` directly.
- `ShadcnApp.debugShowMaterialGrid` renamed to `ShadcnApp.debugShowGrid`; it
  draws the same `GridPaper`, which was never Material-specific.
- `ShadcnApp` no longer installs `Material`, `ScaffoldMessenger`, `Theme`
  (Material) or `CupertinoTheme` ancestors, nor the `DefaultMaterialLocalizations`
  and `DefaultCupertinoLocalizations` delegates. Material and Cupertino widgets
  placed under a bare `ShadcnApp` will now assert; wrap them in a
  `MaterialLayer` / `CupertinoLayer`, or use `MaterialShadcnApp` /
  `CupertinoShadcnApp`.
- Removed `TextField.nativeContextMenuBuilder()`,
  `TextField.materialContextMenuBuilder()` and
  `TextField.cupertinoContextMenuBuilder()`. Their replacements are the
  top-level `buildAdaptiveEditableTextContextMenu` and
  `buildMaterialEditableTextContextMenu` in `shadcn_flutter_material`, and
  `buildCupertinoEditableTextContextMenu` in `shadcn_flutter_cupertino`.
- Removed `SelectableText.useNativeContextMenu`. Pass `contextMenuBuilder`
  directly instead.
- Dropped the `cross_file` dependency and the `XFile` re-export that came with
  it; nothing in the package used it. Depend on `cross_file` directly if you
  were importing `XFile` through `package:shadcn_flutter`.
- `uses-material-design` is no longer set by this package, so the MaterialIcons
  font is not bundled unless your own app sets it. Apps created by
  `flutter create` already set it to true. Leave it on if you use
  `shadcn_flutter_material`, or if you use `CountryFlag`, which falls back to a
  MaterialIcons glyph for unrecognized country codes.

### Added
- `ShadcnPageRoute` and `ShadcnPage`, Material-free replacements for
  `MaterialPageRoute` and `MaterialPage`. `ShadcnPageRoute` is the default route
  type `ShadcnApp` builds for `routes` and `home`.
- `shadcnTextSelectionHandleControls`, the handle-less `TextSelectionControls`
  used by text inputs by default. Selection toolbars continue to come from
  `buildEditableTextContextMenu`.
- `SpellCheckSuggestionsToolbar`, a shadcn styled replacement for the Material
  and Cupertino spell check toolbars, and the new default for `TextField`.
- `ShadcnLocalizations.noSpellCheckReplacements`.
- **[#424] Table**: `Table.textDirection` and `ResizableTable.textDirection`,
  defaulting to the ambient `Directionality`. Column indices stay logical, so
  `columnWidths` key 0 and `FrozenTableData.frozenColumns` index 0 still mean
  the first column; under RTL it is laid out at the right edge, frozen columns
  pin there, horizontal scrolling starts there and runs leftwards, and the
  column resize handles mirror along with their drag direction.
- **[#423] Select**: `Select.decoration`, `MultiSelect.decoration` and
  `SelectTheme.decoration`, a `WidgetStatePropertyDelegate<Decoration>` that
  overrides the trigger's decoration per `WidgetState`. One delegate covers
  border color, focused border color, background color and hover color without
  reaching for a `Theme` scope around the whole subtree. Applied after
  `borderRadius`, so it can override that too.
- **[#422] Select**: `SelectPopup.builder()` now takes `shrinkWrap`, for parity
  with `SelectPopup()`, so a popup whose delegate mixes items with a trailing
  action sizes to its content.
- **[#422] Select**: `SelectPopupHandle.close()`, letting a widget inside the
  popup dismiss it on its own terms rather than only as a side effect of
  `onChanged` firing.
- `WidgetStatePropertyResolver` and `WidgetStatePropertyDelegate`, the
  component-agnostic names for what were `ButtonStateProperty` and
  `ButtonStatePropertyDelegate`. The `Button*` names remain as aliases.
- `Positioned.directional`, which the patched `Positioned` was missing relative
  to Flutter's.
- `lerpColorPremultiplied`, an alpha-correct alternative to `Color.lerp` for
  blending two colors that differ in opacity.
- Documentation page for localizations, covering setup, overriding strings,
  adding a locale, the formatting helpers and right-to-left layouts.

### Changed
- `RenderScrollableClientViewport` takes `scrollCacheExtent`
  (`ScrollCacheExtent?`) instead of the `cacheExtent` (`double?`) that
  Flutter deprecated after 3.41.0.
- Documented the remaining undocumented public members in `ChatReaction`,
  `ChatReactionTheme`, `ChatReactionContainer`, `ChatCollapsible`,
  `FocusToFront`, `ExpandedFocusToFront`, `FlexibleFocusToFront`,
  `DialogOverlayContent`, `buildShadcnDialogTransitions`, `DynamicFormKey`
  and the `darken`/`lighten` color extensions.
- Removed the deprecated `synthetic-package` key from `l10n.yaml`; leaving it
  in made `flutter pub get` delete the generated localization sources.
- `CircularProgressIndicator` now paints its arc directly instead of wrapping
  Material's. Both determinate and indeterminate modes keep the same timing;
  stroke caps are round in both modes.
- `SelectableText` is now implemented in this package on top of `EditableText`
  rather than wrapping Material's `SelectableText`. Cursor and selection colors
  come from the shadcn theme and `SelectableTextTheme`.
- Component icons that used Material's `Icons` now use the bundled
  `LucideIcons` set: `ColorPicker`, `TimePicker`, `Accordion`, `Collapsible`,
  `Stepper`, `Tree`, `Window` and `RefreshTrigger`.
- `builder` now lives in the `showOverlay` method signature instead of `OverlayConfiguration`.
- Overlay components (e.g., `Select`, `AutoComplete`, `ObjectFormField`, `FormattedObjectInput`, `showItemPicker`, `NavigationMenu`, `Tooltip`, `InstantTooltip`, and `HoverCard`) now have been migrated to use `OverlayConfiguration` instead of `OverlayHandler`.
- `ShadcnApp` and `ShadcnLayer` no longer take `popooverHandler`/`tooltipHandler`/`menuHandler`.
- `adaptiveOverlay` is now set to false.
- Removed `OverlayHandler`, `OverlayManager`, `OverlayManagerLayer`, and `*OverlayHandler` from internal use.
- `bool? adaptiveOverlay` and `OverlayConfiguration? overlayConfiguration` now lives in overlay component's component themes.
- `DrawerContainer.intrinsic` and `DrawerContainer.expands` is moved to `PinnedSheet.contentExpands` and `DrawerContainer.contentIntrinsic`
- `HSVColorSliderPainter` and `HSLColorSliderPainter` now paint with layered
  gradients instead of one filled rect per sampled step. Output is unchanged
  apart from being exact rather than quantised to 100 or 360 steps.

### Fixed
- **[#420] DatePicker**: Calendar navigation arrow icons now flip to match RTL
  layouts instead of always pointing left/right.
- **Button**: state transitions that changed a fill's opacity darkened on the
  way through. `Decoration.lerp` blends with `Color.lerp`, which interpolates
  the channels as stored, so the near-transparent end still contributed its
  full RGB to the midpoint — fading an opaque surface out to a faint tint
  passed through a solid mid-grey. Fills now interpolate premultiplied, via the
  new `lerpColorPremultiplied`.
- **Form**: `InputFeature.revalidate()` cleared the error instead of rechecking
  it. `FormFieldHandle.revalidate` passed the field's internal cache wrapper
  where the value itself was expected, so validators ran against an opaque
  object and reported success — and the wrapper was stored as the field's value.
- **Form**: comparing two validators of the same generic type threw a
  `TypeError`. `ConditionalValidator`, `NotValidator`, `OrValidator` and
  `CompositeValidator` tested `other is ConditionalValidator` against the raw
  type, so reading a `T`-typed member off it forced a downcast to the `dynamic`
  instantiation that a predicate taking `T?` cannot satisfy.
- **[#414] DatePicker**: the month/year header was pinned to a fixed height
  derived from the default density's padding, so at reduced or spacious density
  the label was silently clipped. The height is now a floor rather than a fixed
  value, leaving the default appearance unchanged and growing only where the
  label would not otherwise fit.
- **[#419] PinnedSheet**: Nested sheets on different drag axes (e.g. a
  horizontal `SideSheet` inside a vertical `BottomSheet`) no longer leak
  leftover drag delta into the parent sheet's own axis; the drag chain now
  only propagates between sheets that share the same drag axis.
- Fixed PinnedSheet not immediately layout the sheet.
- **ColorPicker**: the saturation/value field and the color sliders were drawn
  as up to 36,000 individual rects per frame, which Impeller renders far more
  slowly than Skia did, and whose fractional edges no longer snapped to the
  pixel grid — leaving pale seams across the field in a grid pattern. They are
  now a handful of gradient draws with no seams.
- **ColorPicker**: picking a color from the screen could take the app down.
  `EyeDropperLayer` wraps the whole application and expanded the entire window
  screenshot into a `List<Color>` — one object per pixel, so several million on
  a large display. It now reads the captured bytes directly.
- **ColorPicker**: sampling a pixel on the trailing edge of the screen threw a
  `RangeError`; positions are now clamped to the snapshot.
- **ColorPicker**: a screenshot that failed to capture still started a picking
  session, leaving the application unresponsive behind an `IgnorePointer` with
  no way to dismiss it. Failures now abort the session, and <kbd>Esc</kbd>
  cancels an active one.
- **ColorPicker**: the eye dropper leaked the captured `ui.Image` and decoded
  the screenshot a second time to display it.
- **ColorPicker**: eye dropper samples were read from premultiplied bytes as if
  they were straight, tinting colors picked from translucent pixels.
- **ColorPicker**: the `satAlpha`, `valAlpha` and `hueAlpha` sliders did not
  repaint for every channel they hold constant, so their gradients could go
  stale.
- `ScrollableClient` never updated its viewport render object, because
  `ScrollableClientViewport` supplied no `updateRenderObject` and inherited the
  empty default. The render object kept the delegate, scroll offsets and axis
  directions it was first created with, so `ScrollableClient.builder` was
  frozen at its first closure: content built from state that later changed
  never updated, and `overscroll`, `clipBehavior` and `reverse` could not be
  changed after the first build.

## [0.0.53]

### Added

- **Generalized Key-based Anchoring System**: Introduced `OverlayAnchor` and a
  global registry `OverlayAnchorRegistry` to support anchoring overlays
  (Popovers, Drawers, Sheets, etc.) using `Symbol` keys.
- **Support for optional anchor keys**: Added `anchor` parameter (`Symbol?`) to:
  - `showPopover` and `PopoverController.show`
  - `openDrawer`, `openSheet`, `openRawDrawer`, `openDrawerOverlay`, and
    `openSheetOverlay` This eliminates the need to use `Builder` widgets to wrap
    trigger components just to obtain a nested `BuildContext` for
    `findRenderObject()`.
- **[#271] PinnedSheet component**: A new sheet variant that stays pinned to its
  anchor.
- **`shadcn_flutter_genui` package**: Added a new companion package to the
  monorepo.
- Added `DecoratedChipClipboardHandler` and improved `ChipInput` clipboard
  handling.
- Added focus-based paint ordering on the text field and its input features.

### Changed

- Deprecated direct `BuildContext context` parameter across all overlay/popup
  functions (such as `showPopover`, `openDrawer`, `openSheet`, etc.) in favor of
  `anchor` (`Symbol?`).
- Simplified PhoneInput component. Dial code is now mandatory and
  filterPlusCode, filterZeroCode, and filterCountryCode are now marked as
  deprecated.
- **Renamed `TreeView` to `Tree`** (breaking): update usages of `TreeView` and
  related APIs to the new `Tree` name.
- **[#367] Migrated to the new Overlay system**: Overlays now use the reworked
  overlay implementation.
- Made `paintOrder` nullable.
- Improved `InputOTP` border and paint order.

### Fixed

- **[#403] Fix decimal input bug**: Resolved `_DoubleOnlyFormatter` not
  accepting `0.00N` input cases (PR #403 by @petertle22).
- **[#404] Clickable morphing decoration**: Ensured the `Clickable` decoration
  morphs smoothly when transitioning between shape/border-radius changes.
- Cleaned up redundant and deprecated `Builder` widget usages in documentation,
  main examples, and sub-components.
- **[#415]** Fixed inconsistent InputFeature text setting.
- **[#411]** Fixed `Sortable` losing/incorrectly tracking its state, and fixed
  the sortable example.
- **[#417]** Fixed `Divider` rendering inside a vertically-unbounded parent.
- Fixed `Stepper` line alignment.
- Fixed paint order for `ButtonGroup`.
- Fixed paint order for input features.
- Fixed `AutoComplete` overlay behavior.
- Fixed popover positioning.

## [0.0.52]

### Fixed

- [#400] Fixed DatePicker resetting its view back to the current month after
  selecting a date in another month.

## [0.0.51]

### Fixed

- Fixed ControlledComponent assertion error when no initial value is provided
  despite having a nullable type parameter
- Fixed NavigationGroup causing negative size errors when the children list is
  empty
- Fixed NavigationSidebar not working correctly after recent breaking changes

### Changed

- NavigationWidget is now a builder-only widget that requires a builder function
  to be provided.

## [0.0.50]

### Added

- Add min/max limits to increment/decrement input buttons and disable at bounds

### Fixed

- Fixed clip behavior in Dialog overlay widget
- Removed haptic on iOS

### Breaking Changes

- [BREAKING] Navigation selection model changed from index-based (`int`) to
  key-based (`Key?`) across `NavigationBar`, `NavigationRail`, and
  `NavigationSidebar` (commits 53d2d8c3, 8d3104a9, 9ef28a81)
  - `index` parameter removed; use `selectedKey` instead
  - `onSelected` callback signature changed from `ValueChanged<int>?` to
    `ValueChanged<Key?>?`
  - `NavigationItem.index` parameter removed; use the widget's `key` for
    selection identity
- [BREAKING] `NavigationBarItem` abstract class removed; children parameters now
  accept `List<Widget>` instead of `List<NavigationBarItem>`
- [BREAKING] `NavigationContainerMixin` (and its `wrapChildren` method) removed
- [BREAKING] `NavigationChildControlData` and `NavigationGroupControlData`
  classes removed
- [BREAKING] `NavigationBar.constraints` parameter removed; use `expandedSize`
  and `collapsedSize` instead
- [BREAKING] Several `NavigationBar` parameters changed from nullable with theme
  fallback to non-nullable with explicit defaults:
  - `alignment` (`NavigationBarAlignment?` → `NavigationBarAlignment`, default:
    `start`)
  - `labelType` (`NavigationLabelType?` → `NavigationLabelType`, default: `all`)
  - `labelPosition` (`NavigationLabelPosition?` → `NavigationLabelPosition`,
    default: `bottom`)
  - `labelSize` (`NavigationLabelSize?` → `NavigationLabelSize`, default:
    `small`)
  - `expanded` (`bool?` → `bool`, default: `false`)
- [BREAKING] `NavigationBar.expands` parameter removed
- [BREAKING] `NavigationGap`, `NavigationDivider`, `NavigationLabel`, and
  `NavigationWidget` no longer implement `NavigationBarItem`

Migration guide:

1. Replace `index` / `onSelected` with `selectedKey` / key-based callback.

```dart
// before
NavigationBar(
  index: selectedIndex,
  onSelected: (index) => setState(() => selectedIndex = index),
  children: [
    NavigationItem(label: Text('Home'), child: Icon(Icons.home)),
    NavigationItem(label: Text('Search'), child: Icon(Icons.search)),
  ],
)

// after
NavigationBar(
  selectedKey: selectedKey,
  onSelected: (key) => setState(() => selectedKey = key),
  children: [
    NavigationItem(key: ValueKey('home'), label: Text('Home'), child: Icon(Icons.home)),
    NavigationItem(key: ValueKey('search'), label: Text('Search'), child: Icon(Icons.search)),
  ],
)
```

2. Remove any `NavigationBarItem` type annotations; use `Widget` instead.
3. Remove any usage of `NavigationContainerMixin`, `NavigationChildControlData`,
   or `NavigationGroupControlData`.
4. Replace `NavigationBar(constraints: ...)` with `expandedSize` /
   `collapsedSize`.

## [0.0.49]

- Fixed clip behavior in paint order patched layout widgets (Flex, Row, Column,
  Stack)
- Added TextFlipper widget (part of Number Ticker component)

## [0.0.48]

### Added

- Added Chat component
- New `ColorScheme.of` method to access color scheme from theme data
- [#346] Added param to skip focus traversal in Input features
- [PREVIEW] Added `ShadcnPreview` and `ShadcnMultiPreview` annotation to preview
  widgets during development
- Add density system and density-aware padding helpers (`Density`,
  `EdgeInsetsDensity`)
- Add paint-order support for `Flex`, `Row`, `Column`, and `Stack` with
  `PaintOrder` and `Positioned.paintOrder`
- Add `InputStepperButtonFeature` and support for
  `InputFeaturePosition.above`/`below`
- Add `Divider.childAlignment` to align divider content
- Add `Widget.sized(size:)` convenience overload
- Add `FadedScrollableViewport` helper for scroll fade masks
- [#371] Create a new page to explain GoRouter integration (by @xdidx)

### Breaking Changes

- Remove sidebar-specific color tokens from `ColorScheme`
- [BREAKING] `RepeatMode` has been renamed to `LoopingMode`
- [BREAKING] `ShadcnLocalizationsDelegate.delegate` has been renamed to
  `ShadcnLocalizations.delegate`

Migration guide:

1. Remove usages of `ColorScheme.sidebar`, `sidebarForeground`,
   `sidebarPrimary`, `sidebarPrimaryForeground`, `sidebarAccent`,
   `sidebarAccentForeground`, `sidebarBorder`, and `sidebarRing`.
2. Replace them with existing tokens (for example, `background`, `card`, or
   `accent`) or create a custom theme extension if you still need
   sidebar-specific colors.

```dart
// before
final colors = Theme.of(context).colorScheme;
final bg = colors.sidebar;

// after
final colors = Theme.of(context).colorScheme;
final bg = colors.background; // or a custom ThemeExtension
```

### Changed

- Integrate density-aware spacing and padding into core layout widgets and form
  controls
- Extend density-aware spacing defaults across navigation, menus, overlays, and
  display components
- Align remaining layout and form spacing with density defaults
- Revamp the theme docs page with a kitchen-sink preview and right-side options
  panel

### Fixed

- Complete `ColorSchemeRecolorExtension` palette getters

- [#380] Fixed issue with DatePicker when using PromptMode.popover
- [#379] Fixed issue with intrinsic row height in Table component
- [#378] Fixed issue with RepeatMode declaration in flutter master channel
- [#373] Scaffold: Set height constraints to correctly measure header size (by
  @xdidx)
- [#394] Fixes ButtonStyle.withPadding by removing shadowed variable (by
  @craiglabenz)

## 0.0.47

- Bug fixes
  - Brought back color picker history panel
  - Fixed color input button without label not showing
  - Color picker popover now invokes onChanged after popover closed
  - Color picker eye dropper now closes popover when eye dropping and then
    reopened back when done

## 0.0.46

- Breaking changes
  - Color picker refactor and file layout
    - Most color picker code moved from a single
      `lib/src/components/form/color_picker.dart` into multiple focused files
      under `lib/src/components/form/color/solid/`.
    - If you were deep-importing internals, update your imports to the new
      paths. Importing via the main barrel
      (`package:shadcn_flutter/shadcn_flutter.dart`) continues to work but the
      old internal path is removed.
  - API renames (ColorPicker / ColorInput)
    - `allowPickFromScreen` ➜ `enableEyeDropper`
    - `onPickFromScreen` ➜ `onEyeDropperRequested`
    - Add the new callback only when you need to override the built-in prompt
      behavior (popover closes, then eye-dropper starts).
  - Internal widgets/classes
    - `HSVColorPickerArea` / `HSLColorPickerArea` replaced by exported
      `HSVColorSlider` / `HSLColorSlider`.
    - Checkerboard painter consolidated as `AlphaPainter` (replaces ad-hoc
      checkboard usage in the old file).
    - Old helper composites like `ColorPickerSet`, `MiniColorPickerSet`, and
      popup/dialog variants were removed in favor of `ColorInput` +
      `ColorPicker` with prompt modes.

- Color system and utilities
  - Reorganized existing color utilities under the new color module; no
    functional changes to `ColorDerivative` or `colorToHex`. Added gradient
    types (linear, radial, sweep) for future composition.

- Color Picker
  - Replaced legacy ColorPicker implementation with a new slider-based picker
    using dedicated HSV/HSL painters and alpha checkerboard. Supports live
    editing via `onChanging`/`onChanged` and consistent display using an
    effective in-progress value.
  - Added modes for RGB, HSV, HSL, and HEX; optional alpha controls;
    horizontal/vertical orientation; spacing and slider size theming via
    `ColorPickerTheme`.

- Color Input
  - New `ColorInput` widget with `ColorInputController` and theming. Integrates
    popover/dialog prompting, optional HEX label display, orientation, and
    EyeDropper integration. `ControlledColorInput` variant for form integration.

- Eye Dropper and History
  - Added screen color picker (`pickColorFromScreen` and `ColorPickingLayer`)
    with magnified preview and label; added `RecentColorsScope` and
    `ColorHistoryGrid` to persist and pick previously sampled colors.

- API exports
  - Public exports updated to include color utilities, ColorPicker, ColorInput,
    EyeDropper, History, and slider widgets.

- i18n and formatting
  - Added `colorPickerTabHEX` localization key and `TextInputFormatters.hex`
    (supports optional hash prefix) for safe HEX input. If you provide a custom
    localization, add this new key.

## 0.0.45

- Breaking changes
  - Removed NumberInput (previously deprecated) and its export. Migrate to
    TextField with InputSpinnerFeature or to FormattedInput depending on your
    use case.

- Inputs
  - TextField: migrated to a stateful base (TextInputStatefulWidget) with richer
    editing model and actions. Leading/trailing properties were removed; use
    InputLeadingFeature/InputTrailingFeature or other InputFeature adornments
    instead. Added groupId, Action.overridable-based intents
    (append/replace/set), AutoCompleteIntent support, better selection defaults,
    defaultContextMenuBuilder, minimum height sizing, and platform fallbacks.
    Clip behavior inside the Editable is now none to avoid content clipping.
  - Input features: all features accept skipFocusTraversal to prevent them from
    being part of focus order when desired.
  - ChipInput (BREAKING): reworked ChipInput with better UX. No longer handles
    suggestion selection internally; use AutoCompleteFeature for suggestions
    instead. Added onChipsChanged callback for external chip state management.
  - OverflowMarquee: curve is now applied correctly to the scroll animation.

- Components
  - Checkbox: add backgroundColor for unchecked state (thanks @fabionuno).
  - Resizable: new optionalDivider that hides dividers until hover/drag; added
    intrinsic size/dry layout computation for better measure/layout behavior.
  - Command: autofocus the first item in the command palette for faster keyboard
    UX (@cbenhagen).
  - Calendar: use min-size rows to fix alignment issues (@andyhorn).
  - Window: normalize WindowWidget constructor defaults for titleBarHeight and
    resizeThickness to avoid incorrect implicit values.

- Theming and platform
  - ThemeData constructors are now const and ShadcnApp provides sensible
    non-null defaults for theme/darkTheme. Added scroll/context-menu fallbacks
    for unknown platforms to avoid runtime issues (e.g., TargetPlatform.ohos).

## 0.0.44

- Fix: Sortable onDragEnd not triggered when the drag failed

## 0.0.43

- Exported FocusOutline

## 0.0.42

- Updated dependencies

## 0.0.41

- Added AnimatedValueBuilder documentation
- Added NumberTicker documentation
- Added RepeatedAnimationBuilder documentation
- Added TimelineAnimation documentation
- Added Button documentation
- Added Accordion documentation
- Added Collapsible documentation
- Added Avatar documentation
- Added AvatarGroup documentation
- Added CodeSnippet documentation
- Added Table documentation
- Added Tracker documentation
- Added Alert documentation
- Added AlertDialog documentation
- Added CircularProgress documentation
- Added Progress documentation
- Added LinearProgress documentation
- Added Skeleton documentation
- Added Toast documentation
- Added AutoComplete documentation
- Added Checkbox documentation
- Added ChipInput documentation
- Added ColorPicker documentation
- Added ControlledCheckbox documentation
- Added ControlledChipInput documentation
- Added ControlledDatePicker documentation
- Added ControlledMultiSelect documentation
- Added ControlledRadioGroup documentation
- Added ControlledSelect documentation
- Added ControlledSlider documentation
- Added ControlledStarRating documentation
- Added ControlledSwitch documentation
- Added ControlledTimePicker documentation
- Added ControlledToggle documentation
- Added DatePicker documentation
- Added DateInput documentation
- Added DurationInput documentation
- Added Form documentation
- Added FormattedInput documentation
- Added InputOTP documentation
- Added ItemPicker documentation
- Added MultiSelect documentation
- Added MultiSelectChip documentation
- Added NumberInput documentation
- Added PhoneInput documentation
- Added RadioCard documentation
- Added RadioGroup documentation
- Added Select documentation
- Added Slider documentation
- Added StarRating documentation
- Added Switch documentation
- Added TextArea documentation
- Added TextInput documentation
- Added TimePicker documentation
- Added TimeInput documentation
- Added Toggle documentation
- Added AppBar documentation
- Added Card documentation
- Added CardImage documentation
- Added Carousel documentation
- Added Divider documentation
- Added Resizable documentation
- Added Scaffold documentation
- Added Sortable documentation
- Added SortableDragHandle documentation
- Added Steps documentation
- Added Stepper documentation
- Added Timeline documentation
- Added Breadcrumb documentation
- Added DotIndicator documentation
- Added Menubar documentation
- Added NavigationBar documentation
- Added NavigationMenu documentation
- Added NavigationRail documentation
- Added NavigationSidebar documentation
- Added Pagination documentation
- Added Switcher documentation
- Added TabList documentation
- Added TabPane documentation
- Added Tabs documentation
- Added Tree documentation
- Added Dialog documentation
- Added Drawer documentation
- Added HoverCard documentation
- Added Popover documentation
- Added Sheet documentation
- Added Swiper documentation
- Added Tooltip documentation
- Added Window documentation
- Added Badge documentation
- Added ButtonGroup documentation
- Added Calendar documentation
- Added CardButton documentation
- Added Chip documentation
- Added Command documentation
- Added ComponentController documentation
- Added ContextMenu documentation
- Added ControlledComponent documentation
- Added DropdownMenu documentation
- Added IgnoreForm documentation
- Added KeyboardDisplay documentation
- Added OverflowMarquee documentation
- Added RefreshTrigger documentation
- Added StatedWidget documentation
- Added SubFocus documentation

## 0.0.40

- Added Semantics to CodeSnippet
- Clickable no longer handles Semantics
- Bumped flutter version requirement to 3.35.1

## 0.0.39

- Added SubFocus component
- Fixed ButtonStyleOverride being discarded after Button dependency update
- Fixed ButtonGroup modifiying immutable list
- Added alignment parameter to showDropdown
- Added Switcher component
- Upgraded to 3.35.1
- FormController no longer discard detached FormValue for restoration purposes
- Added SubFocus component
- Enhanced keyboard shortcut accessibility Select, MultiSelect, Command,
  Menubar, Dropdown, etc using SubFocus component
- Fixed directionality on Drawer and Sheet
- Fixed auto focus issue with components inside dialog
- Implemented New York v4 style based on original shadcn/ui design spec
- Old New York color schemes has been renamed to LegacyColorSchemes
- Added private constructor to LegacyColorSchemes and ColorSchemes
- Implemented bunch of ComponentTheme for a lot of components

## 0.0.38

- Added component tiles for various UI elements (major documentation
  improvement)
- Fixed missing callback invocation (#277)
- Fixed formatted input form key type (#292)
- Updated RefreshTrigger to support reverse scrolling behavior (#270)
- Fixed controller attachment to use cached value directly
- Refactored internal state classes for clarity and improved animation
  controller handling
- Updated dependencies and refactored InputHintFeature for improved context
  handling
- Updated funding link

## 0.0.37

- Fixed web preloader issues
- Fix PhoneInput initialValue not being passed
- Added showTopSnapBar to WindowNavigator
- Fix item picker issue with popover
- Refactor IterableExtension to use ValueGetter instead of Supplier for
  buildSeparator method
- Fixed issue with ResizablePane state management
- Added a way to get form values individually with type-safe casting
- Upgraded to Flutter 3.32.0

## 0.0.36

- Added native (adaptive) context menu builder for TextField
- Added material context menu builder for TextField
- Added cupertino context menu builder for TextField
- Added parameter to skip input feature focus traversal
- Fixed issue with validities casting in form widget

## 0.0.35

- Fix InputSpinner gesture
- Added RadioCardThemeData (by @mcquenji)
- Added PhoneInputTheme (by @mcquenji)
- Fixed CalendarGridData
- Added generic parameter type to `FormFieldHandle#reportNewFormValue` to handle
  typed-null value
- Fixed LengthValidator issue with the validator ignores null value
- Added title parameter to ItemPicker
- Fixed async error issue with FormErrorBuilder
- Fixed issue with FormEntry cached value not accepting null for the initial
  value
- Removed FormValidationMode.waiting
- ValidationResult is now attached to a FormKey
- WaitingResult now stores proper validation mode value
- Added errors getter on form controller
- SubmitButton now uses FormErrorBuilder instead of handling its own state

## 0.0.34

- Excluded web loaders directory from package release
- Disabled AutoComplete shortcuts and actions while suggestion popover is not
  open

## 0.0.33

- Added showValuePredicate parameter to Select, MultiSelect, ControlledSelect,
  and ControlledMultiSelect
- Fixed AutoComplete suggestion item button
- Added AcceptSuggestionIntent and NavigateSuggestionIntent to AutoComplete
- Added resizeToAvoidBottomInset to Scaffold

## 0.0.32

- Fixed StarRating component
- Added InputFeatureVisibility
- Fixed Password Toggle Input Feature

## 0.0.31

- Added ItemPicker component
- Fixed TimePicker text field vertical align
- Fixed incorrect popover signature
- Added repaint boundary to Scaffold and NavigationBar
- Improved Text extension

## 0.0.30

- Fixed Sheet autoOpen issue
- Fixed incorrect MultiSelectKey FormKey type
- Fixed Focus issue on closing dialog
- Fixed Focus issue on closing popover
- Default locale now accepts all language as a fallback
- Fix scaffold MediaQuery padding
- Added DateInput component
- Added TimeInput component
- Added DurationInput component
- Improved sonner/toast component hover animation
- Added PrimaryButtonTheme
- Added SecondaryButtonTheme
- Added OutlineButtonTheme
- Added GhostButtonTheme
- Added DestructiveButtonTheme
- Added LinkButtonTheme
- Added MutedButtonTheme
- Added CardButtonTheme
- Added TextButtonTheme
- Added MenuButtonTheme
- Added MenubarButtonTheme
- Added FixedButtonTheme
- FormattedInput now properly transfer focus when done editing one of the part

## 0.0.29

- Properly bundled Geist and Geist Mono fonts
- Properly bundled Radix and Bootstrap Icons
- Added Lucide Icons
- Added style to SelectItemButton
- Added MultiSelectChip component
- MultiSelect now uses MultiSelectChip as the itemBuilder
- Added more extension methods to AbstractButtonStyle
- Added Swiper component
- TextEditingController no longer implements ComponentController
- NavigationLabeled now uses directional padding
- Fixed StarRatings on mobile devices
- Fixed SheetOverlayHandler safe area issue

## 0.0.28

- Added no virtualization mode on Select and MultiSelect Popup
- Added intrinsic PopupConstraint
- Fixed autoClosePopup on Select and MultiSelect

## 0.0.27

- Fix ControlledComponent initial state issue

## 0.0.26

- Added ControlledComponent and ComponentController
- Added DateInput component
- Added FormattedInput component
- Fixed Calendar component
- Added ControlledCheckbox component
- Added ControlledChips component
- Added ControlledChipInput component
- Added ControlledDatePicker component
- Added ControlledRadioGroup component
- Added ControlledSelect component
- Added ControlledSlider component
- Added ControlledStarRating component
- Added ControlledSwitch component
- Added ControlledTimePicker component
- Added ControlledToggle component
- Select and MultiSelect rework
- Added IgnoreForm component
- Remove non-alphanumeric filter on Avatar getInitials
- TextField no longer wraps material TextField
- Removed deprecated withOpacity usage
- Added WidgetStateProvider component
- Fix ContextMenu state issue
- Fix select hover scroll color

## 0.0.25

- Tabs, TabList, and TabPane are now based on the new TabContainer
- Fixed InputOTP onSubmit issue
- Added onDropFailed on Sortable
- Bump flutter dependency version to 3.29.0
- Added TabPane component
- Added Expanded option on NavigationBar, NavigationRail, and Sidebar
- Fixed missing child in FormErrorBuilder
- Fixed Toast component state
- Fixed Progress component assertion
- Refactored NavigationMenu children component
- Refactored Navigation children components
- Internal form rework
- Fixed carousel controller disposal
- Added SortableDragHandle
- Improved Sortable animation

## 0.0.24

- Remove pixel_snap
- Fixed flutter dependency version constraint
- Added Sortable drop animation
- Added SortableDragHandle component
- Added Tab Pane component
- Fixed flutter dependency version constraint

## 0.0.23

- Support for 3.27.0
- Added Sortable component
- Added Table component
- Fixed resizing issues with Resizable component
- Changed default popupWidthConstraint to anchorFixSize
- Fixed text field leading and trailing issue
- Alpha sat and val now follow the wheel value on color picker

## 0.0.22

- Added Collapsible Theme
- Added CardButton component
- Added leading and trailing to form title
- Added Progress Theme
- Added Tracker Theme
- Added separate overlay handler for mobile and desktop devices
- Separated data widgets to another package
- Fix dispose on RecentColorsScope notifier
- Added ThemeMode
- Fixed Form Validation microtask delay issue
- Form Validators now return a FutureOr

## 0.0.21

- Fixed issue with Form Validation Mode lifecycle
- Fixed text extension for SelectableText
- Replace switch focus border with FocusOutline
- Added tracker theme
- Added countries parameter to PhoneInput
- Added clipBehavior param to TextField
- Fix RecentColorsScope state disposal
- Scroll Interception is no longer enabled by default
- Added ShadcnLayer widget to wrap shadcn flutter components without ShadcnApp
  widget

## 0.0.20

- Replaced photoUrl to image provider in Avatar component
- Added ButtonGroup component
- Added StatedWidget component
- Added AutoComplete component
- Reworked the web preloader
- Added Number Input component
- Added Refresh Trigger component
- Fixed the issue with static button text style
- Fixed scaffold hitbox order issue
- Exposed textInputAction property for Text Input component
- Reworked the Color Picker component
- Added screen color picker
- Added toast layer to scaffold

## 0.0.19

- Fixed test issue

## 0.0.18

- Added Number Ticker component
- Added Linear Progress component
- Added Chip Input component
- Updated Color Picker component
- Added Multi Select component
- Added Phone Input component
- Added Radio Card component
- Added Star Rating component
- Added Time Picker component
- Added App Bar component
- Added Card Image component
- Added Scaffold component
- Added Stepper component
- Added Timeline component
- Added Dot Indicator component
- Added Navigation Bar component
- Added Navigation Rail component
- Added Navigation Sidebar component
- Added Tree component
- Added Avatar Group component
- Added Tracker component
- Added Keyboard Display component
- Added Overflow Marquee component
- Fixed animation implementation issue
- Improved popover system
- Added scaling option
- Added surfaceOpacity option
- Added surfaceBlur option
- Improved drawer
- Fixed button visual issue in light mode
- Fixed input issue on mobile
- Added option to use native input context menu
- Added mobile context menu
- Fixed radix icons visual glitch
- Added checkbox animation
- Added year and month selection to date picker
- Added tooltip trigger for mobile
- Fixed carousel implementation to match design spec
- Added data messenger to fix data binding issue
- Added more style to chip component
- Improved radio component visual design
- Added more params to input component
- Improved select performance
- Upgraded cross_file dependency

## 0.0.17

- Fixed chained text widget
- Added toast component
- Added colors constants
- Added HSL color picker
- Fixed color shades generation issue
- Improved radio group widget

## 0.0.16

- Fixed bug with data not being bound to popover context
- Fixed popover transformation matrix

## 0.0.15

- Added support for Material/Cupertino widgets

## 0.0.14

- Overhauled popover system
- Removed Popover, PopoverLayoutDelegate, PopoverExtension, and PopoverPortal
- Added NavigationMenu component
- Capture and re-wrap data widget in popover

## 0.0.13

- Fixed platform interface initialization

## 0.0.12

- Added Resizable component
- Added Menubar component
- Refactored ComboBox to Select
- Added Context Menu component
- Added Dropdown Menu component

## 0.0.11

- Fixed missing icons directory

## 0.0.10

- Fixed icon visual glitch

## 0.0.9

- Fixed duplicate widget entries

## 0.0.8

- Updated installation guide

## 0.0.7

- Fix broken links in README.md

## 0.0.6

- Updated README.md

## 0.0.5

- Fix platform support for windows, android, macos, linux, and ios
- Added drawer and sheet

## 0.0.4

- Split into 3 packages: shadcn_flutter, shadcn_flutter_web, and
  shadcn_flutter_platform_interface

## 0.0.3

- Added wasm support
- Overhauled the button component and the badge component

## 0.0.2

- Added missing components
- Improved documentation pages

## 0.0.1

- Initial release
