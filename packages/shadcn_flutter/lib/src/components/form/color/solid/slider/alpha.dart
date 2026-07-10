import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A custom painter that draws a checkboard pattern for alpha/transparency visualization.
///
/// [AlphaPainter] renders a two-tone checkerboard pattern typically used behind
/// semi-transparent colors to make the transparency visible. This is a common
/// pattern in color pickers and image editors.
class AlphaPainter extends CustomPainter {
  /// Primary color for the checkerboard pattern.
  static const Color checkboardPrimary = Color(0xFFE0E0E0);

  /// Secondary color for the checkerboard pattern.
  static const Color checkboardSecondary = Color(0xFFB0B0B0);

  /// Size of each checkerboard square.
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
  bool shouldRepaint(covariant AlphaPainter oldDelegate) => false;
}
