import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

String colorToHex(Color color, [bool showAlpha = true]) {
  if (showAlpha) {
    return '#${color.value.toRadixString(16)}';
  } else {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

class ColorHistoryGrid extends StatelessWidget {
  final ColorHistoryStorage storage;
  final ValueChanged<Color>? onColorPicked;
  final double? spacing;
  final int crossAxisCount;
  final Color? selectedColor;

  const ColorHistoryGrid({
    super.key,
    required this.storage,
    this.onColorPicked,
    this.spacing,
    this.crossAxisCount = 10,
    this.selectedColor,
  });

  Widget _buildGridTile(BuildContext context, Color? color, ThemeData theme) {
    if (color == null) {
      return const AspectRatio(
        aspectRatio: 1,
        child: Button(
          style: ButtonStyle.outline(
            density: ButtonDensity.compact,
          ),
          child: Icon(Icons.close),
        ),
      );
    }
    return Container(
      decoration: selectedColor != null && color == selectedColor
          ? BoxDecoration(
              border: Border.all(
                  color: theme.colorScheme.primary, width: 2 * theme.scaling),
              borderRadius: BorderRadius.circular(theme.radiusMd),
            )
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: Button(
          style: const ButtonStyle.outline(
            density: ButtonDensity.compact,
          ),
          onPressed: () {
            onColorPicked?.call(color);
          },
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double spacing = this.spacing ?? (4 * theme.scaling);
    return ListenableBuilder(
        listenable: storage,
        builder: (context, child) {
          List<Widget> rows = [];
          for (int i = 0; i < storage.capacity; i += crossAxisCount) {
            List<Widget> tiles = [];
            for (int j = 0; j < crossAxisCount; j++) {
              final index = i + j;
              final color = index < storage.recentColors.length
                  ? storage.recentColors[index]
                  : null;
              if (index >= storage.capacity) {
                tiles.add(
                  const Expanded(
                    child: SizedBox(),
                  ),
                );
              } else {
                tiles.add(
                  Expanded(
                    child: _buildGridTile(context, color, theme),
                  ),
                );
              }
              if (j < crossAxisCount - 1) {
                tiles.add(Gap(spacing));
              }
            }
            rows.add(IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: tiles,
              ),
            ));
            if (i < storage.capacity - crossAxisCount) {
              rows.add(Gap(spacing));
            }
          }
          return IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rows,
            ),
          );
        }).constrained(
      minHeight: 100,
    );
  }
}

enum ColorPickerMode {
  rgb,
  hsl,
  hsv,
}

abstract class ColorHistoryStorage implements Listenable {
  void addHistory(Color color);
  void setHistory(List<Color> colors);
  void clear();
  int get capacity;
  List<Color> get recentColors;
  static ColorHistoryStorage of(BuildContext context) {
    return Data.of<ColorHistoryStorage>(context);
  }
}

class RecentColorsScope extends StatefulWidget {
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final Widget child;

  const RecentColorsScope({
    super.key,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    required this.child,
  });

  @override
  State<RecentColorsScope> createState() => RecentColorsScopeState();
}

class _ColorListNotifier extends ChangeNotifier {
  List<Color> _recentColors;

  _ColorListNotifier(this._recentColors);

  void _notify() {
    notifyListeners();
  }
}

