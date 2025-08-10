import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template toast_theme}
/// Theme data for [ToastLayer] providing default layout values.
/// {@endtemplate}
class ToastTheme {
  final int? maxStackedEntries;
  final EdgeInsetsGeometry? padding;
  final ExpandMode? expandMode;
  final Offset? collapsedOffset;
  final double? collapsedScale;
  final Curve? expandingCurve;
  final Duration? expandingDuration;
  final double? collapsedOpacity;
  final double? entryOpacity;
  final double? spacing;
  final BoxConstraints? toastConstraints;

  /// {@macro toast_theme}
  const ToastTheme({
    this.maxStackedEntries,
    this.padding,
    this.expandMode,
    this.collapsedOffset,
    this.collapsedScale,
    this.expandingCurve,
    this.expandingDuration,
    this.collapsedOpacity,
    this.entryOpacity,
    this.spacing,
    this.toastConstraints,
  });

  ToastTheme copyWith({
    ValueGetter<int?>? maxStackedEntries,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<ExpandMode?>? expandMode,
    ValueGetter<Offset?>? collapsedOffset,
    ValueGetter<double?>? collapsedScale,
    ValueGetter<Curve?>? expandingCurve,
    ValueGetter<Duration?>? expandingDuration,
    ValueGetter<double?>? collapsedOpacity,
    ValueGetter<double?>? entryOpacity,
    ValueGetter<double?>? spacing,
    ValueGetter<BoxConstraints?>? toastConstraints,
  }) {
    return ToastTheme(
      maxStackedEntries: maxStackedEntries == null
          ? this.maxStackedEntries
          : maxStackedEntries(),
      padding: padding == null ? this.padding : padding(),
      expandMode: expandMode == null ? this.expandMode : expandMode(),
      collapsedOffset:
          collapsedOffset == null ? this.collapsedOffset : collapsedOffset(),
      collapsedScale:
          collapsedScale == null ? this.collapsedScale : collapsedScale(),
      expandingCurve:
          expandingCurve == null ? this.expandingCurve : expandingCurve(),
      expandingDuration: expandingDuration == null
          ? this.expandingDuration
          : expandingDuration(),
      collapsedOpacity: collapsedOpacity == null
          ? this.collapsedOpacity
          : collapsedOpacity(),
      entryOpacity:
          entryOpacity == null ? this.entryOpacity : entryOpacity(),
      spacing: spacing == null ? this.spacing : spacing(),
      toastConstraints: toastConstraints == null
          ? this.toastConstraints
          : toastConstraints(),
    );
  }

  @override
  int get hashCode => Object.hash(
        maxStackedEntries,
        padding,
        expandMode,
        collapsedOffset,
        collapsedScale,
        expandingCurve,
        expandingDuration,
        collapsedOpacity,
        entryOpacity,
        spacing,
        toastConstraints,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToastTheme &&
        other.maxStackedEntries == maxStackedEntries &&
        other.padding == padding &&
        other.expandMode == expandMode &&
        other.collapsedOffset == collapsedOffset &&
        other.collapsedScale == collapsedScale &&
        other.expandingCurve == expandingCurve &&
        other.expandingDuration == expandingDuration &&
        other.collapsedOpacity == collapsedOpacity &&
        other.entryOpacity == entryOpacity &&
        other.spacing == spacing &&
        other.toastConstraints == toastConstraints;
  }

  @override
  String toString() {
    return 'ToastTheme(maxStackedEntries: $maxStackedEntries, padding: $padding, expandMode: $expandMode, collapsedOffset: $collapsedOffset, collapsedScale: $collapsedScale, expandingCurve: $expandingCurve, expandingDuration: $expandingDuration, collapsedOpacity: $collapsedOpacity, entryOpacity: $entryOpacity, spacing: $spacing, toastConstraints: $toastConstraints)';
  }
}
typedef ToastBuilder = Widget Function(
    BuildContext context, ToastOverlay overlay);

