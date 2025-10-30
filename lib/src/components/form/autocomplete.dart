import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Function signature for customizing how autocomplete suggestions are applied.
///
/// Takes a [suggestion] string and returns the final text that should be
/// inserted into the text field. This allows for custom formatting or
/// modification of suggestions before they're applied.
typedef AutoCompleteCompleter = String Function(String suggestion);

/// Theme configuration for [AutoComplete] widget styling and behavior.
///
/// Defines the visual appearance and positioning of the autocomplete popover
/// that displays suggestions. All properties are optional and will fall back
/// to sensible defaults when not specified.
///
/// This theme can be applied globally through [ComponentTheme] or passed
/// directly to individual [AutoComplete] widgets for per-instance customization.
class AutoCompleteTheme {
  /// Constraints applied to the autocomplete popover container.
  ///
  /// Controls the maximum/minimum dimensions of the suggestion list popover.
  /// Defaults to a maximum height of 300 logical pixels when null.
  final BoxConstraints? popoverConstraints;

  /// Width constraint strategy for the autocomplete popover.
  ///
  /// Determines how the popover width relates to its anchor (the text field).
  /// Options include matching anchor width, flexible sizing, or fixed dimensions.
  final PopoverConstraint? popoverWidthConstraint;

  /// Alignment point on the anchor widget where the popover attaches.
  ///
  /// Specifies which edge/corner of the text field the popover should align to.
  /// Defaults to bottom-start (bottom-left in LTR, bottom-right in RTL).
  final AlignmentDirectional? popoverAnchorAlignment;

  /// Alignment point on the popover that aligns with the anchor point.
  ///
  /// Specifies which edge/corner of the popover aligns with the anchor alignment.
  /// Defaults to top-start (top-left in LTR, top-right in RTL).
  final AlignmentDirectional? popoverAlignment;

  /// Default mode for how suggestions are applied to text fields.
  ///
  /// Controls the text replacement strategy when a suggestion is selected.
  /// Defaults to [AutoCompleteMode.replaceWord] when null.
  final AutoCompleteMode? mode;

