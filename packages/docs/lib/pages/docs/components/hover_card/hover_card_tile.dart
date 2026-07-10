import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material hide Card;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CursorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = material.Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 12)
      ..lineTo(3, 9)
      ..lineTo(5, 11)
      ..lineTo(7, 9)
      ..lineTo(4, 7)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HoverCardTile extends StatelessWidget implements IComponentPage {
  const HoverCardTile({super.key});

  @override
  String get title => 'Hover Card';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'hover_card',
      title: 'Hover Card',
      scale: 1,
      example: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('@flutter').medium().underline(),
              const Gap(16),
              const Card(
                child: Basic(
                  leading: FlutterLogo(),
                  title: Text('@flutter'),
                  content: Text(
                      'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),
                ),
              ).sized(width: 300),
            ],
          ),
          Positioned(
            top: 13,
            left: 160,
            child: CustomPaint(
              painter: CursorPainter(),
            ),
          ),
        ],
      ),
    );
  }
}
