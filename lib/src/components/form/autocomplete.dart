import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AutoComplete extends StatefulWidget {
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final TextEditingController? controller;
  final bool border;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter> inputFormatters;
  final String? placeholder;
  final ValueChanged<int>? onAcceptSuggestion;
  final FocusNode? focusNode;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final PopoverConstraint? popoverWidthConstraint;
  final BoxConstraints? popoverConstraints;
  final Widget? leading;
  final Widget? trailing;

  const AutoComplete({
    super.key,
    required this.suggestions,
    required this.onChanged,
    this.initialValue,
    this.controller,
    this.border = true,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.placeholder,
    this.onAcceptSuggestion,
    this.focusNode,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverWidthConstraint,
    this.popoverConstraints,
    this.leading,
    this.trailing,
  });

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
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
        if (value) {
          widget.onSelected();
        }
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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _suggestions.addListener(_onSuggestionsChanged);
    if (widget.suggestions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
      });
    }
  }

  void _onFocusChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _onSuggestionsChanged();
    });
  }

  void _onSuggestionsChanged() {
    if ((_suggestions.value.isEmpty && _popoverController.hasOpenPopover) ||
        !_focusNode.hasFocus) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover &&
        _suggestions.value.isNotEmpty) {
      _selectedIndex.value = -1;
      _popoverController.show(
        context: context,
        handler: const PopoverOverlayHandler(),
        builder: (context) {
          final theme = Theme.of(context);
          return ConstrainedBox(
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
                              _acceptSuggestion(index);
                            },
                          );
                        });
                  }),
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

  @override
  void didUpdateWidget(covariant AutoComplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.suggestions, widget.suggestions)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
      });
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  void _acceptSuggestion(int index) {
    if (index < 0 || index >= _suggestions.value.length) {
      return;
    }
    widget.onAcceptSuggestion?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowDown):
            const _MoveSelectionIntent(1),
        LogicalKeySet(LogicalKeyboardKey.arrowUp):
            const _MoveSelectionIntent(-1),
        LogicalKeySet(LogicalKeyboardKey.enter): const _AcceptSelectionIntent(),
      },
      child: Actions(
        actions: {
          _MoveSelectionIntent: CallbackAction<_MoveSelectionIntent>(
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
          _AcceptSelectionIntent: CallbackAction<_AcceptSelectionIntent>(
            onInvoke: (intent) {
              final selectedIndex = _selectedIndex.value;
              _acceptSuggestion(selectedIndex);
              return;
            },
          ),
        },
        child: TextField(
          focusNode: _focusNode,
          leading: widget.leading,
          trailing: widget.trailing,
          enabled: widget.enabled,
          border: widget.border,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          controller: widget.controller,
          inputFormatters: widget.inputFormatters,
          placeholder: widget.placeholder,
          initialValue: widget.initialValue,
        ),
      ),
    );
  }
}

class _MoveSelectionIntent extends Intent {
  final int direction;

  const _MoveSelectionIntent(this.direction);
}

class _AcceptSelectionIntent extends Intent {
  const _AcceptSelectionIntent();
}
