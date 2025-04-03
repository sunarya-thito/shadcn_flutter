import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef AutoCompleteCompleter = String Function(String suggestion);

class AutoComplete extends StatefulWidget {
  final List<String> suggestions;
  final Widget child;
  final BoxConstraints? popoverConstraints;
  final PopoverConstraint? popoverWidthConstraint;
  final AlignmentDirectional? popoverAnchorAlignment;
  final AlignmentDirectional? popoverAlignment;
  final AutoCompleteMode mode;
  final AutoCompleteCompleter completer;
  const AutoComplete({
    super.key,
    required this.suggestions,
    required this.child,
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode = AutoCompleteMode.replaceWord,
    this.completer = _defaultCompleter,
  });

  @override
  State<AutoComplete> createState() => _AutoCompleteState();

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

class _AutoCompleteState extends State<AutoComplete> {
  final ValueNotifier<List<String>> _suggestions = ValueNotifier([]);
  final ValueNotifier<int> _selectedIndex = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();
  bool _isFocused = false;

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
      _selectedIndex.value = -1;
      _popoverController.show(
        context: context,
        handler: const PopoverOverlayHandler(),
        builder: (context) {
          final theme = Theme.of(context);
          return TextFieldTapRegion(
            child: ConstrainedBox(
              constraints: widget.popoverConstraints ??
                  BoxConstraints(
                    maxHeight: 300 * theme.scaling,
                  ),
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
        widthConstraint:
            widget.popoverWidthConstraint ?? PopoverConstraint.anchorFixedSize,
        anchorAlignment:
            widget.popoverAnchorAlignment ?? AlignmentDirectional.bottomStart,
        alignment: widget.popoverAlignment ?? AlignmentDirectional.topStart,
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
    switch (widget.mode) {
      case AutoCompleteMode.append:
        TextFieldAppendTextIntent intent =
            TextFieldAppendTextIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
      case AutoCompleteMode.replaceWord:
        TextFieldReplaceCurrentWordIntent intent =
            TextFieldReplaceCurrentWordIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
      case AutoCompleteMode.replaceAll:
        TextFieldSetTextIntent intent =
            TextFieldSetTextIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
    }
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

enum AutoCompleteMode {
  append,
  replaceWord,
  replaceAll,
}

class NavigateSuggestionIntent extends Intent {
  final int direction;

  const NavigateSuggestionIntent(this.direction);
}

class AcceptSuggestionIntent extends Intent {
  const AcceptSuggestionIntent();
}
