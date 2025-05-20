import 'dart:collection';
import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/group.dart';
import 'package:shadcn_flutter/src/components/patch.dart';

class WindowSnapStrategy {
  final Rect relativeBounds;
  final bool shouldMinifyWindow;

  const WindowSnapStrategy({
    required this.relativeBounds,
    this.shouldMinifyWindow = true,
  });
}

class WindowState {
  final Rect bounds;
  final Rect? maximized;
  final bool minimized;
  final bool alwaysOnTop;
  final bool closable;
  final bool resizable;
  final bool draggable;
  final bool maximizable;
  final bool minimizable;
  final bool enableSnapping;
  final BoxConstraints constraints;

  const WindowState({
    required this.bounds,
    this.maximized,
    this.minimized = false,
    this.alwaysOnTop = false,
    this.closable = true,
    this.resizable = true,
    this.draggable = true,
    this.maximizable = true,
    this.minimizable = true,
    this.enableSnapping = true,
    this.constraints = kDefaultWindowConstraints,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WindowState) return false;
    return bounds == other.bounds &&
        maximized == other.maximized &&
        minimized == other.minimized &&
        alwaysOnTop == other.alwaysOnTop &&
        closable == other.closable &&
        resizable == other.resizable &&
        draggable == other.draggable &&
        maximizable == other.maximizable &&
        minimizable == other.minimizable &&
        enableSnapping == other.enableSnapping &&
        constraints == other.constraints;
  }

  @override
  int get hashCode => Object.hash(
      bounds,
      maximized,
      minimized,
      alwaysOnTop,
      closable,
      resizable,
      draggable,
      maximizable,
      minimizable,
      enableSnapping,
      constraints);

  @override
  String toString() {
    return 'WindowState(bounds: $bounds, maximized: $maximized, minimized: $minimized, alwaysOnTop: $alwaysOnTop, closable: $closable, resizable: $resizable, draggable: $draggable, maximizable: $maximizable, minimizable: $minimizable, enableSnapping: $enableSnapping, constraints: $constraints)';
  }

  WindowState withMaximized(Rect? maximized) {
    return WindowState(
      bounds: bounds,
      minimized: minimized,
      alwaysOnTop: alwaysOnTop,
      closable: closable,
      resizable: resizable,
      draggable: draggable,
      maximizable: maximizable,
      minimizable: minimizable,
      enableSnapping: enableSnapping,
      constraints: constraints,
      maximized: maximized,
    );
  }

  WindowState copyWith({
    Rect? bounds,
    bool? minimized,
    bool? alwaysOnTop,
    bool? closable,
    bool? resizable,
    bool? draggable,
    bool? maximizable,
    bool? minimizable,
    bool? enableSnapping,
    BoxConstraints? constraints,
  }) {
    return WindowState(
      bounds: bounds ?? this.bounds,
      minimized: minimized ?? this.minimized,
      alwaysOnTop: alwaysOnTop ?? this.alwaysOnTop,
      closable: closable ?? this.closable,
      resizable: resizable ?? this.resizable,
      draggable: draggable ?? this.draggable,
      maximizable: maximizable ?? this.maximizable,
      minimizable: minimizable ?? this.minimizable,
      enableSnapping: enableSnapping ?? this.enableSnapping,
      constraints: constraints ?? this.constraints,
    );
  }
}

class WindowController extends ValueNotifier<WindowState> {
  WindowHandle? _attachedState;
  WindowController({
    required Rect bounds,
    Rect? maximized,
    bool minimized = false,
    bool focused = false,
    bool closable = true,
    bool resizable = true,
    bool draggable = true,
    bool maximizable = true,
    bool minimizable = true,
    bool enableSnapping = true,
    BoxConstraints constraints = kDefaultWindowConstraints,
  }) : super(WindowState(
          bounds: bounds,
          maximized: maximized,
          minimized: minimized,
          alwaysOnTop: focused,
          closable: closable,
          resizable: resizable,
          draggable: draggable,
          maximizable: maximizable,
          minimizable: minimizable,
          enableSnapping: enableSnapping,
          constraints: constraints,
        ));

  bool get mounted => _attachedState != null;

  WindowHandle get attachedState {
    assert(mounted, 'Window is not attached');
    return _attachedState!;
  }

  Rect get bounds => value.bounds;
  set bounds(Rect value) {
    if (value == bounds) return;
    this.value = this.value.copyWith(bounds: value);
  }

  Rect? get maximized => value.maximized;
  set maximized(Rect? value) {
    if (value == maximized) return;
    this.value = this.value.withMaximized(value);
  }

  bool get minimized => value.minimized;
  set minimized(bool value) {
    if (value == minimized) return;
    this.value = this.value.copyWith(minimized: value);
  }

  bool get alwaysOnTop => value.alwaysOnTop;
  set alwaysOnTop(bool value) {
    if (value == alwaysOnTop) return;
    this.value = this.value.copyWith(alwaysOnTop: value);
  }

  bool get closable => value.closable;
  set closable(bool value) {
    if (value == closable) return;
    this.value = this.value.copyWith(closable: value);
  }