class RecentColorsScopeState extends State<RecentColorsScope>
    implements ColorHistoryStorage {
  late _ColorListNotifier _recentColors;

  @override
  int get capacity => widget.maxRecentColors;

  @override
  void initState() {
    super.initState();
    _recentColors = _ColorListNotifier(List.from(widget.initialRecentColors));
  }

  @override
  List<Color> get recentColors =>
      List.unmodifiable(_recentColors._recentColors);

  @override
  void addHistory(Color color) {
    var recentColors = _recentColors._recentColors;
    if (recentColors.contains(color)) {
      recentColors.remove(color);
    }
    recentColors.insert(0, color);
    if (recentColors.length > widget.maxRecentColors) {
      recentColors.removeLast();
    }
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void dispose() {
    super.dispose();
    _recentColors.dispose();
  }

  @override
  void clear() {
    _recentColors._recentColors.clear();
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void setHistory(List<Color> colors) {
    _recentColors._recentColors = colors;
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  Widget build(BuildContext context) {
    return Data<ColorHistoryStorage>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void addListener(VoidCallback listener) {
    _recentColors.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _recentColors.removeListener(listener);
  }
}

typedef PreviewLabelBuilder = Widget Function(
    BuildContext context, Color color);

class ColorPickingLayer extends StatefulWidget {
  final Widget child;
  final AlignmentGeometry? previewAlignment;
  final bool showPreview;
  final Size? previewSize;
  final double previewScale;
  final PreviewLabelBuilder? previewLabelBuilder;

  const ColorPickingLayer({
    super.key,
    required this.child,
    this.previewAlignment,
    this.showPreview = true,
    this.previewSize,
    this.previewScale = 8,
    this.previewLabelBuilder,
  });

  @override
  State<ColorPickingLayer> createState() => _ColorPickingLayerState();
}

class _ScreenshotResult {
  final List<Color> colors;
  final Size size;
  final ImageProvider? image;

  _ScreenshotResult(this.colors, this.size, this.image);

  Color operator [](Offset position) {
    int index =
        (position.dy.floor() * size.width + position.dx.floor()).toInt();
    return colors[index];
  }
}

class _ScreenshotImage extends ImageProvider<_ScreenshotImage> {
  _ScreenshotImage(this.bytes, this.width, this.height, this.format);

  final Uint8List bytes;
  final int width;
  final int height;
  final ui.PixelFormat format;

  @override
  Future<_ScreenshotImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_ScreenshotImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      _ScreenshotImage key, ImageDecoderCallback decode) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(bytes, width, height, format, completer.complete);
    return OneFrameImageStreamCompleter(
        completer.future.then((ui.Image image) => ImageInfo(image: image)));
  }
}

class _ColorPickingCompleter {
  final Completer<Color?> completer;
  final Set<ColorHistoryStorage> recentColorsScope;

  _ColorPickingCompleter(this.completer, this.recentColorsScope);
}

class _ColorPickingLayerState extends State<ColorPickingLayer>
    implements ColorPickingLayerScope {
  final GlobalKey _repaintKey = GlobalKey();
  _ScreenshotResult? _currentPicking;
  ColorPickingResult? _preview;
  Offset? _currentPosition;
  _ColorPickingCompleter? _session;

  Widget _buildPreviewLabel(BuildContext context, Color color) {
    if (widget.previewLabelBuilder != null) {
      return widget.previewLabelBuilder!(context, color);
    }
    return Text(colorToHex(color, false)).small().muted();
  }

  @override
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]) async {
    if (!mounted) {
      return Future.value(null);
    }
    if (_session != null) {
      if (historyStorage != null &&
          _session!.recentColorsScope.add(historyStorage)) {
        return _session!.completer.future.then((value) {
          if (value != null) {
            historyStorage.addHistory(value);
          }
          return value;
        });
      }
      return _session!.completer.future;
    }
    final completer = Completer<Color?>();
    final screenshot = await _screenshotWidget();
    setState(() {
      _session = _ColorPickingCompleter(
        completer,
        historyStorage != null ? {historyStorage} : {},
      );
      _currentPicking = screenshot;
    });
    final result = await completer.future;
    if (historyStorage != null && result != null) {
      historyStorage.addHistory(result);
    }
    return result;
  }

  Future<_ScreenshotResult?> _screenshotWidget() async {
    final currentContext = _repaintKey.currentContext;
    if (currentContext == null) return null;
    final boundary = currentContext.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return null;
    final colors = <Color>[];
    for (int i = 0; i < byteData.lengthInBytes; i += 4) {
      final r = byteData.getUint8(i);
      final g = byteData.getUint8(i + 1);
      final b = byteData.getUint8(i + 2);
      final a = byteData.getUint8(i + 3);
      colors.add(Color.fromARGB(a, r, g, b));
    }
    final img = _ScreenshotImage(byteData.buffer.asUint8List(), image.width,
        image.height, ui.PixelFormat.rgba8888);
    return _ScreenshotResult(
        colors, Size(image.width.toDouble(), image.height.toDouble()), img);
  }

  ColorPickingResult? _getPreview(Offset globalPosition, Size size) {
    final image = _currentPicking;
    if (image == null) return null;
    final colors = <Color>[];
    for (int y = -size.height ~/ 2; y < size.height ~/ 2; y++) {
      for (int x = -size.width ~/ 2; x < size.width ~/ 2; x++) {
        final localPosition =
            globalPosition.translate(x.toDouble(), y.toDouble());
        if (localPosition.dx < 0 ||
            localPosition.dy < 0 ||
            localPosition.dx >= image.size.width ||
            localPosition.dy >= image.size.height) {
          colors.add(Colors.transparent);
        } else {
          colors.add(image[localPosition]);
        }
      }
    }
    final globalIndex = globalPosition.dy.floor() * image.size.width.floor() +
        globalPosition.dx.floor();
    final pickedColor = image.colors[globalIndex];
    return ColorPickingResult(colors, size, pickedColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final previewSize =
        widget.previewSize ?? const Size(100, 100) * theme.scaling;
    return Data<ColorPickingLayerScope>.inherit(
      data: this,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: _preview != null && _session != null
            ? (details) async {
                _session!.completer.complete(_preview!.pickedColor);
                if (mounted) {
                  setState(() {
                    _session = null;
                    _preview = null;
                    _currentPicking = null;
                    _currentPosition = null;
                  });
                }
              }
            : null,
        child: MouseRegion(
          hitTestBehavior: HitTestBehavior.translucent,
          onHover: _session != null
              ? (details) {
                  setState(() {
                    _preview = _getPreview(
                      details.localPosition,
                      previewSize / widget.previewScale,
                    );
                    _currentPosition = details.localPosition;
                  });
                }
              : null,
          child: IgnorePointer(
            ignoring: _session != null,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                RepaintBoundary(
                  key: _repaintKey,
                  child: widget.child,
                ),
                if (_currentPicking != null)
                  Positioned.fill(
                      child: Image(
                    image: _currentPicking!.image!,
                    fit: BoxFit.fill,
                  )),
                if (widget.showPreview &&
                    _preview != null &&
                    widget.previewAlignment != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.all(theme.scaling * 32),
                      child: Align(
                        alignment: widget.previewAlignment!,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          fit: StackFit.passthrough,
                          children: [
                            SizedBox(
                              width: previewSize.width,
                              height: previewSize.height,
                              child: CustomPaint(
                                painter: _ColorPreviewPainter(
                                  _preview!.colors,
                                  _preview!.size,
                                  theme.colorScheme.border,
                                  1 * theme.scaling,
                                  theme.colorScheme.primary,
                                  2 * theme.scaling,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -18 * theme.scaling,
                              child: _buildPreviewLabel(
                                context,
                                _preview!.pickedColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.showPreview &&
                    _preview != null &&
                    widget.previewAlignment == null)
                  Positioned(
                    top: _currentPosition!.dy,
                    left: _currentPosition!.dx,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      fit: StackFit.passthrough,
                      children: [
                        SizedBox(
                          width: previewSize.width,
                          height: previewSize.height,
                          child: CustomPaint(
                            painter: _ColorPreviewPainter(
                              _preview!.colors,
                              _preview!.size,
                              theme.colorScheme.border,
                              1 * theme.scaling,
                              theme.colorScheme.primary,
                              2 * theme.scaling,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -18 * theme.scaling,
                          child: _buildPreviewLabel(
                            context,
                            _preview!.pickedColor,
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Color?> pickColorFromScreen(BuildContext context,
    [ColorHistoryStorage? storage]) {
  final scope = ColorPickingLayerScope.find(context);
  return scope.promptPickColor(storage);
}

class _ColorPreviewPainter extends CustomPainter {
  final List<Color> colors;
  final Size size;
  final Color borderColor;
  final double borderWidth;
  final Color selectedBorderColor;
  final double selectedBorderWidth;

  _ColorPreviewPainter(
    this.colors,
    this.size,
    this.borderColor,
    this.borderWidth,
    this.selectedBorderColor,
    this.selectedBorderWidth,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // clip it to circle
    final clipPath = Path()
      ..addOval(Rect.fromLTWH(
          0, 0, size.width.floorToDouble(), size.height.floorToDouble()));
    canvas.clipPath(clipPath);
    final paint = Paint();
    final cellSize = Size(size.width.floor() / this.size.width.floor(),
        size.height.floor() / this.size.height.floor());
    for (int y = 0; y < this.size.height.floor(); y++) {
      for (int x = 0; x < this.size.width.floor(); x++) {
        final color = colors[y * this.size.width.floor() + x];
        paint.color = color;
        paint.style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromLTWH(
              (x * cellSize.width).floorToDouble(),
              (y * cellSize.height).floorToDouble(),
              cellSize.width.floorToDouble(),
              cellSize.height.floorToDouble()),
          paint,
        );
        paint.color = borderColor;
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = borderWidth;
        // draw a border
        canvas.drawRect(
          Rect.fromLTWH(
                  (x * cellSize.width).floorToDouble(),
                  (y * cellSize.height).floorToDouble(),
                  cellSize.width.floorToDouble(),
                  cellSize.height.floorToDouble())
              .inflate(paint.strokeWidth / 2),
          paint,
        );
      }
    }
    // draw a rect for the selected color at center
    paint.color = selectedBorderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = selectedBorderWidth;
    final centerX = size.width ~/ 2;
    final centerY = size.height ~/ 2;
    final cellX = centerX ~/ cellSize.width;
    final cellY = centerY ~/ cellSize.height;
    canvas.drawRect(
      Rect.fromLTWH(
        (cellX * cellSize.width).floorToDouble(),
        (cellY * cellSize.height).floorToDouble(),
        cellSize.width.floorToDouble(),
        cellSize.height.floorToDouble(),
      ),
      paint,
    );
    // add circle border, and make sure it is not clipped
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = borderWidth;
    canvas.drawOval(
        Rect.fromLTWH(
            0, 0, size.width.floorToDouble(), size.height.floorToDouble()),
        paint);
  }

  @override
  bool shouldRepaint(covariant _ColorPreviewPainter oldDelegate) {
    return !listEquals(oldDelegate.colors, colors) ||
        oldDelegate.size != size ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.selectedBorderColor != selectedBorderColor ||
        oldDelegate.selectedBorderWidth != selectedBorderWidth;
  }
}

abstract class ColorPickingLayerScope {
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);
  static ColorPickingLayerScope findRoot(BuildContext context) {
    return Data.findRoot<ColorPickingLayerScope>(context);
  }

  static ColorPickingLayerScope find(BuildContext context) {
    return Data.find<ColorPickingLayerScope>(context);
  }
}

class ColorPickingResult {
  final Size size;
  final List<Color> colors;
  final Color pickedColor;

  const ColorPickingResult(this.colors, this.size, this.pickedColor);

  Color operator [](Offset position) {
    int index =
        (position.dy.floor() * size.width + position.dx.floor()).toInt();
    return colors[index];
  }
}

class ColorInputSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final ColorPickerMode mode;
  final ValueChanged<ColorPickerMode>? onModeChanged;
  final VoidCallback? onPickFromScreen;
  final ColorHistoryStorage? storage;

  const ColorInputSet({
    super.key,
    required this.color,
    this.onChanged,
    this.onColorChangeEnd,
    this.showAlpha = true,
    this.mode = ColorPickerMode.rgb,
    this.onModeChanged,
    this.onPickFromScreen,
    this.storage,
  });

  @override
  State<ColorInputSet> createState() => _ColorInputSetState();
}

class _ColorInputSetState extends State<ColorInputSet> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Tabs(
                index: _tabIndex,
                onChanged: (value) {
                  setState(() {
                    _tabIndex = value;
                  });
                },
                tabs: [
                  Text(localizations.colorPickerTabRGB),
                  Text(localizations.colorPickerTabHSL),
                  Text(localizations.colorPickerTabHSV),
                  if (widget.storage != null)
                    Text(localizations.colorPickerTabRecent),
                ]),
            Gap(theme.scaling * 16),
            _buildContent(context, theme, constraints.maxWidth),
          ],
        ),
      );
    });
  }

  Widget _buildContent(BuildContext context, ThemeData theme, double width) {
    switch (_tabIndex) {
      case 0:
        return _buildColorTab(context, ColorPickerMode.rgb, width);
      case 1:
        return _buildColorTab(context, ColorPickerMode.hsl, width);
      case 2:
        return _buildColorTab(context, ColorPickerMode.hsv, width);
      case 3:
      default:
        return _buildRecentTab(context);
    }
  }

  Widget _buildRecentTab(BuildContext context) {
    if (widget.storage == null) {
      return const SizedBox();
    }
    return ColorHistoryGrid(
      selectedColor: widget.color.toColor(),
      storage: widget.storage!,
      onColorPicked: (value) {
        var derivative = ColorDerivative.fromColor(value);
        widget.onChanged?.call(derivative);
        widget.onColorChangeEnd?.call(derivative);
      },
    );
  }

  Widget _buildColorTab(
      BuildContext context, ColorPickerMode mode, double width) {
    if (width < 500) {
      return MiniColorPickerSet(
        key: ValueKey(mode),
        color: widget.color,
        mode: mode,
        onColorChanged: widget.onChanged,
        onColorChangeEnd: (value) {
          widget.onColorChangeEnd?.call(value);
          if (widget.storage != null) {
            widget.storage!.addHistory(value.toColor());
          }
        },
        showAlpha: widget.showAlpha,
        onPickFromScreen: widget.onPickFromScreen,
      );
    }
    return ColorPickerSet(
      key: ValueKey(mode),
      color: widget.color,
      mode: mode,
      onColorChanged: widget.onChanged,
      onColorChangeEnd: (value) {
        widget.onColorChangeEnd?.call(value);
        if (widget.storage != null) {
          widget.storage!.addHistory(value.toColor());
        }
      },
      showAlpha: widget.showAlpha,
      onPickFromScreen: widget.onPickFromScreen,
    );
  }
}

class ColorPickerSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final VoidCallback? onPickFromScreen;
  final ColorPickerMode mode;

  const ColorPickerSet({
    super.key,
    required this.color,
    this.onColorChanged,
    this.onColorChangeEnd,
    this.showAlpha = true,
    this.mode = ColorPickerMode.rgb,
    this.onPickFromScreen,
  });

  @override
  State<ColorPickerSet> createState() => _ColorPickerSetState();
}

class _ColorPickerSetState extends State<ColorPickerSet> {
  ColorDerivative get color => widget.color;
  final TextEditingController _hexController = TextEditingController();
  // Red or Hue
  final TextEditingController _aController = TextEditingController();
  // Green or Saturation
  final TextEditingController _bController = TextEditingController();
  // Blue or Value or Lightness
  final TextEditingController _cController = TextEditingController();
  final TextEditingController _alphaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ColorDerivative color = widget.color;
    var rgbColor = color.toColor();
    if (widget.showAlpha) {
      _hexController.text = '#${rgbColor.value.toRadixString(16)}';
    } else {
      _hexController.text = '#${rgbColor.value.toRadixString(16).substring(2)}';
    }
    switch (widget.mode) {
      case ColorPickerMode.rgb:
        _aController.text = rgbColor.red.toString();
        _bController.text = rgbColor.green.toString();
        _cController.text = rgbColor.blue.toString();
        _alphaController.text = (color.opacity * 255).toInt().toString();
        break;
      case ColorPickerMode.hsl:
        final hsl = color.toHSLColor();
        _aController.text = hsl.hue.toInt().toString();
        _bController.text = (hsl.saturation * 100).toInt().toString();
        _cController.text = (hsl.lightness * 100).toInt().toString();
        _alphaController.text = (color.opacity * 100).toInt().toString();
        break;
      case ColorPickerMode.hsv:
        final hsv = color.toHSVColor();
        _aController.text = hsv.hue.toInt().toString();
        _bController.text = (hsv.saturation * 100).toInt().toString();
        _cController.text = (hsv.value * 100).toInt().toString();
        _alphaController.text = (color.opacity * 100).toInt().toString();
        break;
    }
  }

  @override
  void didUpdateWidget(covariant ColorPickerSet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color || oldWidget.mode != widget.mode) {
      ColorDerivative color = widget.color;
      var rgbColor = color.toColor();
      if (widget.showAlpha) {
        _hexController.text = '#${rgbColor.value.toRadixString(16)}';
      } else {
        _hexController.text =
            '#${rgbColor.value.toRadixString(16).substring(2)}';
      }
      switch (widget.mode) {
        case ColorPickerMode.rgb:
          _aController.text = rgbColor.red.toString();
          _bController.text = rgbColor.green.toString();
          _cController.text = rgbColor.blue.toString();
          _alphaController.text = (color.opacity * 255).toInt().toString();
          break;
        case ColorPickerMode.hsl:
          final hsl = color.toHSLColor();
          _aController.text = hsl.hue.toInt().toString();
          _bController.text = (hsl.saturation * 100).toInt().toString();
          _cController.text = (hsl.lightness * 100).toInt().toString();
          _alphaController.text = (color.opacity * 100).toInt().toString();
          break;
        case ColorPickerMode.hsv:
          final hsv = color.toHSVColor();
          _aController.text = hsv.hue.toInt().toString();
          _bController.text = (hsv.saturation * 100).toInt().toString();
          _cController.text = (hsv.value * 100).toInt().toString();
          _alphaController.text = (color.opacity * 100).toInt().toString();
          break;
      }
    }
  }

  void _onColorChange() {
    String a = _aController.text;
    String b = _bController.text;
    String c = _cController.text;
    String alpha = _alphaController.text;
    if (a.isEmpty || b.isEmpty || c.isEmpty) {
      return;
    }
    if (widget.showAlpha && alpha.isEmpty) {
      return;
    }
    double aValue = double.tryParse(a) ?? 0;
    double bValue = double.tryParse(b) ?? 0;
    double cValue = double.tryParse(c) ?? 0;
    double alphaValue = double.tryParse(alpha) ?? 0;
    switch (widget.mode) {
      case ColorPickerMode.rgb:
        widget.onColorChanged?.call(widget.color.changeToColor(Color.fromARGB(
          alphaValue.round().clamp(0, 255),
          aValue.round().clamp(0, 255),
          bValue.round().clamp(0, 255),
          cValue.round().clamp(0, 255),
        )));
        break;
      case ColorPickerMode.hsl:
        widget.onColorChanged?.call(widget.color.changeToHSL(
          HSLColor.fromAHSL(
            (alphaValue / 100).clamp(0, 1),
            aValue.roundToDouble().clamp(0, 360),
            (bValue / 100).clamp(0, 1),
            (cValue / 100).clamp(0, 1),
          ),
        ));
        break;
      case ColorPickerMode.hsv:
        widget.onColorChanged?.call(widget.color.changeToHSV(
          HSVColor.fromAHSV(
            (alphaValue / 100).clamp(0, 1),
            aValue.roundToDouble().clamp(0, 360),
            (bValue / 100).clamp(0, 1),
            (cValue / 100).clamp(0, 1),
          ),
        ));
        break;
    }
  }

  Widget _wrapTextField({required Widget child}) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 54 * theme.scaling,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    String aLabel;
    String bLabel;
    String cLabel;
    switch (widget.mode) {
      case ColorPickerMode.rgb:
        aLabel = localizations.colorRed;
        bLabel = localizations.colorGreen;
        cLabel = localizations.colorBlue;
        break;
      case ColorPickerMode.hsl:
        aLabel = localizations.colorHue;
        bLabel = localizations.colorSaturation;
        cLabel = localizations.colorLightness;
        break;
      case ColorPickerMode.hsv:
        aLabel = localizations.colorHue;
        bLabel = localizations.colorSaturation;
        cLabel = localizations.colorValue;
        break;
    }
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.border,
                        ),
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: widget.mode == ColorPickerMode.hsl
                          ? HSLColorPickerArea(
                              color: color.toHSLColor(),
                              sliderType: HSLColorSliderType.satLum,
                              reverse: true,
                              onColorChanged: (value) {
                                widget.onColorChanged?.call(widget.color
                                    .changeToHSLSaturation(value.saturation)
                                    .changeToHSLLightness(value.lightness));
                              },
                              onColorEnd: (value) {
                                widget.onColorChangeEnd?.call(widget.color
                                    .changeToHSLSaturation(value.saturation)
                                    .changeToHSLLightness(value.lightness));
                              },
                            )
                          : HSVColorPickerArea(
                              color: color.toHSVColor(),
                              onColorChanged: (value) {
                                widget.onColorChanged?.call(widget.color
                                    .changeToHSVValue(value.value)
                                    .changeToHSVSaturation(value.saturation));
                              },
                              sliderType: HSVColorSliderType.satVal,
                              reverse: true,
                              onColorEnd: (value) {
                                widget.onColorChangeEnd?.call(
                                  widget.color
                                      .changeToHSVValue(value.value)
                                      .changeToHSVSaturation(value.saturation),
                                );
                              },
                            ),
                    ),
                  ),
                ),
                if (widget.onPickFromScreen != null) Gap(theme.scaling * 16),
                if (widget.onPickFromScreen != null)
                  IconButton.outline(
                    onPressed: widget.onPickFromScreen,
                    icon: const Icon(BootstrapIcons.eyedropper),
                  ),
              ],
            ),
          ),
          Gap(theme.scaling * 16),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: theme.scaling * 32,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.border,
                      ),
                      borderRadius: BorderRadius.circular(theme.radiusLg),
                    ),
                    child: widget.mode == ColorPickerMode.hsl
                        ? HSLColorPickerArea(
                            color: HSLColor.fromAHSL(
                              color.opacity,
                              color.hslHue,
                              1,
                              0.5,
                            ),
                            onColorEnd: (value) {
                              widget.onColorChangeEnd?.call(
                                  widget.color.changeToHSLHue(value.hue));
                            },
                            sliderType: HSLColorSliderType.hue,
                            radius: Radius.circular(theme.radiusLg),
                            reverse: true,
                            onColorChanged: (value) {
                              widget.onColorChanged?.call(
                                  widget.color.changeToHSLHue(value.hue));
                            },
                          )
                        : HSVColorPickerArea(
                            color: HSVColor.fromAHSV(
                              color.opacity,
                              color.hsvHue,
                              1,
                              1,
                            ),
                            radius: Radius.circular(theme.radiusLg),
                            onColorChanged: (value) {
                              widget.onColorChanged?.call(
                                  widget.color.changeToHSVHue(value.hue));
                            },
                            sliderType: HSVColorSliderType.hue,
                            reverse: true,
                            onColorEnd: (value) {
                              widget.onColorChangeEnd?.call(
                                  widget.color.changeToHSVHue(value.hue));
                            },
                          ),
                  ),
                ),
                if (widget.showAlpha) Gap(theme.scaling * 16),
                // alpha
                if (widget.showAlpha)
                  SizedBox(
                    height: 32 * theme.scaling,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.border,
                        ),
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                      ),
                      child: widget.mode == ColorPickerMode.hsl
                          ? HSLColorPickerArea(
                              color: HSLColor.fromAHSL(
                                color.opacity,
                                color.hslHue,
                                color.hslSat,
                                color.hslVal,
                              ),
                              sliderType: HSLColorSliderType.alpha,
                              reverse: true,
                              radius: Radius.circular(theme.radiusLg),
                              onColorChanged: (value) {
                                widget.onColorChanged?.call(
                                    widget.color.changeToAlpha(value.alpha));
                              },
                              onColorEnd: (value) {
                                widget.onColorChangeEnd?.call(
                                    widget.color.changeToAlpha(value.alpha));
                              },
                            )
                          : HSVColorPickerArea(
                              color: HSVColor.fromAHSV(
                                color.opacity,
                                color.hsvHue,
                                color.hsvSat,
                                color.hsvVal,
                              ),
                              onColorChanged: (value) {
                                widget.onColorChanged?.call(
                                    widget.color.changeToAlpha(value.alpha));
                              },
                              sliderType: HSVColorSliderType.alpha,
                              radius: Radius.circular(theme.radiusLg),
                              reverse: true,
                              onColorEnd: (value) {
                                widget.onColorChangeEnd?.call(
                                  widget.color.changeToAlpha(value.alpha),
                                );
                              },
                            ),
                    ),
                  ),
                Gap(theme.scaling * 16),
                TextField(
                  controller: _hexController,
                  onEditingComplete: () {
                    var hex = _hexController.text;
                    if (hex.startsWith('#')) {
                      hex = hex.substring(1);
                    }
                    Color color;
                    if (hex.length == 6) {
                      color = Color(int.parse('FF$hex', radix: 16));
                    } else if (hex.length == 8) {
                      color = Color(int.parse(hex, radix: 16));
                    } else {
                      color = widget.color.toColor();
                      if (widget.showAlpha) {
                        _hexController.text =
                            '#${color.value.toRadixString(16)}';
                      } else {
                        _hexController.text =
                            '#${color.value.toRadixString(16).substring(2)}';
                      }
                    }
                    widget.onColorChanged
                        ?.call(ColorDerivative.fromColor(color));
                  },
                ),
                Gap(theme.scaling * 16),
                SizedBox(
                  child: Row(
                    children: [
                      _wrapTextField(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(aLabel).muted().small(),
                            Gap(theme.scaling * 4),
                            TextField(
                              controller: _aController,
                              onEditingComplete: _onColorChange,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      _wrapTextField(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(bLabel).muted().small(),
                            Gap(theme.scaling * 4),
                            TextField(
                              controller: _bController,
                              onEditingComplete: _onColorChange,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      _wrapTextField(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(cLabel).muted().small(),
                            Gap(theme.scaling * 4),
                            TextField(
                              controller: _cController,
                              onEditingComplete: _onColorChange,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      if (widget.showAlpha)
                        _wrapTextField(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(localizations.colorAlpha).muted().small(),
                              Gap(theme.scaling * 4),
                              TextField(
                                onEditingComplete: _onColorChange,
                                controller: _alphaController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ).gap(theme.scaling * 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MiniColorPickerSet extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final VoidCallback? onPickFromScreen;
  final ColorPickerMode mode;

  const MiniColorPickerSet({
    super.key,
    required this.color,
    this.onColorChanged,
    this.onColorChangeEnd,
    this.showAlpha = true,
    this.mode = ColorPickerMode.rgb,
    this.onPickFromScreen,
  });

  @override
  State<MiniColorPickerSet> createState() => _MiniColorPickerSetState();
}

class _MiniColorPickerSetState extends State<MiniColorPickerSet> {
  ColorDerivative get color => widget.color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
                borderRadius: BorderRadius.circular(theme.radiusLg),
              ),
              clipBehavior: Clip.antiAlias,
              child: widget.mode == ColorPickerMode.hsl
                  ? HSLColorPickerArea(
                      color: color.toHSLColor(),
                      sliderType: HSLColorSliderType.satLum,
                      reverse: true,
                      onColorChanged: (value) {
                        widget.onColorChanged?.call(widget.color
                            .changeToHSLSaturation(value.saturation)
                            .changeToHSLLightness(value.lightness));
                      },
                      onColorEnd: (value) {
                        widget.onColorChangeEnd?.call(widget.color
                            .changeToHSLSaturation(value.saturation)
                            .changeToHSLLightness(value.lightness));
                      },
                    )
                  : HSVColorPickerArea(
                      color: color.toHSVColor(),
                      onColorChanged: (value) {
                        widget.onColorChanged?.call(widget.color
                            .changeToHSVValue(value.value)
                            .changeToHSVSaturation(value.saturation));
                      },
                      sliderType: HSVColorSliderType.satVal,
                      reverse: true,
                      onColorEnd: (value) {
                        widget.onColorChangeEnd?.call(
                          widget.color
                              .changeToHSVValue(value.value)
                              .changeToHSVSaturation(value.saturation),
                        );
                      },
                    ),
            ),
          ),
          Gap(theme.scaling * 16),
          SizedBox(
            height: theme.scaling * 32,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
                borderRadius: BorderRadius.circular(theme.radiusLg),
              ),
              child: widget.mode == ColorPickerMode.hsl
                  ? HSLColorPickerArea(
                      color: HSLColor.fromAHSL(
                        color.opacity,
                        color.hslHue,
                        1,
                        0.5,
                      ),
                      onColorEnd: (value) {
                        widget.onColorChangeEnd
                            ?.call(widget.color.changeToHSLHue(value.hue));
                      },
                      sliderType: HSLColorSliderType.hue,
                      radius: Radius.circular(theme.radiusLg),
                      reverse: true,
                      onColorChanged: (value) {
                        widget.onColorChanged
                            ?.call(widget.color.changeToHSLHue(value.hue));
                      },
                    )
                  : HSVColorPickerArea(
                      color: HSVColor.fromAHSV(
                        color.opacity,
                        color.hsvHue,
                        1,
                        1,
                      ),
                      radius: Radius.circular(theme.radiusLg),
                      onColorChanged: (value) {
                        widget.onColorChanged
                            ?.call(widget.color.changeToHSVHue(value.hue));
                      },
                      sliderType: HSVColorSliderType.hue,
                      reverse: true,
                      onColorEnd: (value) {
                        widget.onColorChangeEnd
                            ?.call(widget.color.changeToHSVHue(value.hue));
                      },
                    ),
            ),
          ),
          if (widget.showAlpha) Gap(theme.scaling * 16),
          // alpha
          if (widget.showAlpha)
            SizedBox(
              height: 32 * theme.scaling,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.border,
                  ),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: widget.mode == ColorPickerMode.hsl
                    ? HSLColorPickerArea(
                        color: HSLColor.fromAHSL(
                          color.opacity,
                          color.hslHue,
                          1,
                          0.5,
                        ),
                        sliderType: HSLColorSliderType.alpha,
                        reverse: true,
                        radius: Radius.circular(theme.radiusLg),
                        onColorChanged: (value) {
                          widget.onColorChanged
                              ?.call(widget.color.changeToAlpha(value.alpha));
                        },
                        onColorEnd: (value) {
                          widget.onColorChangeEnd
                              ?.call(widget.color.changeToAlpha(value.alpha));
                        },
                      )
                    : HSVColorPickerArea(
                        color: HSVColor.fromAHSV(
                          color.opacity,
                          color.hsvHue,
                          1,
                          1,
                        ),
                        onColorChanged: (value) {
                          widget.onColorChanged
                              ?.call(widget.color.changeToAlpha(value.alpha));
                        },
                        sliderType: HSVColorSliderType.alpha,
                        radius: Radius.circular(theme.radiusLg),
                        reverse: true,
                        onColorEnd: (value) {
                          widget.onColorChangeEnd?.call(
                            widget.color.changeToAlpha(value.alpha),
                          );
                        },
                      ),
              ),
            ),
          if (widget.onPickFromScreen != null) Gap(theme.scaling * 16),
          if (widget.onPickFromScreen != null)
            IconButton.outline(
              onPressed: widget.onPickFromScreen,
              icon: const Icon(BootstrapIcons.eyedropper),
            ),
        ],
      ),
    );
  }
}

