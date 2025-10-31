import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A function that builds a preview label widget for the eye dropper.
///
/// Parameters:
/// - [context]: The build context.
/// - [color]: The currently selected color under the cursor.
///
/// Returns: A widget to display as the color preview label.
typedef PreviewLabelBuilder = Widget Function(
    BuildContext context, Color color);

/// A layer widget that provides eye dropper (color picking) functionality.
///
/// [EyeDropperLayer] wraps its child widget and enables screen color sampling.
/// When active, it displays a magnified preview of the area under the cursor
/// and allows users to pick colors directly from the screen.
///
/// Features:
/// - Magnified preview of screen area
/// - Customizable preview size and scale
/// - Optional color label display
/// - Flexible preview positioning
///
/// Example:
/// ```dart
/// EyeDropperLayer(
///   child: MyApp(),
///   showPreview: true,
///   previewScale: 10,
///   previewLabelBuilder: (context, color) {
///     return Text('Color: ${colorToHex(color)}');
///   },
/// )
/// ```
class EyeDropperLayer extends StatefulWidget {
  /// The child widget to wrap.
  final Widget child;

  /// Alignment of the preview overlay.
  final AlignmentGeometry? previewAlignment;

  /// Whether to show the magnified preview.
  final bool showPreview;

  /// Size of the preview overlay.
  final Size? previewSize;

  /// Magnification scale of the preview.
  final double previewScale;

  /// Builder for custom preview label widgets.
  final PreviewLabelBuilder? previewLabelBuilder;

  /// Creates an [EyeDropperLayer].
  const EyeDropperLayer({
    super.key,
    required this.child,
    this.previewAlignment,
    this.showPreview = true,
    this.previewSize,
    this.previewScale = 8,
    this.previewLabelBuilder,
  });

  @override
  State<EyeDropperLayer> createState() => _EyeDropperLayerState();
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

class _EyeDropperCompleter {
  final Completer<Color?> completer;
  final Set<ColorHistoryStorage> recentColorsScope;

  _EyeDropperCompleter(this.completer, this.recentColorsScope);
}

class _EyeDropperLayerState extends State<EyeDropperLayer>
    implements EyeDropperLayerScope {
  final GlobalKey _repaintKey = GlobalKey();
  _ScreenshotResult? _currentPicking;
  EyeDropperResult? _preview;
  Offset? _currentPosition;
  _EyeDropperCompleter? _session;

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
      _session = _EyeDropperCompleter(
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

  EyeDropperResult? _getPreview(Offset globalPosition, Size size) {
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
    return EyeDropperResult(colors, size, pickedColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final previewSize =
        widget.previewSize ?? const Size(100, 100) * theme.scaling;
    return Data<EyeDropperLayerScope>.inherit(
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

/// Prompts the user to pick a color from the screen using an eye dropper tool.
///
/// Returns the selected color, or null if the operation was cancelled.
/// Optionally stores the selected color in the provided [storage].
Future<Color?> pickColorFromScreen(BuildContext context,
    [ColorHistoryStorage? storage]) {
  final scope = EyeDropperLayerScope.find(context);
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

/// Provides access to eye dropper functionality in the widget tree.
///
/// [EyeDropperLayerScope] is an abstract interface that allows widgets to
/// request color picking functionality from an ancestor [EyeDropperLayer].
/// Use the static methods to find the scope in the widget tree.
abstract class EyeDropperLayerScope {
  /// Prompts the user to pick a color from the screen.
  ///
  /// Parameters:
  /// - [historyStorage]: Optional storage for color picking history.
  ///
  /// Returns: A [Future] that completes with the picked color, or null if cancelled.
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);

  /// Finds the root [EyeDropperLayerScope] in the widget tree.
  ///
  /// Searches up the tree to find the topmost eye dropper scope.
  static EyeDropperLayerScope findRoot(BuildContext context) {
    return Data.findRoot<EyeDropperLayerScope>(context);
  }

  /// Finds the nearest [EyeDropperLayerScope] in the widget tree.
  ///
  /// Searches up the tree to find the closest eye dropper scope.
  static EyeDropperLayerScope find(BuildContext context) {
    return Data.find<EyeDropperLayerScope>(context);
  }
}

/// Represents the result of an eye dropper color picking operation.
///
/// [EyeDropperResult] contains the picked color along with all colors
/// captured in the sampling area. This allows for accessing individual
/// pixels from the captured region.
class EyeDropperResult {
  /// The size of the captured area.
  final Size size;

  /// All colors in the captured area, stored row by row.
  final List<Color> colors;

  /// The specific color that was picked by the user.
  final Color pickedColor;

  /// Creates an [EyeDropperResult].
  const EyeDropperResult(this.colors, this.size, this.pickedColor);

  /// Gets the color at the specified position in the captured area.
  ///
  /// Parameters:
  /// - [position]: The offset position within the captured area.
  ///
  /// Returns: The color at that position.
  Color operator [](Offset position) {
    int index =
        (position.dy.floor() * size.width + position.dx.floor()).toInt();
    return colors[index];
  }
}