  bool get resizable => value.resizable;
  set resizable(bool value) {
    if (value == resizable) return;
    this.value = this.value.copyWith(resizable: value);
  }

  bool get draggable => value.draggable;
  set draggable(bool value) {
    if (value == draggable) return;
    this.value = this.value.copyWith(draggable: value);
  }

  bool get maximizable => value.maximizable;
  set maximizable(bool value) {
    if (value == maximizable) return;
    this.value = this.value.copyWith(maximizable: value);
  }

  bool get minimizable => value.minimizable;
  set minimizable(bool value) {
    if (value == minimizable) return;
    this.value = this.value.copyWith(minimizable: value);
  }

  bool get enableSnapping => value.enableSnapping;
  set enableSnapping(bool value) {
    if (value == enableSnapping) return;
    this.value = this.value.copyWith(enableSnapping: value);
  }

  BoxConstraints get constraints => value.constraints;
  set constraints(BoxConstraints value) {
    if (value == constraints) return;
    this.value = this.value.copyWith(constraints: value);
  }
}

class WindowWidget extends StatefulWidget {
  final Widget? title;
  final Widget? actions;
  final Widget? content;
  final WindowController? controller;
  final bool? resizable;
  final bool? draggable;
  final bool? closable;
  final bool? maximizable;
  final bool? minimizable;
  final Rect? bounds;
  final Rect? maximized;
  final bool? minimized;
  final bool? enableSnapping;
  final BoxConstraints? constraints;

  const WindowWidget({
    super.key,
    this.title,
    this.actions,
    this.content,
    bool this.resizable = true,
    bool this.draggable = true,
    bool this.closable = true,
    bool this.maximizable = true,
    bool this.minimizable = true,
    bool this.enableSnapping = true,
    required Rect this.bounds,
    this.maximized,
    bool this.minimized = false,
    BoxConstraints this.constraints = kDefaultWindowConstraints,
  }) : controller = null;

  const WindowWidget.controlled({
    super.key,
    this.title,
    this.actions,
    this.content,
    required WindowController this.controller,
  })  : bounds = null,
        maximized = null,
        minimized = null,
        resizable = null,
        draggable = null,
        closable = null,
        maximizable = null,
        minimizable = null,
        enableSnapping = null,
        constraints = null;

  const WindowWidget._raw({
    super.key,
    this.title,
    this.actions,
    this.content,
    this.resizable = true,
    this.draggable = true,
    this.closable = true,
    this.maximizable = true,
    this.minimizable = true,
    this.enableSnapping = true,
    this.controller,
    this.bounds,
    this.maximized,
    this.minimized,
    this.constraints,
  });

  @override
  State<WindowWidget> createState() => _WindowWidgetState();
}

mixin WindowHandle on State<WindowWidget> {
  Rect get bounds;
  set bounds(Rect value);
  Rect? get maximized;
  set maximized(Rect? value);
  bool get minimized;
  set minimized(bool value);
  bool get focused;
  set focused(bool value);
  void close();
  bool get alwaysOnTop;
  set alwaysOnTop(bool value);
  bool get resizable;
  bool get draggable;
  bool get closable;
  bool get maximizable;
  bool get minimizable;
  bool get enableSnapping;
  set resizable(bool value);
  set draggable(bool value);
  set closable(bool value);
  set maximizable(bool value);
  set minimizable(bool value);
  set enableSnapping(bool value);
  WindowController get controller;
}

class _WindowWidgetState extends State<WindowWidget> with WindowHandle {
  @override
  late WindowController controller;
  late WindowState state;
  WindowViewport? _viewport;
  Window? _entry;
  Alignment? _dragAlignment;