class ColorInput extends StatelessWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final bool showAlpha;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? placeholder;
  final PromptMode mode;
  final ColorPickerMode pickerMode;
  final Widget? dialogTitle;
  final bool allowPickFromScreen;
  final bool showLabel;
  final ColorHistoryStorage? storage;

  const ColorInput({
    super.key,
    required this.color,
    this.onChanged,
    this.showAlpha = true,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.pickerMode = ColorPickerMode.rgb,
    this.dialogTitle,
    this.allowPickFromScreen = true,
    this.showLabel = false,
    this.storage,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    return ObjectFormField(
      dialogTitle: dialogTitle,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      value: color,
      mode: mode,
      placeholder: placeholder ?? Text(localizations.placeholderColorPicker),
      onChanged: (value) {
        if (value != null) {
          onChanged?.call(value);
        }
      },
      density: !showLabel ? ButtonDensity.iconDense : ButtonDensity.normal,
      builder: (context, value) {
        if (!showLabel) {
          return Container(
            decoration: BoxDecoration(
              color: value.toColor(),
              border: Border.all(
                color: theme.colorScheme.border,
              ),
              borderRadius: theme.borderRadiusSm,
            ),
          );
        }
        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: Text(colorToHex(value.toColor(), showAlpha))),
              Gap(theme.scaling * 8),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: value.toColor(),
                    border: Border.all(
                      color: theme.colorScheme.border,
                    ),
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      dialogActions: (innerContext, handler) {
        return [
          if (allowPickFromScreen)
            IconButton.outline(
              icon: const Icon(BootstrapIcons.eyedropper),
              onPressed: () async {
                await handler.close();
                if (!context.mounted) return;
                final result = await pickColorFromScreen(context);
                if (result != null) {
                  storage?.addHistory(result);
                }
                handler.prompt(
                    result != null ? ColorDerivative.fromColor(result) : null);
              },
            ),
        ];
      },
      editorBuilder: (innerContext, handler) {
        return ColorInputPopup(
          color: handler.value ?? color,
          onChanged: (value) {
            handler.value = value;
          },
          storage: storage,
          showAlpha: showAlpha,
          initialMode: pickerMode,
          onPickFromScreen: allowPickFromScreen && mode == PromptMode.popover
              ? () async {
                  await handler.close();
                  if (!context.mounted) return;
                  final result = await pickColorFromScreen(context);
                  if (result != null) {
                    storage?.addHistory(result);
                    handler.value = ColorDerivative.fromColor(result);
                  }
                  handler.prompt();
                }
              : null,
        );
      },
    );
  }
}