ToastOverlay showToast({
  required BuildContext context,
  required ToastBuilder builder,
  ToastLocation location = ToastLocation.bottomRight,
  bool dismissible = true,
  Curve curve = Curves.easeOutCubic,
  Duration entryDuration = const Duration(milliseconds: 500),
  VoidCallback? onClosed,
  Duration showDuration = const Duration(seconds: 5),
}) {
  CapturedThemes? themes;
  CapturedData? data;
  _ToastLayerState? layer = Data.maybeFind<_ToastLayerState>(context);
  if (layer != null) {
    themes = InheritedTheme.capture(from: context, to: layer.context);
    data = Data.capture(from: context, to: layer.context);
  } else {
    layer = Data.maybeFindMessenger<_ToastLayerState>(context);
  }
  assert(layer != null, 'No ToastLayer found in context');
  final entry = ToastEntry(
    builder: builder,
    location: location,
    dismissible: dismissible,
    curve: curve,
    duration: entryDuration,
    themes: themes,
    data: data,
    onClosed: onClosed,
    showDuration: showDuration,
  );
  return layer!.addEntry(entry);
}

enum ToastLocation {
  topLeft(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topLeft,
  ),
  topCenter(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topCenter,
  ),
  topRight(
    childrenAlignment: Alignment.bottomCenter,
    alignment: Alignment.topRight,
  ),
  bottomLeft(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomLeft,
  ),
  bottomCenter(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomCenter,
  ),
  bottomRight(
    childrenAlignment: Alignment.topCenter,
    alignment: Alignment.bottomRight,
  );

  final AlignmentGeometry alignment;
  final AlignmentGeometry childrenAlignment;

  const ToastLocation({
    required this.alignment,
    required this.childrenAlignment,
  });
}

enum ExpandMode {
  alwaysExpanded,
  expandOnHover,
  expandOnTap,
  disabled,
}

class ToastLayer extends StatefulWidget {
  final Widget child;
  final int maxStackedEntries;
  final EdgeInsetsGeometry? padding;
  final ExpandMode expandMode;
  final Offset? collapsedOffset;
  final double collapsedScale;
  final Curve expandingCurve;
  final Duration expandingDuration;
  final double collapsedOpacity;
  final double entryOpacity;
  final double spacing;
  final BoxConstraints? toastConstraints;

  const ToastLayer({
    super.key,
    required this.child,
    this.maxStackedEntries = 3,
    this.padding,
    this.expandMode = ExpandMode.expandOnHover,
    this.collapsedOffset,
    this.collapsedScale = 0.9,
    this.expandingCurve = Curves.easeOutCubic,
    this.expandingDuration = const Duration(milliseconds: 500),
    this.collapsedOpacity = 1,
    this.entryOpacity = 0.0,
    this.spacing = 8,
    this.toastConstraints,
  });

  @override
  State<ToastLayer> createState() => _ToastLayerState();
}

class _ToastLocationData {
  final List<_AttachedToastEntry> entries = [];
  bool _expanding = false;
  int _hoverCount = 0;
}

class _ToastLayerState extends State<ToastLayer> {
  final Map<ToastLocation, _ToastLocationData> entries = {
    ToastLocation.topLeft: _ToastLocationData(),
    ToastLocation.topCenter: _ToastLocationData(),
    ToastLocation.topRight: _ToastLocationData(),
    ToastLocation.bottomLeft: _ToastLocationData(),
    ToastLocation.bottomCenter: _ToastLocationData(),
    ToastLocation.bottomRight: _ToastLocationData(),
  };

  void _triggerEntryClosing() {
    if (!mounted) {
      return;
    }
    setState(() {
      // this will rebuild the toast entries
    });
  }

  ToastOverlay addEntry(ToastEntry entry) {
    var attachedToastEntry = _AttachedToastEntry(entry, this);
    setState(() {
      var entries = this.entries[entry.location];
      entries!.entries.add(attachedToastEntry);
    });
    return attachedToastEntry;
  }