  void _initializeController() {
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = WindowController(
        bounds: widget.bounds!,
        maximized: widget.maximized,
        minimized: widget.minimized!,
        closable: widget.closable!,
        resizable: widget.resizable!,
        draggable: widget.draggable!,
        maximizable: widget.maximizable!,
        minimizable: widget.minimizable!,
        enableSnapping: widget.enableSnapping!,
        constraints: widget.constraints!,
      );
    }
    controller._attachedState = this;
    state = controller.value;
    controller.addListener(_handleControllerUpdate);
  }

  void _handleControllerUpdate() {
    didControllerUpdate(state);
    state = controller.value;
  }

  void didControllerUpdate(WindowState oldState) {
    if (oldState.alwaysOnTop != state.alwaysOnTop) {
      _viewport?.navigator.setAlwaysOnTop(_entry!, state.alwaysOnTop);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewport = Data.maybeOf<WindowViewport>(context);
    _entry = Data.maybeOf<Window>(context);
  }

  @override
  void didUpdateWidget(covariant WindowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_handleControllerUpdate);
      controller._attachedState = null;
      WindowState oldState = state;
      _initializeController();
      if (oldState != state) {
        didControllerUpdate(oldState);
      }
    }
  }

  Widget _wrapResizer(
      {required MouseCursor cursor,
      required Rect Function(Rect bounds, Offset delta) onResize,
      required int adjustmentX,
      required int adjustmentY}) {
    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          if (state.maximized != null || state.minimized) return;
          var newBounds = onResize(bounds, details.delta);
          double deltaXAdjustment = 0;
          double deltaYAdjustment = 0;
          if (newBounds.width < state.constraints.minWidth) {
            deltaXAdjustment = state.constraints.minWidth - newBounds.width;
          } else if (newBounds.width > state.constraints.maxWidth) {
            deltaXAdjustment = state.constraints.maxWidth - newBounds.width;
          }
          if (newBounds.height < state.constraints.minHeight) {
            deltaYAdjustment = state.constraints.minHeight - newBounds.height;
          } else if (newBounds.height > state.constraints.maxHeight) {
            deltaYAdjustment = state.constraints.maxHeight - newBounds.height;
          }
          deltaXAdjustment *= adjustmentX;
          deltaYAdjustment *= adjustmentY;
          if (deltaXAdjustment != 0 || deltaYAdjustment != 0) {
            newBounds =
                onResize(newBounds, Offset(deltaXAdjustment, deltaYAdjustment));
          }
          bounds = newBounds;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<WindowHandle>.inherit(
      data: this,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          var resizeThickness = 8;

          Widget windowClient = Card(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.zero,
            borderRadius: state.maximized != null
                ? BorderRadius.zero
                : theme.borderRadiusMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.title != null || widget.actions != null)
                  ClickDetector(
                    onClick: maximizable
                        ? (details) {
                            if (details.clickCount >= 2) {
                              if (maximized == null) {
                                maximized = const Rect.fromLTWH(0, 0, 1, 1);
                              } else {
                                maximized = null;
                              }
                            }
                          }
                        : null,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        var localPosition = details.localPosition;
                        var bounds = this.bounds;
                        var max = maximized;
                        var size = _viewport?.size;
                        if (max != null && size != null) {
                          bounds = Rect.fromLTWH(
                              max.left * size.width,
                              max.top * size.height,
                              max.width * size.width,
                              max.height * size.height);
                        }
                        var alignX = lerpDouble(
                            -1, 1, (localPosition.dx / bounds.width))!;
                        var alignY = lerpDouble(
                            -1, 1, (localPosition.dy / bounds.height))!;
                        _dragAlignment = Alignment(
                          alignX,
                          alignY,
                        );
                        if (_entry != null) {
                          _viewport?.navigator._state._startDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                        if (state.maximized != null) {
                          maximized = null;
                          RenderBox? layerRenderBox = _viewport
                              ?.navigator._state.context
                              .findRenderObject() as RenderBox?;
                          if (layerRenderBox != null) {
                            Offset layerLocal = layerRenderBox
                                .globalToLocal(details.globalPosition);
                            Size titleSize = Size(
                              this.bounds.width,
                              32 * theme.scaling,
                            );
                            this.bounds = Rect.fromLTWH(
                              layerLocal.dx - titleSize.width / 2,
                              layerLocal.dy - titleSize.height / 2,
                              this.bounds.width,
                              this.bounds.height,
                            );
                          }
                        }
                      },
                      onPanUpdate: (details) {
                        bounds = bounds.translate(
                          details.delta.dx,
                          details.delta.dy,
                        );
                        if (_entry != null) {
                          _viewport?.navigator._state._updateDraggingWindow(
                            _entry!,
                            details.globalPosition,
                          );
                        }
                      },
                      onPanEnd: (details) {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      onPanCancel: () {
                        if (_entry != null) {
                          _viewport?.navigator._state._stopDraggingWindow(
                            _entry!,
                          );
                        }
                        _dragAlignment = null;
                      },
                      child: Container(
                        height: 32 * theme.scaling,
                        padding: EdgeInsets.all(
                          2 * theme.scaling,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8 * theme.scaling,
                                ),
                                child: (_viewport?.focused ?? true)
                                    ? (widget.title ?? const SizedBox())
                                    : (widget.title ?? const SizedBox())
                                        .muted(),
                              ),
                            ),
                            if (widget.actions != null) widget.actions!,
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.content != null)
                  Expanded(
                    child: widget.content!,
                  ),
              ],
            ),
          );
          // add transition
          windowClient = AnimatedValueBuilder(
              initialValue: 0.0,
              value: (_viewport?.closed ?? false) ? 0.0 : 1.0,
              duration: kDefaultDuration,
              onEnd: (value) {
                if (_viewport?.closed ?? false) {
                  _viewport?.navigator.removeWindow(_entry!);
                }
              },
              builder: (context, value, child) {
                return Transform.scale(
                  scale: (_viewport?.closed ?? false)
                      ? lerpDouble(0.8, 1.0, value)!
                      : lerpDouble(0.9, 1.0, value)!,
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: windowClient);
          windowClient = AnimatedScale(
            scale: (_viewport?.minify ?? false) ? 0.65 : 1.0,
            duration: kDefaultDuration,
            alignment: _dragAlignment ?? Alignment.center,
            curve: Curves.easeInOut,
            child: windowClient,
          );
          windowClient = IgnorePointer(
            ignoring: _viewport?.ignorePointer ?? false,
            child: windowClient,
          );
          Widget windowContainer = Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (_entry != null) {
                _viewport?.navigator.focusWindow(_entry!);
              }
            },
            child: GroupWidget(
              children: [
                windowClient,
                // Resize regions
                if (resizable &&
                    maximized == null &&
                    _dragAlignment == null) ...[
                  // top left
                  GroupPositioned(
                    top: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpLeft,
                      adjustmentX: -1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + delta,
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // top right
                  GroupPositioned(
                    top: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpRight,
                      adjustmentX: 1,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + delta,
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                  // bottom left
                  GroupPositioned(
                    bottom: 0,
                    left: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownLeft,
                      adjustmentX: -1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + delta,
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // bottom right
                  GroupPositioned(
                    bottom: 0,
                    right: 0,
                    width: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeDownRight,
                      adjustmentX: 1,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomRight + delta,
                          bounds.topLeft,
                        );
                      },
                    ),
                  ),
                  // top
                  GroupPositioned(
                    top: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: -1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(0, delta.dy),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // bottom
                  GroupPositioned(
                    bottom: 0,
                    left: resizeThickness * theme.scaling,
                    right: resizeThickness * theme.scaling,
                    height: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeUpDown,
                      adjustmentX: 0,
                      adjustmentY: 1,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.bottomLeft + Offset(0, delta.dy),
                          bounds.topRight,
                        );
                      },
                    ),
                  ),
                  // left
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    left: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: -1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topLeft + Offset(delta.dx, 0),
                          bounds.bottomRight,
                        );
                      },
                    ),
                  ),
                  // right
                  GroupPositioned(
                    top: resizeThickness * theme.scaling,
                    right: 0,
                    bottom: resizeThickness * theme.scaling,
                    width: resizeThickness * theme.scaling,
                    child: _wrapResizer(
                      cursor: SystemMouseCursors.resizeLeftRight,
                      adjustmentX: 1,
                      adjustmentY: 0,
                      onResize: (bounds, delta) {
                        return Rect.fromPoints(
                          bounds.topRight + Offset(delta.dx, 0),
                          bounds.bottomLeft,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
          return AnimatedValueBuilder.raw(
            value: maximized,
            duration: kDefaultDuration,
            curve: Curves.easeInOut,
            lerp: Rect.lerp,
            builder: (context, oldValue, newValue, t, child) {
              var rect = bounds;
              if (newValue != null) {
                var size = _viewport?.size ?? Size.zero;
                var value = Rect.fromLTWH(
                    newValue.left * size.width,
                    newValue.top * size.height,
                    newValue.width * size.width,
                    newValue.height * size.height);
                rect = Rect.lerp(bounds, value, t)!;
              } else if (oldValue != null) {
                var size = _viewport?.size ?? Size.zero;
                var value = Rect.fromLTWH(
                    oldValue.left * size.width,
                    oldValue.top * size.height,
                    oldValue.width * size.width,
                    oldValue.height * size.height);
                rect = Rect.lerp(value, bounds, t)!;
              }
              return GroupPositioned.fromRect(rect: rect, child: child!);
            },
            child: windowContainer,
          );
        },
      ),
    );
  }

  @override
  bool get alwaysOnTop => state.alwaysOnTop;

  @override
  Rect get bounds => state.bounds;

  @override
  bool get closable => state.closable;

  @override
  bool get draggable => state.draggable;

  @override
  bool get enableSnapping => state.enableSnapping;

  @override
  bool get maximizable => state.maximizable;

  @override
  Rect? get maximized => state.maximized;

  @override
  bool get minimizable => state.minimizable;

  @override
  bool get minimized => state.minimized;

  @override
  bool get resizable => state.resizable;

  @override
  bool get focused => state.alwaysOnTop;

  @override
  set alwaysOnTop(bool value) {
    if (value != state.alwaysOnTop) {
      controller.value = state.copyWith(alwaysOnTop: value);
    }
  }

  @override
  set bounds(Rect value) {
    if (value != state.bounds) {
      controller.value = state.copyWith(bounds: value);
    }
  }

  @override
  set closable(bool value) {
    if (value != state.closable) {
      controller.value = state.copyWith(closable: value);
    }
  }

  @override
  void close() {
    _entry?.closed.value = true;
  }

  @override
  set draggable(bool value) {
    if (value != state.draggable) {
      controller.value = state.copyWith(draggable: value);
    }
  }

  @override
  set enableSnapping(bool value) {
    if (value != state.enableSnapping) {
      controller.value = state.copyWith(enableSnapping: value);
    }
  }

  @override
  set focused(bool value) {
    if (_entry == null) return;
    if (value) {
      _viewport?.navigator.focusWindow(_entry!);
    } else {
      _viewport?.navigator.unfocusWindow(_entry!);
    }
  }

  @override
  set maximizable(bool value) {
    if (value != state.maximizable) {
      controller.value = state.copyWith(maximizable: value);
    }
  }

  @override
  set maximized(Rect? value) {
    if (value != state.maximized) {
      controller.value = state.withMaximized(value);
    }
  }

  @override
  set minimizable(bool value) {
    if (value != state.minimizable) {
      controller.value = state.copyWith(minimizable: value);
    }
  }

  @override
  set minimized(bool value) {
    if (value != state.minimized) {
      controller.value = state.copyWith(minimized: value);
    }
  }

  @override
  set resizable(bool value) {
    if (value != state.resizable) {
      controller.value = state.copyWith(resizable: value);
    }
  }
}