class ColorInputPopup extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  final VoidCallback? onPickFromScreen;
  final ColorHistoryStorage? storage;

  const ColorInputPopup({
    super.key,
    required this.color,
    this.onChanged,
    this.onColorChangeEnd,
    this.showAlpha = true,
    this.initialMode = ColorPickerMode.rgb,
    this.onPickFromScreen,
    this.storage,
  });

  @override
  State<ColorInputPopup> createState() => _ColorInputPopupState();
}

class _ColorInputPopupState extends State<ColorInputPopup> {
  late ColorPickerMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  @override
  Widget build(BuildContext context) {
    return ColorInputSet(
      color: widget.color,
      onChanged: widget.onChanged,
      showAlpha: widget.showAlpha,
      mode: _mode,
      onModeChanged: (mode) {
        setState(() {
          _mode = mode;
        });
      },
      onPickFromScreen: widget.onPickFromScreen,
      onColorChangeEnd: widget.onColorChangeEnd,
      storage: widget.storage,
    );
  }
}

enum HSVColorSliderType {
  hue,
  hueSat,
  hueVal,
  hueAlpha,
  sat,
  satVal,
  satAlpha,
  val,
  valAlpha,
  alpha;
}

enum HSLColorSliderType {
  hue,
  hueSat,
  hueLum,
  hueAlpha,
  sat,
  satLum,
  satAlpha,
  lum,
  lumAlpha,
  alpha;
}