  /// Creates an [AutoCompleteTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  const AutoCompleteTheme({
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode,
  });

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  AutoCompleteTheme copyWith({
    ValueGetter<BoxConstraints?>? popoverConstraints,
    ValueGetter<PopoverConstraint?>? popoverWidthConstraint,
    ValueGetter<AlignmentDirectional?>? popoverAnchorAlignment,
    ValueGetter<AlignmentDirectional?>? popoverAlignment,
    ValueGetter<AutoCompleteMode?>? mode,
  }) {
    return AutoCompleteTheme(
      popoverConstraints: popoverConstraints == null
          ? this.popoverConstraints
          : popoverConstraints(),
      popoverWidthConstraint: popoverWidthConstraint == null
          ? this.popoverWidthConstraint
          : popoverWidthConstraint(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      mode: mode == null ? this.mode : mode(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AutoCompleteTheme &&
        other.popoverConstraints == popoverConstraints &&
        other.popoverWidthConstraint == popoverWidthConstraint &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.popoverAlignment == popoverAlignment &&
        other.mode == mode;
  }

  @override
  int get hashCode => Object.hash(popoverConstraints, popoverWidthConstraint,
      popoverAnchorAlignment, popoverAlignment, mode);
}

/// Intelligent autocomplete functionality with customizable suggestion handling.
///
/// Provides real-time autocomplete suggestions in a popover overlay when used
/// with text input widgets. Supports multiple text replacement modes, keyboard
/// navigation, and theming customization. The widget wraps a child (typically
/// a text field) and displays filtered suggestions based on user input.
///
/// ## Features
///
/// - **Multiple completion modes**: append, replace word, or replace all text
/// - **Keyboard navigation**: arrow keys to navigate, tab/enter to accept
/// - **Customizable presentation**: popover positioning, sizing, and constraints
/// - **Smart suggestion filtering**: automatically manages suggestion visibility
/// - **Accessibility support**: proper focus management and keyboard shortcuts
///
/// The autocomplete behavior is controlled by the [mode] property and can be
/// customized per-instance or globally through [AutoCompleteTheme].
///
/// Example:
/// ```dart
/// AutoComplete(
///   suggestions: ['apple', 'apricot', 'banana', 'cherry'],
///   mode: AutoCompleteMode.replaceWord,
///   child: TextField(
///     decoration: InputDecoration(
///       hintText: 'Type to search fruits...',
///     ),
///   ),
/// )
/// ```
class AutoComplete extends StatefulWidget {
  /// List of suggestions to display in the autocomplete popover.
  ///
  /// When non-empty, triggers the popover to appear with selectable options.
  /// The suggestions are filtered and managed externally - this widget only
  /// handles the presentation and selection logic.
  final List<String> suggestions;

  /// The child widget that receives autocomplete functionality.
  ///
  /// Typically a [TextField] or similar text input widget. The autocomplete
  /// popover will be positioned relative to this widget, and keyboard actions
  /// will be applied to the focused text field within this child tree.
  final Widget child;

  /// Constraints applied to the autocomplete popover container.
  ///
  /// Overrides the theme default. Controls maximum/minimum dimensions of the
  /// suggestion list. When null, uses theme value or framework default.
  final BoxConstraints? popoverConstraints;

  /// Width constraint strategy for the autocomplete popover.
  ///
  /// Overrides the theme default. Determines how popover width relates to
  /// the anchor widget. When null, uses theme value or matches anchor width.
  final PopoverConstraint? popoverWidthConstraint;

  /// Alignment point on the anchor widget for popover attachment.
  ///
  /// Overrides the theme default. Specifies which edge/corner of the child
  /// widget the popover aligns to. When null, uses theme or bottom-start.
  final AlignmentDirectional? popoverAnchorAlignment;

  /// Alignment point on the popover for anchor attachment.
  ///
  /// Overrides the theme default. Specifies which edge/corner of the popover
  /// aligns with the anchor point. When null, uses theme or top-start.
  final AlignmentDirectional? popoverAlignment;

  /// Text replacement strategy when a suggestion is selected.
  ///
  /// Overrides the theme default. Controls how selected suggestions modify
  /// the text field content. When null, uses theme or [AutoCompleteMode.replaceWord].
  final AutoCompleteMode? mode;

  /// Function to customize suggestion text before application.
  ///
  /// Called when a suggestion is selected, allowing modification of the final
  /// text inserted into the field. Useful for adding prefixes, suffixes, or
  /// formatting. Defaults to returning the suggestion unchanged.
  final AutoCompleteCompleter completer;

  /// Creates an [AutoComplete] widget.
  ///
  /// Wraps the provided [child] with autocomplete functionality using the
  /// given [suggestions] list. The popover appearance and behavior can be
  /// customized through the optional positioning and constraint parameters.
  ///
  /// Parameters:
  /// - [suggestions] (`List<String>`, required): available autocomplete options
  /// - [child] (Widget, required): widget to receive autocomplete functionality
  /// - [popoverConstraints] (BoxConstraints?, optional): popover size limits
  /// - [popoverWidthConstraint] (PopoverConstraint?, optional): width strategy
  /// - [popoverAnchorAlignment] (AlignmentDirectional?, optional): anchor point
  /// - [popoverAlignment] (AlignmentDirectional?, optional): popover align point
  /// - [mode] (AutoCompleteMode?, optional): text replacement strategy
  /// - [completer] (AutoCompleteCompleter, default: identity): suggestion processor
  ///
  /// Example:
  /// ```dart
  /// AutoComplete(
  ///   suggestions: suggestions,
  ///   mode: AutoCompleteMode.append,
  ///   completer: (text) => '$text ',
  ///   child: TextField(),
  /// )
  /// ```
  const AutoComplete({
    super.key,
    required this.suggestions,
    required this.child,
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode,
    this.completer = _defaultCompleter,
  });

  @override
  State<AutoComplete> createState() => _AutoCompleteState();

  /// Default completer that returns suggestions unchanged.
  ///
  /// Used as the fallback when no custom [completer] is provided to the
  /// [AutoComplete] constructor. Simply returns the input suggestion as-is.
  static String _defaultCompleter(String suggestion) {
    return suggestion;
  }
}

class _AutoCompleteItem extends StatefulWidget {
  final String suggestion;
  final bool selected;
  final VoidCallback onSelected;

  const _AutoCompleteItem({
    required this.suggestion,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<_AutoCompleteItem> createState() => _AutoCompleteItemState();
}

class _AutoCompleteItemState extends State<_AutoCompleteItem> {
  @override
  Widget build(BuildContext context) {
    return SelectedButton(
      value: widget.selected,
      alignment: AlignmentDirectional.centerStart,
      onChanged: (value) {
        widget.onSelected();
      },
      child: Text(widget.suggestion),
    );
  }

  @override
  void didUpdateWidget(covariant _AutoCompleteItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        if (widget.selected) {
          Scrollable.ensureVisible(context);
        }
      });
    }
  }
}

/// An intent representing an autocomplete suggestion selection.
///
/// Used by the autocomplete system to handle suggestion selections
/// with different modes of completion.
class AutoCompleteIntent extends Intent {
  /// The suggestion text to be completed.
  final String suggestion;

  /// The mode determining how the completion should be applied.
  final AutoCompleteMode mode;

  /// Creates an autocomplete intent with the specified suggestion and mode.
  const AutoCompleteIntent(this.suggestion, this.mode);
}

class _AutoCompleteState extends State<AutoComplete> {
  final ValueNotifier<List<String>> _suggestions = ValueNotifier([]);
  final ValueNotifier<int> _selectedIndex = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();
  bool _isFocused = false;

  AutoCompleteMode get _mode {
    final compTheme = ComponentTheme.maybeOf<AutoCompleteTheme>(context);
    return styleValue(
      widgetValue: widget.mode,
      themeValue: compTheme?.mode,
      defaultValue: AutoCompleteMode.replaceWord,
    );
  }

  @override
  void initState() {
    super.initState();
    _suggestions.addListener(_onSuggestionsChanged);
    if (widget.suggestions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
        _selectedIndex.value = widget.suggestions.isEmpty ? -1 : 0;
      });
    }
  }

  void _onSuggestionsChanged() {
    if ((_suggestions.value.isEmpty && _popoverController.hasOpenPopover) ||
        !_isFocused) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover &&
        _suggestions.value.isNotEmpty) {
      final compTheme = ComponentTheme.maybeOf<AutoCompleteTheme>(context);
      _selectedIndex.value = -1;
      _popoverController.show(
        context: context,
        handler: const PopoverOverlayHandler(),
        builder: (context) {
          final theme = Theme.of(context);
          final compTheme = ComponentTheme.maybeOf<AutoCompleteTheme>(context);
          final popoverConstraints = styleValue<BoxConstraints>(
            widgetValue: widget.popoverConstraints,
            themeValue: compTheme?.popoverConstraints,
            defaultValue: BoxConstraints(
              maxHeight: 300 * theme.scaling,
            ),
          );
          return TextFieldTapRegion(
            child: ConstrainedBox(
              constraints: popoverConstraints,
              child: SurfaceCard(
                padding: const EdgeInsets.all(4) * theme.scaling,
                child: AnimatedBuilder(
                    animation: Listenable.merge([_suggestions, _selectedIndex]),
                    builder: (context, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _suggestions.value.length,
                          itemBuilder: (context, index) {
                            final suggestion = _suggestions.value[index];
                            return _AutoCompleteItem(
                              suggestion: suggestion,
                              selected: index == _selectedIndex.value,
                              onSelected: () {
                                _selectedIndex.value = index;
                                _handleProceed();
                              },
                            );
                          });
                    }),
              ),
            ),
          );
        },
        widthConstraint: styleValue(
            widgetValue: widget.popoverWidthConstraint,
            themeValue: compTheme?.popoverWidthConstraint,
            defaultValue: PopoverConstraint.anchorFixedSize),
        anchorAlignment: styleValue(
            widgetValue: widget.popoverAnchorAlignment,
            themeValue: compTheme?.popoverAnchorAlignment,
            defaultValue: AlignmentDirectional.bottomStart),
        alignment: styleValue(
            widgetValue: widget.popoverAlignment,
            themeValue: compTheme?.popoverAlignment,
            defaultValue: AlignmentDirectional.topStart),
      );
    }
  }

  void _handleProceed() {
    final selectedIndex = _selectedIndex.value;
    if (selectedIndex < 0 || selectedIndex >= _suggestions.value.length) {
      return;
    }
    _popoverController.close();
    var suggestion = _suggestions.value[selectedIndex];
    suggestion = widget.completer(
      suggestion,
    );
    invokeActionOnFocusedWidget(
      AutoCompleteIntent(suggestion, _mode),
    );
  }

  @override
  void didUpdateWidget(covariant AutoComplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.suggestions, widget.suggestions)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
        _selectedIndex.value = widget.suggestions.isEmpty ? -1 : 0;
      });
    }
  }

  void _onFocusChanged(bool focused) {
    _isFocused = focused;
    if (!focused) {
      _popoverController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _selectedIndex,
        builder: (context, child) {
          return FocusableActionDetector(
            onFocusChange: _onFocusChanged,
            shortcuts: _popoverController.hasOpenPopover
                ? {
                    LogicalKeySet(LogicalKeyboardKey.arrowDown):
                        const NavigateSuggestionIntent(1),
                    LogicalKeySet(LogicalKeyboardKey.arrowUp):
                        const NavigateSuggestionIntent(-1),
                    if (widget.suggestions.isNotEmpty &&
                        _selectedIndex.value != -1)
                      LogicalKeySet(LogicalKeyboardKey.tab):
                          const AcceptSuggestionIntent(),
                  }
                : null,
            actions: _popoverController.hasOpenPopover
                ? {
                    NavigateSuggestionIntent:
                        CallbackAction<NavigateSuggestionIntent>(
                      onInvoke: (intent) {
                        final direction = intent.direction;
                        final selectedIndex = _selectedIndex.value;
                        final suggestions = _suggestions.value;
                        if (suggestions.isEmpty) {
                          return;
                        }
                        final newSelectedIndex =
                            (selectedIndex + direction) % suggestions.length;
                        _selectedIndex.value = newSelectedIndex < 0
                            ? suggestions.length - 1
                            : newSelectedIndex;
                        return;
                      },
                    ),
                    AcceptSuggestionIntent:
                        CallbackAction<AcceptSuggestionIntent>(
                      onInvoke: (intent) {
                        _handleProceed();
                        return;
                      },
                    ),
                  }
                : null,
            child: widget.child,
          );
        });
  }
}