class WindowNavigator extends StatefulWidget {
  final List<Window> initialWindows;
  final Widget? child;
  final bool showTopSnapBar;

  const WindowNavigator({
    super.key,
    required this.initialWindows,
    this.child,
    this.showTopSnapBar = true,
  });

  @override
  State<WindowNavigator> createState() => _WindowNavigatorState();
}

class Window {
  final Widget? title;
  final Widget? actions;
  final Widget? content;
  final WindowController? controller;
  final Rect? bounds;
  final Rect? maximized;
  final bool? minimized;
  final bool? alwaysOnTop;
  final bool? enableSnapping;
  final bool? resizable;
  final bool? draggable;
  final bool? closable;
  final bool? maximizable;
  final bool? minimizable;
  final BoxConstraints? constraints;

  final GlobalKey<_WindowWidgetState> _key = GlobalKey<_WindowWidgetState>(
    debugLabel: 'Window',
  );

  final ValueNotifier<bool> closed = ValueNotifier(false);

  Window.controlled({
    this.title,
    this.actions = const WindowActions(),
    this.content,
    required this.controller,
  })  : bounds = null,
        maximized = null,
        minimized = null,
        alwaysOnTop = null,
        resizable = null,
        draggable = null,
        maximizable = null,
        minimizable = null,
        enableSnapping = null,
        closable = null,
        constraints = null;