Future<ColorDerivative> showColorPickerDialog({
  required BuildContext context,
  required ColorDerivative color,
  ValueChanged<ColorDerivative>? onColorChanged,
  Widget? title,
  ColorPickerMode initialMode = ColorPickerMode.rgb,
  bool showAlpha = true,
  bool allowPickFromScreen = true,
  ColorHistoryStorage? historyStorage,
}) async {
  final GlobalKey<_ColorPickerDialogState> key = GlobalKey();
  while (true) {
    if (!context.mounted) {
      return color;
    }
    final result = await showDialog<_ColorPickerDialogResult>(
      context: context,
      builder: (context) {
        return _ColorPickerDialog(
          key: key,
          color: color,
          onColorChanged: (color) {
            onColorChanged?.call(color);
            if (historyStorage != null) {
              historyStorage.addHistory(color.toColor());
            }
          },
          showAlpha: showAlpha,
          initialMode: initialMode,
          allowPickFromScreen: allowPickFromScreen,
          title: title,
        );
      },
    );
    if (result == null) {
      return color;
    }
    if (result.pickedFromScreen) {
      if (key.currentState != null) {
        final modalRoute = ModalRoute.of(key.currentContext!);
        if (modalRoute != null) {
          await modalRoute.completed;
        }
      }
      if (!context.mounted) {
        return color;
      }
      final picked = await pickColorFromScreen(context);
      if (picked != null) {
        color = color.changeToColor(picked);
      }
      continue;
    }
    if (result.color != null) {
      return result.color!;
    }
    return color;
  }
}

