import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Rasterises [painter] at [size] and returns the pixels as RGBA rows.
Future<_Raster> _rasterize(CustomPainter painter, Size size) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Offset.zero & size);
  painter.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.round(), size.height.round());
  // Straight, not `rawRgba`, which is premultiplied and so would report a
  // translucent pixel's color already scaled by its own alpha.
  final byteData = await image.toByteData(
    format: ui.ImageByteFormat.rawStraightRgba,
  );
  final raster = _Raster(
    byteData!.buffer.asUint8List(),
    image.width,
    image.height,
  );
  picture.dispose();
  image.dispose();
  return raster;
}

class _Raster {
  _Raster(this.bytes, this.width, this.height);

  final Uint8List bytes;
  final int width;
  final int height;

  Color operator [](Offset position) {
    final index = (position.dy.floor() * width + position.dx.floor()) * 4;
    return Color.fromARGB(
      bytes[index + 3],
      bytes[index],
      bytes[index + 1],
      bytes[index + 2],
    );
  }

  /// The fraction of the way across the field that pixel column [x] samples.
  double fractionX(int x) => (x + 0.5) / width;

  /// The fraction of the way down the field that pixel row [y] samples.
  double fractionY(int y) => (y + 0.5) / height;
}

/// Asserts two colors match within the rounding a gradient shader introduces.
///
/// Compares premultiplied channels, because that is what the framebuffer
/// stores: at a very low alpha the unpremultiplied color has been quantised
/// away entirely, and only the premultiplied result is meaningful.
void _expectColor(Color actual, Color expected, String reason) {
  const tolerance = 3;
  for (final channel in <(String, int Function(Color))>[
    ('alpha', (c) => (c.a * 255).round()),
    ('red', (c) => (c.r * c.a * 255).round()),
    ('green', (c) => (c.g * c.a * 255).round()),
    ('blue', (c) => (c.b * c.a * 255).round()),
  ]) {
    expect(
      channel.$2(actual),
      closeTo(channel.$2(expected), tolerance),
      reason: '${channel.$1} of $actual vs $expected — $reason',
    );
  }
}

void main() {
  const size = Size(64, 64);

  group('HSVColorSliderPainter', () {
    test('hue ramps horizontally when reversed', () async {
      const color = HSVColor.fromAHSV(1, 200, 0.6, 0.8);
      final raster = await _rasterize(
        HSVColorSliderPainter(
          sliderType: HSVColorSliderType.hue,
          color: color,
          reverse: true,
        ),
        size,
      );
      for (final x in <int>[0, 13, 31, 47, 63]) {
        _expectColor(
          raster[Offset(x.toDouble(), 32)],
          HSVColor.fromAHSV(
            1,
            raster.fractionX(x) * 360,
            color.saturation,
            color.value,
          ).toColor(),
          'hue at column $x',
        );
      }
    });

    test('satVal maps value across and saturation down', () async {
      const color = HSVColor.fromAHSV(1, 120, 0.5, 0.5);
      final raster = await _rasterize(
        HSVColorSliderPainter(
          sliderType: HSVColorSliderType.satVal,
          color: color,
        ),
        size,
      );
      for (final x in <int>[0, 20, 63]) {
        for (final y in <int>[0, 40, 63]) {
          _expectColor(
            raster[Offset(x.toDouble(), y.toDouble())],
            HSVColor.fromAHSV(
              1,
              color.hue,
              raster.fractionY(y),
              raster.fractionX(x),
            ).toColor(),
            'satVal at ($x, $y)',
          );
        }
      }
    });

    test('alpha ramps down the field and stays opaque elsewhere', () async {
      const color = HSVColor.fromAHSV(0.25, 300, 0.9, 0.7);
      final raster = await _rasterize(
        HSVColorSliderPainter(
          sliderType: HSVColorSliderType.alpha,
          color: color,
        ),
        size,
      );
      for (final y in <int>[0, 32, 63]) {
        _expectColor(
          raster[Offset(32, y.toDouble())],
          HSVColor.fromAHSV(
            raster.fractionY(y),
            color.hue,
            color.saturation,
            color.value,
          ).toColor(),
          'alpha at row $y',
        );
      }
    });

    test(
      'a slider without the alpha channel ignores a translucent color',
      () async {
        final translucent = await _rasterize(
          HSVColorSliderPainter(
            sliderType: HSVColorSliderType.satVal,
            color: const HSVColor.fromAHSV(0.1, 40, 0.5, 0.5),
          ),
          size,
        );
        final opaque = await _rasterize(
          HSVColorSliderPainter(
            sliderType: HSVColorSliderType.satVal,
            color: const HSVColor.fromAHSV(1, 40, 0.5, 0.5),
          ),
          size,
        );
        _expectColor(
          translucent[const Offset(20, 20)],
          opaque[const Offset(20, 20)],
          'alpha must not wash out satVal',
        );
      },
    );

    test('the field has no seams between neighbouring pixels', () async {
      // Regression test for the per-cell rects the painter used to draw: their
      // edges did not land on pixel boundaries, so the background showed
      // through as a grid of pale lines across the field.
      final raster = await _rasterize(
        HSVColorSliderPainter(
          sliderType: HSVColorSliderType.satVal,
          color: const HSVColor.fromAHSV(1, 210, 1, 1),
        ),
        size,
      );
      for (int y = 1; y < size.height - 1; y++) {
        for (int x = 1; x < size.width - 1; x++) {
          final left = raster[Offset(x - 1, y.toDouble())];
          final here = raster[Offset(x.toDouble(), y.toDouble())];
          final right = raster[Offset(x + 1, y.toDouble())];
          // On a smooth ramp every pixel sits between its neighbours; a seam
          // would spike above both of them.
          final spike = (here.r * 255) - ((left.r * 255) + (right.r * 255)) / 2;
          expect(
            spike.abs(),
            lessThan(4),
            reason: 'seam at ($x, $y): $left $here $right',
          );
        }
      }
    });
  });

  group('HSLColorSliderPainter', () {
    test(
      'lightness ramps through the fully saturated hue at the midpoint',
      () async {
        const color = HSLColor.fromAHSL(1, 90, 0.8, 0.5);
        final raster = await _rasterize(
          HSLColorSliderPainter(
            sliderType: HSLColorSliderType.lum,
            color: color,
            reverse: true,
          ),
          size,
        );
        for (final x in <int>[0, 16, 32, 48, 63]) {
          _expectColor(
            raster[Offset(x.toDouble(), 32)],
            HSLColor.fromAHSL(
              1,
              color.hue,
              color.saturation,
              raster.fractionX(x),
            ).toColor(),
            'lightness at column $x',
          );
        }
      },
    );

    test('satLum maps lightness across and saturation down', () async {
      const color = HSLColor.fromAHSL(1, 270, 0.5, 0.5);
      final raster = await _rasterize(
        HSLColorSliderPainter(
          sliderType: HSLColorSliderType.satLum,
          color: color,
        ),
        size,
      );
      for (final x in <int>[4, 30, 60]) {
        for (final y in <int>[4, 30, 60]) {
          _expectColor(
            raster[Offset(x.toDouble(), y.toDouble())],
            HSLColor.fromAHSL(
              1,
              color.hue,
              raster.fractionY(y),
              raster.fractionX(x),
            ).toColor(),
            'satLum at ($x, $y)',
          );
        }
      }
    });
  });
}
