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
