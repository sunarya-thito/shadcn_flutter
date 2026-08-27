import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Composites [color] over an opaque white page and returns the red channel.
double _overWhite(Color color) => color.a * color.r + (1 - color.a) * 1.0;

void main() {
  group('lerpColorPremultiplied', () {
    // The Select custom-colour example fades an opaque card surface to a faint
    // tint on hover. Both ends are light, so the surface must only ever get
    // lighter — Color.lerp instead drags it through the midpoint of the two
    // RGB values and the button visibly darkens halfway.
    const opaqueCard = Color(0xFFFFFFFF);
    final faintTint = const Color(0xFF18181B).withValues(alpha: 0.08);

    test('keeps the composited result between the two ends', () {
      var previous = _overWhite(opaqueCard);
      for (var i = 1; i <= 20; i++) {
        final t = i / 20;
        final value = _overWhite(
          lerpColorPremultiplied(opaqueCard, faintTint, t)!,
        );
        expect(
          value,
          lessThanOrEqualTo(previous + 1e-6),
          reason: 'fading to a lighter tint must not darken at t=$t',
        );
        previous = value;
      }
      expect(previous, closeTo(_overWhite(faintTint), 1e-6));
    });

    test('is what Color.lerp gets wrong', () {
      // Guards the premise: the straight lerp really does dip below both ends.
      final straight = _overWhite(Color.lerp(opaqueCard, faintTint, 0.5)!);
      expect(straight, lessThan(_overWhite(faintTint) - 0.1));
      final premultiplied = _overWhite(
        lerpColorPremultiplied(opaqueCard, faintTint, 0.5)!,
      );
      expect(premultiplied, greaterThan(_overWhite(faintTint)));
    });

    test('matches Color.lerp when both ends share an alpha', () {
      const a = Color(0xFF203040);
      const b = Color(0xFFA0B0C0);
      for (final t in <double>[0, 0.25, 0.5, 0.75, 1]) {
        final expected = Color.lerp(a, b, t)!;
        final actual = lerpColorPremultiplied(a, b, t)!;
        expect((actual.r - expected.r).abs(), lessThan(1e-6));
        expect((actual.g - expected.g).abs(), lessThan(1e-6));
        expect((actual.b - expected.b).abs(), lessThan(1e-6));
        expect((actual.a - expected.a).abs(), lessThan(1e-6));
      }
    });

    test('fades out rather than darkening when an end is null', () {
      const solid = Color(0xFFFFFFFF);
      final half = lerpColorPremultiplied(solid, null, 0.5)!;
      expect(half.a, closeTo(0.5, 1e-6));
      expect(half.r, closeTo(1.0, 1e-6));
      expect(lerpColorPremultiplied(null, null, 0.5), isNull);
    });
  });
}