  Window({
    this.title,
    this.actions = const WindowActions(),
    this.content,
    bool this.resizable = true,
    bool this.draggable = true,
    bool this.closable = true,
    bool this.maximizable = true,
    bool this.minimizable = true,
    bool this.enableSnapping = true,
    required this.bounds,
    this.maximized,
    bool this.minimized = false,
    bool this.alwaysOnTop = false,
    BoxConstraints this.constraints = kDefaultWindowConstraints,
  }) : controller = null;

  WindowHandle get handle {
    var currentState = _key.currentState;
    assert(currentState != null, 'Window is not mounted');
    return currentState!;
  }

  bool get mounted => _key.currentContext != null;

  Widget _build(
      {required bool focused,
      required WindowNavigatorHandle navigator,
      required bool alwaysOnTop,
      required Size size,
      required bool minifyDragging,
      bool ignorePointer = false}) {
    return ListenableBuilder(
        listenable: closed,
        child: Data.inherit(
          data: this,
          child: WindowWidget._raw(
            key: _key,
            title: title,
            actions: actions,
            content: content,
            resizable: resizable,
            draggable: draggable,
            closable: closable,
            maximizable: maximizable,
            minimizable: minimizable,
            enableSnapping: enableSnapping,
            controller: controller,
            bounds: bounds,
            maximized: maximized,
            minimized: minimized,
            constraints: constraints,
          ),
        ),
        builder: (context, child) {
          return Data.inherit(
            data: WindowViewport(
              ignorePointer: ignorePointer,
              size: size,
              navigator: navigator,
              focused: focused,
              alwaysOnTop: alwaysOnTop,
              closed: closed.value,
              minify: minifyDragging,
            ),
            child: child,
          );
        });
  }
}

mixin WindowNavigatorHandle on State<WindowNavigator> {
  void pushWindow(Window window);
  void focusWindow(Window window);
  void unfocusWindow(Window window);
  void setAlwaysOnTop(Window window, bool value);
  void removeWindow(Window window);
  bool isFocused(Window window);
  List<Window> get windows;

  _WindowNavigatorState get _state {
    return this as _WindowNavigatorState;
  }
}

const kDefaultWindowConstraints = BoxConstraints(
  minWidth: 200,
  minHeight: 200,
);

class _DraggingWindow {
  final Window window;
  final Offset cursorPosition;

  _DraggingWindow(this.window, this.cursorPosition);
}

class _WindowLayerGroup extends StatelessWidget {
  final BoxConstraints constraints;
  final List<Window> windows;
  final _WindowNavigatorState handle;
  final bool alwaysOnTop;
  final bool showTopSnapBar;

