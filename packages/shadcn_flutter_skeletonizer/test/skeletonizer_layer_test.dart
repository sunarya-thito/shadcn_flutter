import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_skeletonizer/shadcn_flutter_skeletonizer.dart';

/// Records the [SkeletonizerConfigData] in scope where it is placed.
SkeletonizerConfigData? _seen;

Widget _probe() => Builder(
  builder: (context) {
    _seen = SkeletonizerConfig.maybeOf(context);
    return const SizedBox.shrink();
  },
);

/// The pulse the recorded config resolves to.
PulseEffect _pulse() => _seen!.resolveEffect(_seen!.brightness!) as PulseEffect;

Widget _app({required Widget child, ThemeData? theme}) => ShadcnApp(
  theme: theme ?? ThemeData(colorScheme: ColorSchemes.lightZinc, radius: 0.5),
  home: child,
);

void main() {
  setUp(() => _seen = null);

  group('SkeletonizerLayer', () {
    testWidgets('derives the pulse from the ambient shadcn theme', (
      tester,
    ) async {
      final theme = ThemeData(colorScheme: ColorSchemes.lightZinc, radius: 0.5);
      await tester.pumpWidget(
        _app(
          theme: theme,
          child: SkeletonizerLayer(child: _probe()),
        ),
      );

      final effect = _pulse();
      expect(effect.duration, const Duration(seconds: 1));
      expect(effect.from, theme.colorScheme.primary.scaleAlpha(0.05));
      expect(effect.to, theme.colorScheme.primary.scaleAlpha(0.1));
      expect(_seen!.brightness, theme.brightness);
      expect(_seen!.enableSwitchAnimation, isTrue);
    });

    testWidgets('the pulse ignores the brightness it is resolved with', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          theme: ThemeData(colorScheme: ColorSchemes.darkZinc, radius: 0.5),
          child: SkeletonizerLayer(child: _probe()),
        ),
      );

      expect(_seen!.brightness, Brightness.dark);
      expect(
        _seen!.resolveEffect(Brightness.light),
        _seen!.resolveEffect(Brightness.dark),
        reason: 'the shadcn theme already decides the colors',
      );
    });

    testWidgets('rebuilding with the same values keeps the config equal', (
      tester,
    ) async {
      await tester.pumpWidget(_app(child: SkeletonizerLayer(child: _probe())));
      final first = _seen;

      await tester.pumpWidget(_app(child: SkeletonizerLayer(child: _probe())));

      // SkeletonizerConfigData compares effect resolvers by identity, so an
      // unequal config would notify every skeleton below the layer.
      expect(_seen, isNot(same(first)));
      expect(_seen, first);
    });

    testWidgets('widget arguments override the derived defaults', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          child: SkeletonizerLayer(
            duration: const Duration(milliseconds: 800),
            fromColor: const Color(0xFF111111),
            toColor: const Color(0xFF222222),
            enableSwitchAnimation: false,
            child: _probe(),
          ),
        ),
      );

      final effect = _pulse();
      expect(effect.duration, const Duration(milliseconds: 800));
      expect(effect.from, const Color(0xFF111111));
      expect(effect.to, const Color(0xFF222222));
      expect(_seen!.enableSwitchAnimation, isFalse);
    });

    testWidgets('reads SkeletonTheme from an ancestor ComponentTheme', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          child: ComponentTheme(
            data: const SkeletonTheme(
              duration: Duration(milliseconds: 400),
              enableSwitchAnimation: false,
            ),
            child: SkeletonizerLayer(child: _probe()),
          ),
        ),
      );

      expect(_pulse().duration, const Duration(milliseconds: 400));
      expect(_seen!.enableSwitchAnimation, isFalse);
    });

    testWidgets('its own theme argument wins over the ancestor', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          child: ComponentTheme(
            data: const SkeletonTheme(duration: Duration(milliseconds: 400)),
            child: SkeletonizerLayer(
              theme: const SkeletonTheme(duration: Duration(milliseconds: 900)),
              child: _probe(),
            ),
          ),
        ),
      );

      expect(_pulse().duration, const Duration(milliseconds: 900));
    });
  });

  group('SkeletonExtension', () {
    // Skeletonizer and Skeleton are abstract, so match by predicate rather
    // than by exact runtime type.
    final skeletonizer = find.byWidgetPredicate((w) => w is Skeletonizer);
    final skeleton = find.byWidgetPredicate((w) => w is Skeleton);

    testWidgets('asSkeleton wraps in a Skeletonizer', (tester) async {
      await tester.pumpWidget(
        _app(child: SkeletonizerLayer(child: const Text('hello').asSkeleton())),
      );

      expect(skeletonizer, findsOneWidget);
      expect(tester.widget<Skeletonizer>(skeletonizer).enabled, isTrue);
    });

    testWidgets('asSkeleton follows an AsyncSnapshot', (tester) async {
      await tester.pumpWidget(
        _app(
          child: SkeletonizerLayer(
            child: const Text('hello').asSkeleton(
              snapshot: const AsyncSnapshot<String>.withData(
                ConnectionState.done,
                'hello',
              ),
            ),
          ),
        ),
      );

      expect(
        tester.widget<Skeletonizer>(skeletonizer).enabled,
        isFalse,
        reason: 'data has arrived, so the skeleton switches off',
      );
    });

    testWidgets('asSkeleton(leaf: true) uses Skeleton.leaf', (tester) async {
      await tester.pumpWidget(
        _app(
          child: SkeletonizerLayer(
            child: const Text('hello').asSkeleton(leaf: true),
          ),
        ),
      );

      expect(skeleton, findsOneWidget);
      expect(skeletonizer, findsNothing);
    });

    testWidgets('Avatar is given leaf treatment automatically', (tester) async {
      await tester.pumpWidget(
        _app(
          child: SkeletonizerLayer(
            child: const Avatar(initials: 'AB').asSkeleton(),
          ),
        ),
      );

      // Avatar renders an image-like subtree that skeletonizer cannot walk, so
      // asSkeleton reaches for Skeleton.leaf rather than Skeletonizer.
      // See skeletonizer#17.
      expect(skeleton, findsOneWidget);
      expect(skeletonizer, findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ignoreSkeleton and excludeSkeleton wrap in a Skeleton', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          child: SkeletonizerLayer(
            child: Column(
              children: [
                const Text('a').ignoreSkeleton(),
                const Text('b').excludeSkeleton(),
              ],
            ).asSkeleton(),
          ),
        ),
      );

      expect(skeleton, findsNWidgets(2));
      expect(tester.takeException(), isNull);
    });
  });
}