/// Text replacement strategies for autocomplete suggestion application.
///
/// Defines how selected autocomplete suggestions modify the existing text
/// field content. Each mode provides different behavior for integrating
/// suggestions with current text.
enum AutoCompleteMode {
  /// Appends the suggestion to the current text field content.
  ///
  /// Adds the selected suggestion at the current cursor position without
  /// removing any existing text. Useful for building compound inputs or
  /// adding multiple values.
  append,

  /// Replaces the current word with the selected suggestion.
  ///
  /// Identifies the word boundary around the cursor and replaces only that
  /// word with the suggestion. This is the default mode and most common
  /// autocomplete behavior for text completion.
  replaceWord,

  /// Replaces all text field content with the selected suggestion.
  ///
  /// Clears the entire text field and sets it to the selected suggestion.
  /// Useful for search fields or when suggestions represent complete values
  /// rather than partial completions.
  replaceAll,
}

/// Intent for navigating through autocomplete suggestions via keyboard.
///
/// Used internally by [AutoComplete] to handle arrow key navigation within
/// the suggestion list. The [direction] indicates movement direction where
/// positive values move down and negative values move up.
class NavigateSuggestionIntent extends Intent {
  /// Direction of navigation through suggestions.
  ///
  /// Positive values move down in the list, negative values move up.
  /// The magnitude is typically 1 for single-step navigation.
  final int direction;

  /// Creates a navigation intent with the specified [direction].
  const NavigateSuggestionIntent(this.direction);
}

/// Intent for accepting the currently selected autocomplete suggestion.
///
/// Used internally by [AutoComplete] to handle suggestion acceptance via
/// keyboard shortcuts (typically Tab or Enter). Triggers the completion
/// logic to apply the selected suggestion to the text field.
class AcceptSuggestionIntent extends Intent {
  /// Creates an accept suggestion intent.
  const AcceptSuggestionIntent();
}