  const _WindowLayerGroup(
      {required this.constraints,
      required this.windows,
      required this.handle,
      required this.alwaysOnTop,
      required this.showTopSnapBar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createPaneSnapStrategy = handle._createPaneSnapStrategy;
    return GroupWidget(
      children: [
        for (int i = windows.length - 1; i >= 0; i--)
          if (windows[i] != handle._draggingWindow.value?.window)
            windows[i]._build(
                size: constraints.biggest,
                navigator: handle,
                focused: i == 0,
                alwaysOnTop: false,
                ignorePointer: false,
                minifyDragging: handle._snappingStrategy.value != null &&
                    handle._snappingStrategy.value!.shouldMinifyWindow &&
                    handle._draggingWindow.value != null &&
                    handle._draggingWindow.value!.window == windows[i]),
        if (handle._snappingStrategy.value != null &&
            handle._draggingWindow.value != null &&
            handle._draggingWindow.value!.window.alwaysOnTop == alwaysOnTop)
          GroupPositioned.fromRect(
            rect: Rect.fromLTWH(
              handle._snappingStrategy.value!.relativeBounds.left *
                  constraints.biggest.width,
              handle._snappingStrategy.value!.relativeBounds.top *
                  constraints.biggest.height,
              handle._snappingStrategy.value!.relativeBounds.width *
                  constraints.biggest.width,
              handle._snappingStrategy.value!.relativeBounds.height *
                  constraints.biggest.height,
            ),
            child: _BlurContainer(
              key: ValueKey(handle._snappingStrategy.value),
            ),
          ),
        if (showTopSnapBar)
          ListenableBuilder(
              listenable: handle._hoveringTopSnapper,
              builder: (context, _) {
                return GroupPositioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: MouseRegion(
                      onEnter: (_) {
                        handle._hoveringTopSnapper.value = true;
                      },
                      onExit: (_) {
                        handle._hoveringTopSnapper.value = false;
                        handle._snappingStrategy.value = null;
                      },
                      hitTestBehavior: HitTestBehavior.translucent,
                      child: AnimatedValueBuilder(
                        value: handle._draggingWindow.value == null ||
                                handle._draggingWindow.value!.window
                                        .alwaysOnTop !=
                                    alwaysOnTop
                            ? -1.0
                            : handle._hoveringTopSnapper.value
                                ? 0.0
                                : -0.85,
                        duration: handle._hoveringTopSnapper.value
                            ? const Duration(milliseconds: 300)
                            : kDefaultDuration,
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(
                                0,
                                unlerpDouble(value, -1.0, 0.0).clamp(0, 1) *
                                    24),
                            child: FractionalTranslation(
                                translation: Offset(0, value),
                                child: OutlinedContainer(
                                  height: 100,
                                  padding:
                                      const EdgeInsets.all(8) * theme.scaling,
                                  child: Opacity(
                                    opacity: unlerpDouble(value, -0.85, 0.0)
                                        .clamp(0, 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8 * theme.scaling,
                                      children: [
                                        // 0.5 | 0.5
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.5, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 0.7 | 0.3
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.7, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.7, 0, 0.3, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // (0.5, 1) | (0.5, 0.5)
                                        //          | (0.5, 0.5)
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0.0, 0.5, 1.0),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 0.5),
                                                  ),
                                                  bottomLeft: true,
                                                  bottomRight: true,
                                                  topLeft: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // (0.5, 0.5) | (0.5, 0.5)
                                        // (0.5, 0.5) | (0.5, 0.5)
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 0.5, 0.5),
                                                  ),
                                                  bottomRight: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0, 0.5, 0.5),
                                                  ),
                                                  bottomLeft: true,
                                                  topLeft: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0.5, 0.5, 0.5, 0.5),
                                                  ),
                                                  topLeft: true,
                                                  topRight: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 1/3 | 1/3 | 1/3
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 1 / 3, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            1 / 3, 0, 1 / 3, 1),
                                                  ),
                                                  allLeft: true,
                                                  allRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            2 / 3, 0, 1 / 3, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        // 2/7 | 3/7 | 2/7
                                        AspectRatio(
                                          aspectRatio:
                                              constraints.biggest.width /
                                                  constraints.biggest.height,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            final size = constraints.biggest;
                                            return GroupWidget(
                                              children: [
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            0, 0, 2 / 7, 1),
                                                  ),
                                                  topRight: true,
                                                  bottomRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            2 / 7, 0, 3 / 7, 1),
                                                  ),
                                                  allLeft: true,
                                                  allRight: true,
                                                ),
                                                createPaneSnapStrategy(
                                                  size,
                                                  theme,
                                                  const WindowSnapStrategy(
                                                    relativeBounds:
                                                        Rect.fromLTWH(
                                                            5 / 7, 0, 2 / 7, 1),
                                                  ),
                                                  topLeft: true,
                                                  bottomLeft: true,
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
        if (handle._draggingWindow.value != null &&
            handle._draggingWindow.value!.window.alwaysOnTop == alwaysOnTop)
          handle._draggingWindow.value!.window._build(
            size: constraints.biggest,
            navigator: handle,
            focused: true,
            alwaysOnTop: handle._draggingWindow.value!.window.alwaysOnTop ??
                handle._draggingWindow.value!.window.controller?.value
                    .alwaysOnTop ??
                false,
            minifyDragging: handle._snappingStrategy.value != null &&
                handle._snappingStrategy.value!.shouldMinifyWindow,
            ignorePointer: true,
          ),
      ],
    );
  }
}