Future<ColorDerivative> showColorPicker({
  required BuildContext context,
  AlignmentGeometry alignment = AlignmentDirectional.topStart,
  AlignmentGeometry anchorAlignment = AlignmentDirectional.bottomStart,
  bool follow = true,
  Offset? offset,
  PopoverConstraint widthConstraint = PopoverConstraint.flexible,
  PopoverConstraint heightConstraint = PopoverConstraint.flexible,
  required ColorDerivative color,
  ValueChanged<ColorDerivative>? onColorChanged,
  bool showAlpha = true,
  ColorPickerMode initialMode = ColorPickerMode.rgb,
  bool allowPickFromScreen = true,
  ValueChanged<ColorDerivative>? onColorChangeEnd,
  ColorHistoryStorage? historyStorage,
}) async {
  while (true) {
    if (!context.mounted) {
      return color;
    }
    final completer = showPopover(
      context: context,
      alignment: alignment,
      follow: true,
      offset: offset,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      builder: (innerContext) {
        return _ColorPickerPopup(
          color: color,
          onColorChanged: onColorChanged,
          onColorChangeEnd: (value) {
            onColorChangeEnd?.call(value);
            if (historyStorage != null) {
              historyStorage.addHistory(value.toColor());
            }
          },
          showAlpha: showAlpha,
          initialMode: initialMode,
          allowPickFromScreen: allowPickFromScreen,
        );
      },
    );
    final result = await completer.future;
    if (result == null) {
      return color;
    }
    if (result.pickedFromScreen) {
      await completer.animationFuture;
      if (!context.mounted) {
        return color;
      }
      final picked = await pickColorFromScreen(context);
      if (picked != null) {
        color = color.changeToColor(picked);
        onColorChanged?.call(color);
      }
      continue;
    }
    if (result.barrierColor != null) {
      return result.barrierColor!;
    }
  }
}

class _ColorPickerDialogResult {
  final ColorDerivative? color;
  final bool pickedFromScreen;

  const _ColorPickerDialogResult({
    this.color,
    this.pickedFromScreen = false,
  });
}

class _ColorPickerDialog extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  final bool allowPickFromScreen;
  final Widget? title;

  const _ColorPickerDialog({
    super.key,
    required this.color,
    this.onColorChanged,
    this.showAlpha = true,
    this.initialMode = ColorPickerMode.rgb,
    this.allowPickFromScreen = true,
    this.title,
  });

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late ColorPickerMode _mode;
  late ColorDerivative _color;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return AlertDialog(
      title: widget.title,
      content: ColorInputPopup(
        color: _color,
        onChanged: (value) {
          setState(() {
            _color = value;
          });
        },
        showAlpha: widget.showAlpha,
        initialMode: _mode,
      ),
      actions: [
        if (widget.allowPickFromScreen)
          IconButton.outline(
            onPressed: () {
              Navigator.of(context).pop(const _ColorPickerDialogResult(
                pickedFromScreen: true,
              ));
            },
            icon: const Icon(BootstrapIcons.eyedropper),
          ),
        SecondaryButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localizations.buttonCancel),
        ),
        PrimaryButton(
          onPressed: () {
            widget.onColorChanged?.call(_color);
            Navigator.of(context).pop(_ColorPickerDialogResult(
              color: _color,
            ));
          },
          child: Text(localizations.buttonOk, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class _ColorPickerPopup extends StatefulWidget {
  final ColorDerivative color;
  final ValueChanged<ColorDerivative>? onColorChanged;
  final ValueChanged<ColorDerivative>? onColorChangeEnd;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  final bool allowPickFromScreen;

  const _ColorPickerPopup({
    required this.color,
    this.onColorChanged,
    this.onColorChangeEnd,
    this.showAlpha = true,
    this.initialMode = ColorPickerMode.rgb,
    this.allowPickFromScreen = true,
  });

  @override
  State<_ColorPickerPopup> createState() => _ColorPickerPopupState();
}

class _ColorPickerPopupState extends State<_ColorPickerPopup> {
  late ColorPickerMode _mode;
  late ColorDerivative _color;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: ColorInputPopup(
        color: _color,
        onChanged: (value) {
          setState(() {
            _color = value;
          });
          widget.onColorChanged?.call(value);
        },
        showAlpha: widget.showAlpha,
        initialMode: _mode,
        onColorChangeEnd: widget.onColorChangeEnd,
        onPickFromScreen: widget.allowPickFromScreen
            ? () {
                closeOverlay(
                    context,
                    const _ColorPickerDialogResult(
                      pickedFromScreen: true,
                    ));
              }
            : null,
      ),
    );
  }
}

