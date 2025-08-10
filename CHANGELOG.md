## 0.0.38
* Added component tiles for various UI elements (major documentation improvement)
* Fixed missing callback invocation (#277)
* Fixed formatted input form key type (#292)
* Updated RefreshTrigger to support reverse scrolling behavior (#270)
* Fixed controller attachment to use cached value directly
* Refactored internal state classes for clarity and improved animation controller handling
* Updated dependencies and refactored InputHintFeature for improved context handling
* Updated funding link

## 0.0.37
* Fixed web preloader issues
* Fix PhoneInput initialValue not being passed
* Added showTopSnapBar to WindowNavigator
* Fix item picker issue with popover
* Refactor IterableExtension to use ValueGetter instead of Supplier for buildSeparator method
* Fixed issue with ResizablePane state management
* Added a way to get form values individually with type-safe casting
* Upgraded to Flutter 3.32.0

## 0.0.36
* Added native (adaptive) context menu builder for TextField
* Added material context menu builder for TextField
* Added cupertino context menu builder for TextField
* Added parameter to skip input feature focus traversal
* Fixed issue with validities casting in form widget

## 0.0.35
* Fix InputSpinner gesture
* Added RadioCardThemeData (by @mcquenji)
* Added PhoneInputTheme (by @mcquenji)
* Fixed CalendarGridData
* Added generic parameter type to `FormFieldHandle#reportNewFormValue` to handle typed-null value
* Fixed LengthValidator issue with the validator ignores null value
* Added title parameter to ItemPicker
* Fixed async error issue with FormErrorBuilder
* Fixed issue with FormEntry cached value not accepting null for the initial value
* Removed FormValidationMode.waiting
* ValidationResult is now attached to a FormKey
* WaitingResult now stores proper validation mode value
* Added errors getter on form controller
* SubmitButton now uses FormErrorBuilder instead of handling its own state

## 0.0.34
* Excluded web loaders directory from package release
* Disabled AutoComplete shortcuts and actions while suggestion popover is not open

## 0.0.33
* Added showValuePredicate parameter to Select, MultiSelect, ControlledSelect, and ControlledMultiSelect
* Fixed AutoComplete suggestion item button 
* Added AcceptSuggestionIntent and NavigateSuggestionIntent to AutoComplete
* Added resizeToAvoidBottomInset to Scaffold

## 0.0.32
* Fixed StarRating component
* Added InputFeatureVisibility
* Fixed Password Toggle Input Feature

## 0.0.31
* Added ItemPicker component
* Fixed TimePicker text field vertical align
* Fixed incorrect popover signature
* Added repaint boundary to Scaffold and NavigationBar
* Improved Text extension

## 0.0.30
* Fixed Sheet autoOpen issue
* Fixed incorrect MultiSelectKey FormKey type
* Fixed Focus issue on closing dialog
* Fixed Focus issue on closing popover
* Default locale now accepts all language as a fallback
* Fix scaffold MediaQuery padding
* Added DateInput component
* Added TimeInput component
* Added DurationInput component
* Improved sonner/toast component hover animation
* Added PrimaryButtonTheme
* Added SecondaryButtonTheme
* Added OutlineButtonTheme
* Added GhostButtonTheme
* Added DestructiveButtonTheme
* Added LinkButtonTheme
* Added MutedButtonTheme
* Added CardButtonTheme
* Added TextButtonTheme
* Added MenuButtonTheme
* Added MenubarButtonTheme
* Added FixedButtonTheme
* FormattedInput now properly transfer focus when done editing one of the part

## 0.0.29
* Properly bundled Geist and Geist Mono fonts
* Properly bundled Radix and Bootstrap Icons
* Added Lucide Icons
* Added style to SelectItemButton
* Added MultiSelectChip component
* MultiSelect now uses MultiSelectChip as the itemBuilder
* Added more extension methods to AbstractButtonStyle
* Added Swiper component
* TextEditingController no longer implements ComponentController
* NavigationLabeled now uses directional padding
* Fixed StarRatings on mobile devices
* Fixed SheetOverlayHandler safe area issue

## 0.0.28
* Added no virtualization mode on Select and MultiSelect Popup
* Added intrinsic PopupConstraint
* Fixed autoClosePopup on Select and MultiSelect

## 0.0.27
* Fix ControlledComponent initial state issue

## 0.0.26
* Added ControlledComponent and ComponentController
* Added DateInput component
* Added FormattedInput component
* Fixed Calendar component
* Added ControlledCheckbox component
* Added ControlledChips component
* Added ControlledChipInput component
* Added ControlledDatePicker component
* Added ControlledRadioGroup component
* Added ControlledSelect component
* Added ControlledSlider component
* Added ControlledStarRating component
* Added ControlledSwitch component
* Added ControlledTimePicker component
* Added ControlledToggle component
* Select and MultiSelect rework
* Added IgnoreForm component
* Remove non-alphanumeric filter on Avatar getInitials
* TextField no longer wraps material TextField
* Removed deprecated withOpacity usage
* Added WidgetStateProvider component
* Fix ContextMenu state issue
* Fix select hover scroll color

## 0.0.25
* Tabs, TabList, and TabPane are now based on the new TabContainer
* Fixed InputOTP onSubmit issue
* Added onDropFailed on Sortable
* Bump flutter dependency version to 3.29.0
* Added TabPane component
* Added Expanded option on NavigationBar, NavigationRail, and Sidebar
* Fixed missing child in FormErrorBuilder
* Fixed Toast component state
* Fixed Progress component assertion
* Refactored NavigationMenu children component
* Refactored Navigation children components
* Internal form rework
* Fixed carousel controller disposal
* Added SortableDragHandle
* Improved Sortable animation

## 0.0.24
* Remove pixel_snap
* Fixed flutter dependency version constraint
* Added Sortable drop animation
* Added SortableDragHandle component
* Added Tab Pane component
* Fixed flutter dependency version constraint

## 0.0.23
* Support for 3.27.0
* Added Sortable component
* Added Table component
* Fixed resizing issues with Resizable component
* Changed default popupWidthConstraint to anchorFixSize
* Fixed text field leading and trailing issue
* Alpha sat and val now follow the wheel value on color picker

## 0.0.22
* Added Collapsible Theme
* Added CardButton component
* Added leading and trailing to form title
* Added Progress Theme
* Added Tracker Theme
* Added separate overlay handler for mobile and desktop devices
* Separated data widgets to another package
* Fix dispose on RecentColorsScope notifier
* Added ThemeMode
* Fixed Form Validation microtask delay issue
* Form Validators now return a FutureOr

## 0.0.21
* Fixed issue with Form Validation Mode lifecycle
* Fixed text extension for SelectableText
* Replace switch focus border with FocusOutline
* Added tracker theme
* Added countries parameter to PhoneInput
* Added clipBehavior param to TextField
* Fix RecentColorsScope state disposal
* Scroll Interception is no longer enabled by default
* Added ShadcnLayer widget to wrap shadcn flutter components without ShadcnApp widget

## 0.0.20
* Replaced photoUrl to image provider in Avatar component
* Added ButtonGroup component
* Added StatedWidget component
* Added AutoComplete component
* Reworked the web preloader
* Added Number Input component
* Added Refresh Trigger component
* Fixed the issue with static button text style
* Fixed scaffold hitbox order issue
* Exposed textInputAction property for Text Input component
* Reworked the Color Picker component
* Added screen color picker
* Added toast layer to scaffold

## 0.0.19
* Fixed test issue

## 0.0.18
* Added Number Ticker component
* Added Linear Progress component
* Added Chip Input component
* Updated Color Picker component
* Added Multi Select component
* Added Phone Input component
* Added Radio Card component
* Added Star Rating component
* Added Time Picker component
* Added App Bar component
* Added Card Image component
* Added Scaffold component
* Added Stepper component
* Added Timeline component
* Added Dot Indicator component
* Added Navigation Bar component
* Added Navigation Rail component
* Added Navigation Sidebar component
* Added Tree component
* Added Avatar Group component
* Added Tracker component
* Added Keyboard Display component
* Added Overflow Marquee component
* Fixed animation implementation issue
* Improved popover system
* Added scaling option
* Added surfaceOpacity option
* Added surfaceBlur option
* Improved drawer
* Fixed button visual issue in light mode
* Fixed input issue on mobile
* Added option to use native input context menu
* Added mobile context menu
* Fixed radix icons visual glitch
* Added checkbox animation
* Added year and month selection to date picker
* Added tooltip trigger for mobile
* Fixed carousel implementation to match design spec
* Added data messenger to fix data binding issue
* Added more style to chip component
* Improved radio component visual design
* Added more params to input component
* Improved select performance
* Upgraded cross_file dependency

## 0.0.17

* Fixed chained text widget
* Added toast component
* Added colors constants
* Added HSL color picker
* Fixed color shades generation issue
* Improved radio group widget

## 0.0.16

* Fixed bug with data not being bound to popover context
* Fixed popover transformation matrix

## 0.0.15

* Added support for Material/Cupertino widgets

## 0.0.14

* Overhauled popover system
* Removed Popover, PopoverLayoutDelegate, PopoverExtension, and PopoverPortal
* Added NavigationMenu component
* Capture and re-wrap data widget in popover

## 0.0.13

* Fixed platform interface initialization

## 0.0.12

* Added Resizable component
* Added Menubar component
* Refactored ComboBox to Select
* Added Context Menu component
* Added Dropdown Menu component

## 0.0.11

* Fixed missing icons directory

## 0.0.10

* Fixed icon visual glitch

## 0.0.9

* Fixed duplicate widget entries

## 0.0.8

* Updated installation guide

## 0.0.7

* Fix broken links in README.md

## 0.0.6

* Updated README.md

## 0.0.5

* Fix platform support for windows, android, macos, linux, and ios
* Added drawer and sheet

## 0.0.4

* Split into 3 packages: shadcn_flutter, shadcn_flutter_web, and shadcn_flutter_platform_interface

## 0.0.3

* Added wasm support
* Overhauled the button component and the badge component

## 0.0.2

* Added missing components
* Improved documentation pages

## 0.0.1

* Initial release