class _WindowNavigatorState extends State<WindowNavigator>
    with WindowNavigatorHandle {
  late List<Window> _windows;
  late List<Window> _topWindows;
  int _focusLayer = 0; // 0: background, 1: foreground, 2: foremost

  final ValueNotifier<_DraggingWindow?> _draggingWindow =
      ValueNotifier<_DraggingWindow?>(null);
  final ValueNotifier<bool> _hoveringTopSnapper = ValueNotifier(false);
  final ValueNotifier<WindowSnapStrategy?> _snappingStrategy =
      ValueNotifier(null);

  void _startDraggingWindow(Window draggingWindow, Offset cursorPosition) {
    if (_draggingWindow.value != null) return;
    _draggingWindow.value = _DraggingWindow(draggingWindow, cursorPosition);
  }

  void _updateDraggingWindow(Window handle, Offset cursorPosition) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    _draggingWindow.value =
        _DraggingWindow(_draggingWindow.value!.window, cursorPosition);
  }

  void _stopDraggingWindow(Window handle) {
    if (_draggingWindow.value == null ||
        _draggingWindow.value!.window != handle) {
      return;
    }
    var snapping = _snappingStrategy.value;
    if (snapping != null && handle.mounted) {
      handle.handle.maximized = snapping.relativeBounds;
    }
    _draggingWindow.value = null;
    _hoveringTopSnapper.value = false;
    _snappingStrategy.value = null;
  }

  @override
  List<Window> get windows => UnmodifiableListView(_windows + _topWindows);

  @override
  void initState() {
    super.initState();
    _windows = [];
    _topWindows = [];
    for (var window in widget.initialWindows) {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.add(window);
      } else {
        _windows.add(window);
      }
    }
  }

  @override
  bool isFocused(Window window) {
    if (_focusLayer == 0) return false;
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      if (_focusLayer == 1) return false;
      int index = _topWindows.indexOf(window);
      return index == 0;
    } else {
      if (_focusLayer == 2) return false;
      int index = _windows.indexOf(window);
      return index == 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return ListenableBuilder(
          listenable: Listenable.merge([
            _draggingWindow,
            _snappingStrategy,
          ]),
          builder: (context, child) {
            return ClipRect(
              child: GroupWidget(
                children: [
                  Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (_) {
                      if (_focusLayer != 0) {
                        setState(() {
                          _focusLayer = 0;
                        });
                      }
                    },
                    child: widget.child,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _windows,
                    handle: this,
                    alwaysOnTop: false,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  _WindowLayerGroup(
                    constraints: constraints,
                    windows: _topWindows,
                    handle: this,
                    alwaysOnTop: true,
                    showTopSnapBar: widget.showTopSnapBar,
                  ),
                  GroupPositioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 32 * theme.scaling,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 1, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: 32 * theme.scaling,
                      bottom: 0,
                      left: 0,
                      width: 32 * theme.scaling,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                  GroupPositioned(
                      top: 32 * theme.scaling,
                      bottom: 0,
                      right: 0,
                      width: 32 * theme.scaling,
                      child: _createBorderSnapStrategy(const WindowSnapStrategy(
                        relativeBounds: Rect.fromLTWH(0.5, 0, 0.5, 1),
                        shouldMinifyWindow: false,
                      ))),
                ],
              ),
            );
          });
    });
  }

  Widget _createBorderSnapStrategy(WindowSnapStrategy snapStrategy) {
    return MouseRegion(
      opaque: false,
      hitTestBehavior: HitTestBehavior.translucent,
      onHover: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onEnter: (event) {
        _snappingStrategy.value = snapStrategy;
      },
      onExit: (event) {
        _snappingStrategy.value = null;
      },
    );
  }

  Widget _createPaneSnapStrategy(
      Size size, ThemeData theme, WindowSnapStrategy snapStrategy,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRight = false,
      bool allLeft = false,
      bool allRight = false,
      bool allTop = false,
      bool allBottom = false}) {
    const double gap = 2;
    var left = snapStrategy.relativeBounds.left * size.width;
    var top = snapStrategy.relativeBounds.top * size.height;
    var width = snapStrategy.relativeBounds.width * size.width;
    var height = snapStrategy.relativeBounds.height * size.height;
    if (topLeft && topRight) {
      top += gap;
      height -= gap;
      if (bottomLeft) {
        left += gap;
        width -= gap;
      } else if (bottomRight) {
        width -= gap;
      }
    } else if (bottomLeft && bottomRight) {
      height -= gap;
      if (topLeft) {
        left += gap;
        width -= gap;
      } else if (topRight) {
        width -= gap;
      }
    } else if (topLeft && bottomLeft) {
      left += gap;
      width -= gap;
      if (topRight) {
        top += gap;
        height -= gap;
      } else if (bottomRight) {
        height -= gap;
      }
    } else if (topRight && bottomRight) {
      width -= gap;
      if (topLeft) {
        top += gap;
        height -= gap;
      } else if (bottomLeft) {
        height -= gap;
      }
    } else if (allLeft && allRight) {
      left += gap;
      width -= gap * 2;
      if (allTop) {
        top += gap;
        height -= gap;
      } else if (allBottom) {
        height -= gap;
      }
    } else if (allTop && allBottom) {
      top += gap;
      height -= gap * 2;
      if (allLeft) {
        left += gap;
        width -= gap;
      } else if (allRight) {
        width -= gap;
      }
    }
    return GroupPositioned.fromRect(
      rect: Rect.fromLTWH(
        left,
        top,
        width,
        height,
      ),
      child: _SnapHover(
        topLeft: topLeft || allLeft || allTop,
        topRight: topRight || allRight || allTop,
        bottomLeft: bottomLeft || allLeft || allBottom,
        bottomRight: bottomRight || allRight || allBottom,
        hovering: (value) {
          if (value) {
            _snappingStrategy.value = snapStrategy;
          }
        },
      ),
    );
  }

  @override
  void focusWindow(Window window) {
    if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
      _topWindows.remove(window);
      _topWindows.insert(0, window);
      _focusLayer = 2;
    } else {
      _windows.remove(window);
      _windows.insert(0, window);
      _focusLayer = 1;
    }
    setState(() {});
  }

  @override
  void pushWindow(Window window) {
    setState(() {
      if (window.alwaysOnTop ?? window.controller?.value.alwaysOnTop ?? false) {
        _topWindows.insert(0, window);
      } else {
        _windows.insert(0, window);
      }
    });
  }

  @override
  void removeWindow(Window window) {
    setState(() {
      _windows.remove(window);
      _topWindows.remove(window);
    });
  }

  @override
  void setAlwaysOnTop(Window window, bool value) {
    if (value && _windows.contains(window)) {
      _windows.remove(window);
      _topWindows.add(window);
    } else if (!value && _topWindows.contains(window)) {
      _topWindows.remove(window);
      _windows.add(window);
    }
  }

  @override
  void unfocusWindow(Window window) {
    _focusLayer = 0;
  }
}