  void removeEntry(ToastEntry entry) {
    _AttachedToastEntry? last = entries[entry.location]!
        .entries
        .where((e) => e.entry == entry)
        .lastOrNull;
    if (last != null) {
      setState(() {
        entries[entry.location]!.entries.remove(last);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ToastTheme>(context);
    final maxStackedEntries =
        compTheme?.maxStackedEntries ?? widget.maxStackedEntries;
    final expandMode = compTheme?.expandMode ?? widget.expandMode;
    final collapsedOffset =
        (compTheme?.collapsedOffset ?? widget.collapsedOffset ??
                const Offset(0, 12)) *
            scaling;
    final padding = (compTheme?.padding?.optionallyResolve(context) ??
            widget.padding?.optionallyResolve(context) ??
            const EdgeInsets.all(24)) *
        scaling;
    final toastConstraints = compTheme?.toastConstraints ??
        widget.toastConstraints ??
        BoxConstraints.tightFor(width: 320 * scaling);
    final collapsedScale =
        compTheme?.collapsedScale ?? widget.collapsedScale;
    final expandingCurve =
        compTheme?.expandingCurve ?? widget.expandingCurve;
    final expandingDuration =
        compTheme?.expandingDuration ?? widget.expandingDuration;
    final collapsedOpacity =
        compTheme?.collapsedOpacity ?? widget.collapsedOpacity;
    final entryOpacity = compTheme?.entryOpacity ?? widget.entryOpacity;
    final spacing = compTheme?.spacing ?? widget.spacing;
    int reservedEntries = maxStackedEntries;
    List<Widget> children = [
      widget.child,
    ];
    for (var locationEntry in entries.entries) {
      var location = locationEntry.key;
      var entries = locationEntry.value.entries;
      var expanding = locationEntry.value._expanding;
      int startVisible =
          (entries.length - (maxStackedEntries + reservedEntries)).max(0);
      Alignment entryAlignment =
          location.childrenAlignment.optionallyResolve(context) * -1;
      List<Widget> positionedChildren = [];
      int toastIndex = 0;
      for (var i = entries.length - 1; i >= startVisible; i--) {
        var entry = entries[i];
        positionedChildren.insert(
          0,
          ToastEntryLayout(
            key: entry.key,
            entry: entry.entry,
            expanded: expanding || expandMode == ExpandMode.alwaysExpanded,
            visible: toastIndex < maxStackedEntries,
            dismissible: entry.entry.dismissible,
            previousAlignment: location.childrenAlignment,
            curve: entry.entry.curve,
            duration: entry.entry.duration,
            themes: entry.entry.themes,
            data: entry.entry.data,
            closing: entry._isClosing,
            collapsedOffset: collapsedOffset,
            collapsedScale: collapsedScale,
            expandingCurve: expandingCurve,
            expandingDuration: expandingDuration,
            collapsedOpacity: collapsedOpacity,
            entryOpacity: entryOpacity,
            onClosed: () {
              removeEntry(entry.entry);
              entry.entry.onClosed?.call();
            },
            entryOffset: Offset(
              padding.left * entryAlignment.x.clamp(0, 1) +
                  padding.right * entryAlignment.x.clamp(-1, 0),
              padding.top * entryAlignment.y.clamp(0, 1) +
                  padding.bottom * entryAlignment.y.clamp(-1, 0),
            ),
            entryAlignment: entryAlignment,
            spacing: spacing,
            index: toastIndex,
            actualIndex: entries.length - i - 1,
            onClosing: () {
              entry.close();
            },
            child: ConstrainedBox(
              constraints: toastConstraints,
              child: entry.entry.builder(context, entry),
            ),
          ),
        );
        if (!entry._isClosing.value) {
          toastIndex++;
        }
      }
      if (positionedChildren.isEmpty) {
        continue;
      }
      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: padding,
              child: Align(
                alignment: location.alignment,
                child: MouseRegion(
                  hitTestBehavior: HitTestBehavior.deferToChild,
                  onEnter: (event) {
                    locationEntry.value._hoverCount++;
                    if (expandMode == ExpandMode.expandOnHover) {
                      setState(() {
                        locationEntry.value._expanding = true;
                      });
                    }
                  },
                  onExit: (event) {
                    int currentCount = ++locationEntry.value._hoverCount;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (currentCount == locationEntry.value._hoverCount) {
                        if (mounted) {
                          setState(() {
                            locationEntry.value._expanding = false;
                          });
                        } else {
                          locationEntry.value._expanding = false;
                        }
                      }
                    });
                  },
                  child: ConstrainedBox(
                    constraints: toastConstraints,
                    child: Stack(
                      alignment: location.alignment,
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: positionedChildren,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Data.inherit(
      data: this,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: children,
      ),
    );
  }
}

abstract class ToastOverlay {
  bool get isShowing;
  void close();
}

class _AttachedToastEntry implements ToastOverlay {
  final GlobalKey<_ToastEntryLayoutState> key = GlobalKey();
  final ToastEntry entry;

  _ToastLayerState? _attached;

  @override
  bool get isShowing => _attached != null;

  final ValueNotifier<bool> _isClosing = ValueNotifier(false);

  _AttachedToastEntry(this.entry, this._attached);

  @override
  void close() {
    if (_attached == null) {
      return;
    }
    _isClosing.value = true;
    _attached!._triggerEntryClosing();
    _attached = null;
  }
}

class ToastEntry {
  final ToastBuilder builder;
  final ToastLocation location;
  final bool dismissible;
  final Curve curve;
  final Duration duration;
  final CapturedThemes? themes;
  final CapturedData? data;
  final VoidCallback? onClosed;
  final Duration? showDuration;

  ToastEntry({
    required this.builder,
    required this.location,
    this.dismissible = true,
    this.curve = Curves.easeInOut,
    this.duration = kDefaultDuration,
    required this.themes,
    required this.data,
    this.onClosed,
    this.showDuration = const Duration(seconds: 5),
  });
}

class ToastEntryLayout extends StatefulWidget {
  final ToastEntry entry;
  final bool expanded;
  final bool visible;
  final bool dismissible;
  final AlignmentGeometry previousAlignment;
  final Curve curve;
  final Duration duration;
  final CapturedThemes? themes;
  final CapturedData? data;
  final ValueListenable<bool> closing;
  final VoidCallback onClosed;
  final Offset collapsedOffset;
  final double collapsedScale;
  final Curve expandingCurve;
  final Duration expandingDuration;
  final double collapsedOpacity;
  final double entryOpacity;
  final Widget child;
  final Offset entryOffset;
  final AlignmentGeometry entryAlignment;
  final double spacing;
  final int index;
  final int actualIndex;
  final VoidCallback? onClosing;

  const ToastEntryLayout({
    super.key,
    required this.entry,
    required this.expanded,
    this.visible = true,
    this.dismissible = true,
    this.previousAlignment = Alignment.center,
    this.curve = Curves.easeInOut,
    this.duration = kDefaultDuration,
    required this.themes,
    required this.data,
    required this.closing,
    required this.onClosed,
    required this.collapsedOffset,
    required this.collapsedScale,
    this.expandingCurve = Curves.easeInOut,
    this.expandingDuration = kDefaultDuration,
    this.collapsedOpacity = 0.8,
    this.entryOpacity = 0.0,
    required this.entryOffset,
    required this.child,
    required this.entryAlignment,
    required this.spacing,
    required this.index,
    required this.actualIndex,
    required this.onClosing,
  });

  @override
  State<ToastEntryLayout> createState() => _ToastEntryLayoutState();
}

class _ToastEntryLayoutState extends State<ToastEntryLayout> {
  bool _dismissing = false;
  double _dismissOffset = 0;
  late int index;
  double? _closeDismissing;
  Timer? _closingTimer;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startClosingTimer();
  }

  void _startClosingTimer() {
    if (widget.entry.showDuration != null) {
      _closingTimer?.cancel();
      _closingTimer = Timer(widget.entry.showDuration!, () {
        widget.onClosing?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = MouseRegion(
      key: _key,
      hitTestBehavior: HitTestBehavior.deferToChild,
      onEnter: (event) {
        _closingTimer?.cancel();
      },
      onExit: (event) {
        _startClosingTimer();
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          if (widget.dismissible) {
            setState(() {
              _closingTimer?.cancel();
              _dismissing = true;
            });
          }
        },
        onHorizontalDragUpdate: (details) {
          if (widget.dismissible) {
            setState(() {
              _dismissOffset += details.primaryDelta! / context.size!.width;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (widget.dismissible) {
            setState(() {
              _dismissing = false;
            });
            // if its < -0.5 or > 0.5 dismiss it
            if (_dismissOffset < -0.5) {
              _closeDismissing = -1.0;
            } else if (_dismissOffset > 0.5) {
              _closeDismissing = 1.0;
            } else {
              _dismissOffset = 0;
              _startClosingTimer();
            }
          }
        },
        child: AnimatedBuilder(
            animation: widget.closing,
            builder: (context, child) {
              return AnimatedValueBuilder(
                  value: widget.closing.value ? 0.0 : _dismissOffset,
                  duration: _dismissing && !widget.closing.value
                      ? Duration.zero
                      : kDefaultDuration,
                  builder: (context, dismissProgress, child) {
                    return AnimatedValueBuilder(
                        value: widget.closing.value
                            ? 0.0
                            : _closeDismissing ?? 0.0,
                        duration: kDefaultDuration,
                        onEnd: (value) {
                          if (value == -1.0 || value == 1.0) {
                            widget.onClosed();
                          }
                        },
                        builder: (context, closeDismissingProgress, child) {
                          return AnimatedValueBuilder(
                              value: widget.index.toDouble(),
                              curve: widget.curve,
                              duration: widget.duration,
                              builder: (context, indexProgress, child) {
                                return AnimatedValueBuilder(
                                  initialValue: widget.index > 0 ? 1.0 : 0.0,
                                  value: widget.closing.value && !_dismissing
                                      ? 0.0
                                      : 1.0,
                                  curve: widget.curve,
                                  duration: widget.duration,
                                  onEnd: (value) {
                                    if (value == 0.0 && widget.closing.value) {
                                      widget.onClosed();
                                    }
                                  },
                                  builder: (context, showingProgress, child) {
                                    return AnimatedValueBuilder(
                                        value: widget.visible ? 1.0 : 0.0,
                                        curve: widget.curve,
                                        duration: widget.duration,
                                        builder:
                                            (context, visibleProgress, child) {
                                          return AnimatedValueBuilder(
                                              value:
                                                  widget.expanded ? 1.0 : 0.0,
                                              curve: widget.expandingCurve,
                                              duration:
                                                  widget.expandingDuration,
                                              builder: (context, expandProgress,
                                                  child) {
                                                return buildToast(
                                                    expandProgress,
                                                    showingProgress,
                                                    visibleProgress,
                                                    indexProgress,
                                                    dismissProgress,
                                                    closeDismissingProgress);
                                              });
                                        });
                                  },
                                );
                              });
                        });
                  });
            }),
      ),
    );
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }

  Widget buildToast(
      double expandProgress,
      double showingProgress,
      double visibleProgress,
      double indexProgress,
      double dismissProgress,
      double closeDismissingProgress) {
    double nonCollapsingProgress = (1.0 - expandProgress) * showingProgress;
    var offset = widget.entryOffset * (1.0 - showingProgress);

    // when its behind another toast, shift it up based on index
    var previousAlignment = widget.previousAlignment.optionallyResolve(context);
    offset += Offset(
          (widget.collapsedOffset.dx * previousAlignment.x) *
              nonCollapsingProgress,
          (widget.collapsedOffset.dy * previousAlignment.y) *
              nonCollapsingProgress,
        ) *
        indexProgress;

    final theme = Theme.of(context);

    Offset expandingShift = Offset(
      previousAlignment.x * (16 * theme.scaling) * expandProgress,
      previousAlignment.y * (16 * theme.scaling) * expandProgress,
    );

    offset += expandingShift;

    // and then add the spacing when its in expanded mode
    offset += Offset(
          (widget.spacing * previousAlignment.x) * expandProgress,
          (widget.spacing * previousAlignment.y) * expandProgress,
        ) *
        indexProgress;

    var entryAlignment = widget.entryAlignment.optionallyResolve(context);
    var fractionalOffset = Offset(
      entryAlignment.x * (1.0 - showingProgress),
      entryAlignment.y * (1.0 - showingProgress),
    );

    fractionalOffset += Offset(
      closeDismissingProgress + dismissProgress,
      0,
    );

    // when its behind another toast AND is expanded, shift it up based on index and the size of self
    fractionalOffset += Offset(
          expandProgress * previousAlignment.x,
          expandProgress * previousAlignment.y,
        ) *
        indexProgress;

    var opacity = tweenValue(
      widget.entryOpacity,
      1.0,
      showingProgress * visibleProgress,
    );

    // fade out the toast behind
    opacity *=
        pow(widget.collapsedOpacity, indexProgress * nonCollapsingProgress);

    opacity *= 1 - (closeDismissingProgress + dismissProgress).abs();

    double scale =
        1.0 * pow(widget.collapsedScale, indexProgress * (1 - expandProgress));

    return Align(
      alignment: entryAlignment,
      child: Transform.translate(
        offset: offset,
        child: FractionalTranslation(
          translation: fractionalOffset,
          child: Opacity(
            opacity: opacity.clamp(0, 1),
            child: Transform.scale(
              scale: scale,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
