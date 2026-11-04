import 'dart:ui' show ImageByteFormat;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

const _headerColor = Color(0xFFFF0000);
const _bodyColor = Color(0xFF00FF00);

Future<void> _pumpSidebar(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(400, 600));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ShadcnApp(
      home: Scaffold(
        child: Center(
          child: SizedBox(
            width: 280,
            height: 600,
            child: NavigationSidebar(
              backgroundColor: const Color(0xFFFFFFFF),
              header: [
                SliverToBoxAdapter(
                  child: Container(
                    key: const ValueKey('header'),
                    height: 64,
                    color: _headerColor,
                  ),
                ),
              ],
              footer: [
                SliverToBoxAdapter(
                  child: Container(
                    key: const ValueKey('footer'),
                    height: 40,
                    color: const Color(0xFF0000FF),
                  ),
                ),
              ],
              children: [
                for (var i = 0; i < 30; i++)
                  SliverToBoxAdapter(
                    child: Container(
                      key: ValueKey('body$i'),
                      height: 40,
                      color: _bodyColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 100));
}

Rect _rectOf(WidgetTester tester, String key) {
  final box = tester.renderObject<RenderBox>(find.byKey(ValueKey(key)));
  return box.localToGlobal(Offset.zero) & box.size;
}

void main() {
  group('NavigationSidebar fixed zones', () {
    testWidgets('header and footer share the body item column', (tester) async {
      await _pumpSidebar(tester);

      final header = _rectOf(tester, 'header');
      final footer = _rectOf(tester, 'footer');
      final body = _rectOf(tester, 'body0');

      expect(header.left, body.left);
      expect(header.right, body.right);
      expect(footer.left, body.left);
      expect(footer.right, body.right);
    });

    testWidgets('scrolled body does not paint over the header', (tester) async {
      await _pumpSidebar(tester);

      await tester.drag(
        find.byKey(const ValueKey('body5')),
        const Offset(0, -200),
      );
      await tester.pump();

      // Precondition: an item really did scroll behind the header band.
      expect(_rectOf(tester, 'body0').top, lessThan(0));

      await tester.binding.runAsync(() async {
        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find
              .descendant(
                of: find.byType(NavigationSidebar),
                matching: find.byType(RepaintBoundary),
              )
              .first,
        );
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ImageByteFormat.rawRgba);
        final width = image.width;

        Color pixelAt(int x, int y) {
          final i = (y * width + x) * 4;
          return Color.fromARGB(
            bytes!.getUint8(i + 3),
            bytes.getUint8(i),
            bytes.getUint8(i + 1),
            bytes.getUint8(i + 2),
          );
        }

        for (final y in const [20, 40, 60]) {
          expect(pixelAt(140, y), _headerColor);
        }
        image.dispose();
      });
    });
  });
}