class _SnapHover extends StatefulWidget {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;
  final ValueChanged<bool> hovering;

  const _SnapHover({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
    required this.hovering,
  });

  @override
  State<_SnapHover> createState() => _SnapHoverState();
}

class _SnapHoverState extends State<_SnapHover> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onHover: (_) {
        setState(() {
          _hovering = true;
          widget.hovering(true);
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
          widget.hovering(false);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              _hovering ? theme.colorScheme.secondary : theme.colorScheme.card,
          border: Border.all(
            color: theme.colorScheme.border,
          ),
          borderRadius: BorderRadius.only(
            topLeft:
                widget.topLeft ? theme.radiusSmRadius : theme.radiusLgRadius,
            topRight:
                widget.topRight ? theme.radiusSmRadius : theme.radiusLgRadius,
            bottomLeft:
                widget.bottomLeft ? theme.radiusSmRadius : theme.radiusLgRadius,
            bottomRight: widget.bottomRight
                ? theme.radiusSmRadius
                : theme.radiusLgRadius,
          ),
        ),
      ),
    );
  }
}

class WindowViewport {
  final Size size;
  final WindowNavigatorHandle navigator;
  final bool focused;
  final bool alwaysOnTop;
  final bool closed;
  final bool minify;
  final bool ignorePointer;

  const WindowViewport({
    required this.size,
    required this.navigator,
    required this.focused,
    required this.alwaysOnTop,
    required this.closed,
    required this.minify,
    required this.ignorePointer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WindowViewport) return false;
    return size == other.size &&
        navigator == other.navigator &&
        focused == other.focused &&
        alwaysOnTop == other.alwaysOnTop &&
        closed == other.closed &&
        minify == other.minify;
  }

  @override
  int get hashCode =>
      Object.hash(size, navigator, focused, alwaysOnTop, closed, minify);
}

class WindowActions extends StatelessWidget {
  const WindowActions({super.key});

  @override
  Widget build(BuildContext context) {
    WindowHandle? handle = Data.maybeOf<WindowHandle>(context);
    WindowViewport? viewport = Data.maybeOf<WindowViewport>(context);
    return Row(
      children: [
        if (handle?.minimizable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.minimize),
            size: ButtonSize.small,
            onPressed: () {
              handle?.minimized = !handle.minimized;
            },
          ),
        if (handle?.maximizable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.crop_square),
            size: ButtonSize.small,
            onPressed: () {
              if (handle != null) {
                if (handle.maximized != null) {
                  handle.maximized = null;
                } else {
                  handle.maximized = viewport?.navigator._state
                          ._snappingStrategy.value?.relativeBounds ??
                      const Rect.fromLTWH(0, 0, 1, 1);
                }
              }
            },
          ),
        if (handle?.closable ?? true)
          IconButton.ghost(
            icon: const Icon(Icons.close),
            size: ButtonSize.small,
            onPressed: () {
              handle?.close();
            },
          )
      ],
    );
  }
}

class _BlurContainer extends StatelessWidget {
  const _BlurContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedValueBuilder(
        initialValue: 0.0,
        value: 1.0,
        duration: kDefaultDuration,
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: lerpDouble(0.8, 1.0, value)!,
              child: Padding(
                padding: const EdgeInsets.all(8) * theme.scaling,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.border,
                        ),
                        color: theme.colorScheme.card.withAlpha(100),
                        borderRadius: theme.borderRadiusMd,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
