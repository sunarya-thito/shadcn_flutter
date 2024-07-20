import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

ToastOverlay showToast({
  required BuildContext context,
  required WidgetBuilder builder,
  ToastLocation location = ToastLocation.bottomRight,
  bool dismissible = true,
  Curve curve = Curves.easeOutCubic,
  Duration entryDuration = const Duration(milliseconds: 500),
  VoidCallback? onClosed,
  Duration showDuration = const Duration(seconds: 60),
}) {
  final layer = Data.maybeOf<_ToastLayerState>(context);
  assert(layer != null, 'No ToastLayer found in context');
  final themes = InheritedTheme.capture(from: context, to: layer!.context);
  final data = Data.capture(from: context, to: layer.context);
  final entry = ToastEntry(
    builder: builder,
    location: location,
    dismissible: dismissible,
    curve: curve,
    duration: entryDuration,
    themes: themes,
    data: data,
    onClosed: onClosed,
  );
  var attachedEntry = layer.addEntry(entry);
  Timer(showDuration, () {
    attachedEntry.close();
  });
  return attachedEntry;
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

  final Alignment alignment;
  final Alignment childrenAlignment;

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
  final EdgeInsets padding;
  final ExpandMode expandMode;
  final Offset collapsedOffset;
  final double collapsedScale;
  final Curve expandingCurve;
  final Duration expandingDuration;
  final double collapsedOpacity;
  final double entryOpacity;
  final double spacing;
  final BoxConstraints toastConstraints;

  const ToastLayer({
    super.key,
    required this.child,
    this.maxStackedEntries = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    this.expandMode = ExpandMode.expandOnHover,
    this.collapsedOffset = const Offset(0, 12),
    this.collapsedScale = 0.9,
    this.expandingCurve = Curves.easeOutCubic,
    this.expandingDuration = const Duration(milliseconds: 500),
    this.collapsedOpacity = 0.8,
    this.entryOpacity = 0.0,
    this.spacing = 8,
    this.toastConstraints = const BoxConstraints.tightFor(width: 320),
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

  ToastOverlay addEntry(ToastEntry entry) {
    var attachedToastEntry = _AttachedToastEntry(entry);
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
    List<Widget> children = [
      widget.child,
    ];
    for (var locationEntry in entries.entries) {
      var location = locationEntry.key;
      var entries = locationEntry.value.entries;
      var expanding = locationEntry.value._expanding;
      int startVisible = (entries.length - (widget.maxStackedEntries + 1))
          .max(0); // + 1 as for the ghost entry
      Alignment entryAlignment = location.childrenAlignment * -1;
      List<Widget> children = [];
      for (var i = startVisible; i < entries.length; i++) {
        var entry = entries[i];
        children.add(
          OverlaidToastEntry(
            key: entry.key,
            entry: entry.entry,
            expanded:
                expanding || widget.expandMode == ExpandMode.alwaysExpanded,
            visible: i >= startVisible + 2,
            dismissible: entry.entry.dismissible,
            previousAlignment: location.childrenAlignment,
            curve: entry.entry.curve,
            duration: entry.entry.duration,
            themes: entry.entry.themes,
            data: entry.entry.data,
            closing: entry._isClosing,
            collapsedOffset: widget.collapsedOffset,
            collapsedScale: widget.collapsedScale,
            expandingCurve: widget.expandingCurve,
            expandingDuration: widget.expandingDuration,
            collapsedOpacity: widget.collapsedOpacity,
            entryOpacity: widget.entryOpacity,
            onClosed: () {
              removeEntry(entry.entry);
              entry.entry.onClosed?.call();
            },
            entryOffset: Offset(
              widget.padding.left * entryAlignment.x.clamp(0, 1) +
                  widget.padding.right * entryAlignment.x.clamp(-1, 0),
              widget.padding.top * entryAlignment.y.clamp(0, 1) +
                  widget.padding.bottom * entryAlignment.y.clamp(-1, 0),
            ),
            entryAlignment: entryAlignment,
            spacing: widget.spacing,
            index: entries.length - i - 1,
            child: ConstrainedBox(
              constraints: widget.toastConstraints,
              child: entry.entry.builder(context),
            ),
          ),
        );
      }
      if (children.isEmpty) {
        continue;
      }
      children.add(
        Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: Align(
            alignment: location.alignment,
            child: MouseRegion(
              hitTestBehavior: HitTestBehavior.deferToChild,
              onEnter: (event) {
                print('onEnter');
                locationEntry.value._hoverCount++;
                if (widget.expandMode == ExpandMode.expandOnHover) {
                  setState(() {
                    locationEntry.value._expanding = true;
                  });
                }
              },
              onExit: (event) {
                print('onExit');
                int currentCount = ++locationEntry.value._hoverCount;
                Future.delayed(Duration(milliseconds: 300), () {
                  if (currentCount == locationEntry.value._hoverCount) {
                    setState(() {
                      locationEntry.value._expanding = false;
                    });
                  }
                });
              },
              child: ConstrainedBox(
                constraints: widget.toastConstraints,
                child: Stack(
                  alignment: location.alignment,
                  clipBehavior: Clip.none,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Data(
      data: this,
      child: Padding(
        padding: widget.padding,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: children,
        ),
      ),
    );
  }
}

abstract class ToastOverlay {
  void close();
}

class _AttachedToastEntry implements ToastOverlay {
  final GlobalKey<_OverlaidToastEntryState> key = GlobalKey();
  final ToastEntry entry;

  ValueNotifier<bool> _isClosing = ValueNotifier(false);

  _AttachedToastEntry(this.entry);

  @override
  void close() {
    _isClosing.value = true;
  }
}

class ToastEntry {
  final WidgetBuilder builder;
  final ToastLocation location;
  final bool dismissible;
  final Curve curve;
  final Duration duration;
  final CapturedThemes themes;
  final CapturedData data;
  final VoidCallback? onClosed;

  ToastEntry({
    required this.builder,
    required this.location,
    this.dismissible = true,
    this.curve = Curves.easeInOut,
    this.duration = kDefaultDuration,
    required this.themes,
    required this.data,
    this.onClosed,
  });
}

class OverlaidToastEntry extends StatefulWidget {
  final ToastEntry entry;
  final bool expanded;
  final bool visible;
  final bool dismissible;
  final Alignment previousAlignment;
  final Curve curve;
  final Duration duration;
  final CapturedThemes themes;
  final CapturedData data;
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
  final Alignment entryAlignment;
  final double spacing;
  final int index;

  const OverlaidToastEntry({
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
  });

  @override
  State<OverlaidToastEntry> createState() => _OverlaidToastEntryState();
}

class _OverlaidToastEntryState extends State<OverlaidToastEntry> {
  bool _dismissing = false;
  double _dismissProgress = 0;
  @override
  Widget build(BuildContext context) {
    return widget.themes.wrap(
      widget.data.wrap(
        AnimatedBuilder(
            animation: widget.closing,
            builder: (context, child) {
              return AnimatedValueBuilder(
                  value: widget.index.toDouble(),
                  curve: widget.curve,
                  duration: widget.duration,
                  builder: (context, indexProgress, child) {
                    return AnimatedValueBuilder(
                      initialValue: 0.0,
                      value: widget.closing.value && !_dismissing ? 0.0 : 1.0,
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
                            curve: widget.expandingCurve,
                            duration: widget.expandingDuration,
                            builder: (context, visibleProgress, child) {
                              return AnimatedValueBuilder(
                                  value: widget.expanded ? 1.0 : 0.0,
                                  curve: widget.expandingCurve,
                                  duration: widget.expandingDuration,
                                  builder: (context, expandProgress, child) {
                                    double nonCollapsingProgress =
                                        (1.0 - expandProgress) *
                                            showingProgress;
                                    var offset = Offset(
                                      (widget.collapsedOffset.dx *
                                                  widget.previousAlignment.x) *
                                              nonCollapsingProgress +
                                          (widget.spacing *
                                                  widget.previousAlignment.x) *
                                              expandProgress,
                                      (widget.collapsedOffset.dy *
                                                  widget.previousAlignment.y) *
                                              nonCollapsingProgress +
                                          (widget.spacing *
                                                  widget.previousAlignment.y) *
                                              expandProgress,
                                    );
                                    var fractionalOffset = Offset(
                                      widget.previousAlignment.x *
                                          expandProgress,
                                      widget.previousAlignment.y *
                                          expandProgress,
                                    );
                                    var scaleValue = tweenValue(
                                        1.0,
                                        widget.collapsedScale,
                                        nonCollapsingProgress);
                                    var opacityValue = tweenValue(
                                          1.0,
                                          widget.collapsedOpacity,
                                          nonCollapsingProgress,
                                        ) *
                                        visibleProgress;
                                    var totalFractionalOffset =
                                        fractionalOffset +
                                            Offset(
                                              widget.entryAlignment.x *
                                                  (1.0 - expandProgress),
                                              widget.entryAlignment.y *
                                                  (1.0 - expandProgress),
                                            );
                                    Widget current = Align(
                                      alignment: widget.entryAlignment,
                                      child: Transform.translate(
                                        offset: widget.entryOffset *
                                            (1.0 - showingProgress),
                                        child: FractionalTranslation(
                                          translation: Offset(
                                            widget.entryAlignment.x *
                                                (1.0 - showingProgress),
                                            widget.entryAlignment.y *
                                                (1.0 - showingProgress),
                                          ),
                                          child: Opacity(
                                            opacity: 1,
                                            // opacity: tweenValue(
                                            //   widget.entryOpacity,
                                            //   1,
                                            //   showingProgress,
                                            // ),
                                            child: widget.child,
                                          ),
                                        ),
                                      ),
                                    );
                                    return current;
                                  });
                            });
                      },
                    );
                  });
            }),
      ),
    );
  }
}