abstract base class ColorDerivative {
  static ColorDerivative fromColor(Color color) {
    return _HSVColor(HSVColor.fromColor(color));
  }

  static ColorDerivative fromHSV(HSVColor color) {
    return _HSVColor(color);
  }

  static ColorDerivative fromHSL(HSLColor color) {
    return _HSLColor(color);
  }

  const ColorDerivative();
  Color toColor();
  HSVColor toHSVColor();
  HSLColor toHSLColor();
  double get opacity;
  double get hslHue;
  double get hslSat;
  double get hslVal;
  double get hsvHue;
  double get hsvSat;
  double get hsvVal;
  int get red;
  int get green;
  int get blue;
  ColorDerivative transform(ColorDerivative old);
  ColorDerivative changeToAlpha(double alpha);
  ColorDerivative changeToColor(Color color) {
    ColorDerivative newColor = ColorDerivative.fromColor(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToHSV(HSVColor color) {
    ColorDerivative newColor = ColorDerivative.fromHSV(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToHSL(HSLColor color) {
    ColorDerivative newColor = ColorDerivative.fromHSL(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToColorRed(double red) {
    return changeToColor(toColor().withRed(red.toInt()));
  }

  ColorDerivative changeToColorGreen(double green) {
    return changeToColor(toColor().withGreen(green.toInt()));
  }

  ColorDerivative changeToColorBlue(double blue) {
    return changeToColor(toColor().withBlue(blue.toInt()));
  }

  ColorDerivative changeToColorAlpha(double alpha) {
    return changeToColor(toColor().withAlpha(alpha.toInt()));
  }

  ColorDerivative changeToHSVHue(double hue) {
    return changeToHSV(toHSVColor().withHue(hue));
  }

  ColorDerivative changeToHSVSaturation(double saturation) {
    return changeToHSV(toHSVColor().withSaturation(saturation));
  }

  ColorDerivative changeToHSVValue(double value) {
    return changeToHSV(toHSVColor().withValue(value));
  }

  ColorDerivative changeToHSVAlpha(double alpha) {
    return changeToHSV(toHSVColor().withAlpha(alpha));
  }

  ColorDerivative changeToHSLHue(double hue) {
    return changeToHSL(toHSLColor().withHue(hue));
  }

  ColorDerivative changeToHSLSaturation(double saturation) {
    return changeToHSL(toHSLColor().withSaturation(saturation));
  }

  ColorDerivative changeToHSLLightness(double lightness) {
    return changeToHSL(toHSLColor().withLightness(lightness));
  }
}

final class _HSVColor extends ColorDerivative {
  final HSVColor color;
  const _HSVColor(this.color);

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color;
  }

  @override
  HSLColor toHSLColor() {
    return color.toHSL();
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToAlpha(double alpha) {
    return _HSVColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color);
    } else if (old is _HSLColor) {
      return _HSLColor(color.toHSL());
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSLColor) {
      return color == other.toHSVColor();
    }

    return other is _HSVColor && other.color == color;
  }

  @override
  int get hashCode => toColor().hashCode;

  @override
  double get hslHue => color.toHSL().hue;

  @override
  double get hslSat => color.toHSL().saturation;

  @override
  double get hslVal => color.toHSL().lightness;

  @override
  double get hsvHue => color.hue;

  @override
  double get hsvSat => color.saturation;

  @override
  double get hsvVal => color.value;

  @override
  int get red => color.toColor().red;

  @override
  int get green => color.toColor().green;

  @override
  int get blue => color.toColor().blue;
}

final class _HSLColor extends ColorDerivative {
  final HSLColor color;
  const _HSLColor(this.color);

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color.toHSV();
  }

  @override
  HSLColor toHSLColor() {
    return color;
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToAlpha(double alpha) {
    return _HSLColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color.toHSV());
    } else if (old is _HSLColor) {
      return _HSLColor(color);
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSVColor) {
      return color == other.toHSLColor();
    }

    return other is _HSLColor && other.color == color;
  }

  @override
  int get hashCode => toColor().hashCode;

  @override
  double get hslHue => color.hue;

  @override
  double get hslSat => color.saturation;

  @override
  double get hslVal => color.lightness;

  @override
  double get hsvHue => color.toHSV().hue;

  @override
  double get hsvSat => color.toHSV().saturation;

  @override
  double get hsvVal => color.toHSV().value;

  @override
  int get red => color.toColor().red;

  @override
  int get green => color.toColor().green;

  @override
  int get blue => color.toColor().blue;
}

class HSVColorPickerArea extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor>? onColorChanged;
  final ValueChanged<HSVColor>? onColorEnd;
  final HSVColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;

  const HSVColorPickerArea({
    super.key,
    required this.color,
    this.onColorChanged,
    this.onColorEnd,
    required this.sliderType,
    this.reverse = false,
    this.radius = const Radius.circular(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  State<HSVColorPickerArea> createState() => _HSVColorPickerAreaState();
}

class _HSVColorPickerAreaState extends State<HSVColorPickerArea> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _value;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSVColor hsv = widget.color;
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;
    _alpha = hsv.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
            (size.height - widget.padding.vertical))
        .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentHorizontal * 360;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentHorizontal;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentVertical * 360;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentVertical;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onColorChanged?.call(HSVColor.fromAHSV(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _value.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant HSVColorPickerArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      HSVColor hsv = widget.color;
      _hue = hsv.hue;
      _saturation = hsv.saturation;
      _value = hsv.value;
      _alpha = hsv.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSVColorSliderType.hue ||
        widget.sliderType == HSVColorSliderType.sat ||
        widget.sliderType == HSVColorSliderType.val ||
        widget.sliderType == HSVColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double cursorRadius = theme.scaling * 16;
    double radDiv = isSingleChannel ? 4 : 2;
    return GestureDetector(
      onTapDown: (details) {
        _updateColor(details.localPosition, context.size!);
        widget.onColorEnd?.call(HSVColor.fromAHSV(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _value.clamp(0, 1),
        ));
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onColorEnd?.call(HSVColor.fromAHSV(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _value.clamp(0, 1),
        ));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: CheckboardPainter(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: HSVColorPickerPainter(
                    sliderType: widget.sliderType,
                    color: HSVColor.fromAHSV(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _value.clamp(0, 1),
                    ),
                    reverse: widget.reverse,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -cursorRadius / radDiv,
            top: -cursorRadius / radDiv,
            bottom: -cursorRadius / radDiv,
            right: -cursorRadius / radDiv,
            child: isSingleChannel
                ? (widget.reverse
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: widget.padding.left,
                          right: widget.padding.right,
                        ),
                        child: Align(
                          alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            width: cursorRadius,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
                              border: Border.all(
                                color: Colors.white,
                                width: theme.scaling * 2,
                              ),
                              borderRadius: BorderRadius.all(widget.radius),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          top: widget.padding.top,
                          bottom: widget.padding.bottom,
                        ),
                        child: Align(
                          alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            height: cursorRadius,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
                              border: Border.all(
                                color: Colors.white,
                                width: theme.scaling * 2,
                              ),
                              borderRadius: BorderRadius.all(widget.radius),
                            ),
                          ),
                        ),
                      ))
                : Padding(
                    padding: widget.padding,
                    child: Align(
                      alignment: Alignment(
                          (_currentHorizontal.clamp(0, 1) * 2) - 1,
                          (_currentVertical.clamp(0, 1) * 2) - 1),
                      child: Container(
                        width: cursorRadius,
                        height: cursorRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.toColor(),
                          border: Border.all(
                            color: Colors.white,
                            width: theme.scaling * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  double get vertical {
    HSVColor hsv = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSVColor hsv = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }
}

class HSLColorPickerArea extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onColorChanged;
  final ValueChanged<HSLColor>? onColorEnd;
  final HSLColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;

  const HSLColorPickerArea({
    super.key,
    required this.color,
    this.onColorChanged,
    this.onColorEnd,
    required this.sliderType,
    this.reverse = false,
    this.radius = const Radius.circular(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  State<HSLColorPickerArea> createState() => _HSLColorPickerAreaState();
}

class _HSLColorPickerAreaState extends State<HSLColorPickerArea> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _lightness;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSLColor hsl = widget.color;
    _hue = hsl.hue;
    _saturation = hsl.saturation;
    _lightness = hsl.lightness;
    _alpha = hsl.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
            (size.height - widget.padding.vertical))
        .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentHorizontal * 360;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentHorizontal;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentVertical * 360;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentVertical;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onColorChanged?.call(HSLColor.fromAHSL(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _lightness.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant HSLColorPickerArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      HSLColor hsl = widget.color;
      _hue = hsl.hue;
      _saturation = hsl.saturation;
      _lightness = hsl.lightness;
      _alpha = hsl.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSLColorSliderType.hue ||
        widget.sliderType == HSLColorSliderType.sat ||
        widget.sliderType == HSLColorSliderType.lum ||
        widget.sliderType == HSLColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double cursorRadius = theme.scaling * 16;
    double radDiv = isSingleChannel ? 4 : 2;
    return GestureDetector(
      onTapDown: (details) {
        _updateColor(details.localPosition, context.size!);
        widget.onColorEnd?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
        ));
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onColorEnd?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
        ));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: CheckboardPainter(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: HSLColorPickerPainter(
                    sliderType: widget.sliderType,
                    color: HSLColor.fromAHSL(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _lightness.clamp(0, 1),
                    ),
                    reverse: widget.reverse,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -cursorRadius / radDiv,
            top: -cursorRadius / radDiv,
            bottom: -cursorRadius / radDiv,
            right: -cursorRadius / radDiv,
            child: isSingleChannel
                ? (widget.reverse
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: widget.padding.left,
                          right: widget.padding.right,
                        ),
                        child: Align(
                          alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            width: cursorRadius,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
                              border: Border.all(
                                color: Colors.white,
                                width: theme.scaling * 2,
                              ),
                              borderRadius: BorderRadius.all(widget.radius),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          top: widget.padding.top,
                          bottom: widget.padding.bottom,
                        ),
                        child: Align(
                          alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1),
                          child: Container(
                            height: cursorRadius,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: widget.color.toColor(),
                              border: Border.all(
                                color: Colors.white,
                                width: theme.scaling * 2,
                              ),
                              borderRadius: BorderRadius.all(widget.radius),
                            ),
                          ),
                        ),
                      ))
                : Padding(
                    padding: widget.padding,
                    child: Align(
                      alignment: Alignment(
                          (_currentHorizontal.clamp(0, 1) * 2) - 1,
                          (_currentVertical.clamp(0, 1) * 2) - 1),
                      child: Container(
                        width: cursorRadius,
                        height: cursorRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.toColor(),
                          border: Border.all(
                            color: Colors.white,
                            width: theme.scaling * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  double get vertical {
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }
}

class HSVColorPickerPainter extends CustomPainter {
  final HSVColorSliderType sliderType;
  final HSVColor color;
  final bool reverse;

  HSVColorPickerPainter({
    required this.sliderType,
    required this.color,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // disable anti-aliasing
    var pp = Paint();
    pp.isAntiAlias = false;
    pp.style = PaintingStyle.fill;
    var canvasHeight = size.height;
    var canvasWidth = size.width;
    if (sliderType == HSVColorSliderType.hueSat) {
      // if reverse, then its sat hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for saturation
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(1, i.toDouble(), j / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for saturation
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSVColor.fromAHSV(1, j.toDouble(), i / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hueVal) {
      // if reverse, then its val hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for value
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(1, i.toDouble(), color.saturation, j / 100.0);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSVColor.fromAHSV(1, j.toDouble(), color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.satVal) {
      // if reverse, then its val sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(1, color.hue, i / 100, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(1, color.hue, j / 100, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hueAlpha) {
      // if reverse, then its alpha hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for alpha
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                j / 100.0, i.toDouble(), color.saturation, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result = HSVColor.fromAHSV(
                i / 100, j.toDouble(), color.saturation, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.satAlpha) {
      // if reverse, then its alpha sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(j / 100, color.hue, i / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(i / 100, color.hue, j / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.valAlpha) {
      // if reverse, then its alpha val
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for value and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                j / 100, color.hue, color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for value and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                i / 100, color.hue, color.saturation, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hue) {
      if (reverse) {
        double width = canvasWidth / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSVColor.fromAHSV(
              1, i.toDouble(), color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSVColor.fromAHSV(
              1, i.toDouble(), color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.sat) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, i / 100, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, i / 100, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.val) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.alpha) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSVColor.fromAHSV(
              i / 100, color.hue, color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSVColor.fromAHSV(
              i / 100, color.hue, color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant HSVColorPickerPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    if (sliderType == HSVColorSliderType.hueSat) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.hueVal) {
      return oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSVColorSliderType.satVal) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.alpha) {
      return oldDelegate.color.value != color.value ||
          oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.hue) {
      return oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.sat) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.val) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSVColorSliderType.hueAlpha) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.satAlpha) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.valAlpha) {
      return oldDelegate.color.hue != color.hue;
    }
    return false;
  }
}

class HSLColorPickerPainter extends CustomPainter {
  final HSLColorSliderType sliderType;
  final HSLColor color;
  final bool reverse;

  HSLColorPickerPainter({
    required this.sliderType,
    required this.color,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // disable anti-aliasing
    var pp = Paint();
    pp.isAntiAlias = false;
    pp.style = PaintingStyle.fill;
    var canvasHeight = size.height;
    var canvasWidth = size.width;
    if (sliderType == HSLColorSliderType.hueSat) {
      // if reverse, then its sat hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for saturation
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(1, i.toDouble(), j / 100, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for saturation
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSLColor.fromAHSL(1, j.toDouble(), i / 100, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.hueLum) {
      // if reverse, then its lum hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for lightness
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(1, i.toDouble(), color.saturation, j / 100.0);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSLColor.fromAHSL(1, j.toDouble(), color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.satLum) {
      // if reverse, then its lum sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(1, color.hue, i / 100, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(1, color.hue, j / 100, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.hueAlpha) {
      // if reverse, then its alpha hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for alpha
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
                j / 100.0, i.toDouble(), color.saturation, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result = HSLColor.fromAHSL(
                i / 100, j.toDouble(), color.saturation, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.satAlpha) {
      // if reverse, then its alpha sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(j / 100, color.hue, i / 100, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(i / 100, color.hue, j / 100, color.lightness);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.lumAlpha) {
      // if reverse, then its alpha lum
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for lightness and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
                j / 100, color.hue, color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for lightness and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
                i / 100, color.hue, color.saturation, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSLColorSliderType.hue) {
      if (reverse) {
        double width = canvasWidth / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSLColor.fromAHSL(
              1, i.toDouble(), color.saturation, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSLColor.fromAHSL(
              1, i.toDouble(), color.saturation, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.sat) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(
              1, color.hue, i / 100, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(
              1, color.hue, i / 100, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.lum) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSLColor.fromAHSL(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSLColor.fromAHSL(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.alpha) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(i / 100, color.hue, color.saturation,
              color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(i / 100, color.hue, color.saturation,
              color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant HSLColorPickerPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    if (sliderType == HSLColorSliderType.hueSat) {
      return oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.hueLum) {
      return oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.satLum) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.alpha) {
      return oldDelegate.color.lightness != color.lightness ||
          oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.hue) {
      return oldDelegate.color.lightness != color.lightness ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.sat) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.lum) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.hueAlpha) {
      return oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.satAlpha) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.lumAlpha) {
      return oldDelegate.color.hue != color.hue;
    }
    return false;
  }
}

class CheckboardPainter extends CustomPainter {
  static const Color checkboardPrimary = Color(0xFFE0E0E0);
  static const Color checkboardSecondary = Color(0xFFB0B0B0);
  static const double checkboardSize = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = checkboardPrimary;
    canvas.drawRect(Offset.zero & size, paint);
    paint.color = checkboardSecondary;
    for (var i = 0.0; i < size.width; i += checkboardSize) {
      for (var j = 0.0; j < size.height; j += checkboardSize) {
        if ((i / checkboardSize).floor() % 2 == 0) {
          if ((j / checkboardSize).floor() % 2 == 0) {
            canvas.drawRect(
              Rect.fromLTWH(i, j, checkboardSize, checkboardSize),
              paint,
            );
          }
        } else {
          if ((j / checkboardSize).floor() % 2 != 0) {
            canvas.drawRect(
              Rect.fromLTWH(i, j, checkboardSize, checkboardSize),
              paint,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CheckboardPainter oldDelegate) => false;
}
