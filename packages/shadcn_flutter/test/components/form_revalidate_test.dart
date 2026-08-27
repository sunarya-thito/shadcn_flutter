import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('Form revalidate', () {
    testWidgets('keeps reporting a value that is still invalid', (
      tester,
    ) async {
      // Mirrors the Revalidate Form Feature example: the initial value is
      // already taken, so revalidating must keep the error rather than clear
      // it. Revalidation used to hand the validator its internal cache
      // wrapper instead of the value, which passed every check.
      await tester.pumpWidget(
        ShadcnApp(
          theme: ThemeData(colorScheme: ColorSchemes.lightZinc),
          home: Scaffold(
            child: Form(
              child: FormField<String>(
                key: const InputKey(#username),
                label: const Text('Username'),
                validator: ConditionalValidator(
                  (value) async => !['taken'].contains(value),
                  message: 'Username already taken',
                ),
                child: const TextField(
                  initialValue: 'taken',
                  features: [InputFeature.revalidate()],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Username already taken'), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.refreshCw));
      await tester.pumpAndSettle();
      expect(
        find.text('Username already taken'),
        findsOneWidget,
        reason: 'revalidating a still-invalid value must keep the error',
      );
    });

    testWidgets('clears the error once the value becomes valid', (
      tester,
    ) async {
      final controller = TextEditingController(text: 'taken');
      await tester.pumpWidget(
        ShadcnApp(
          theme: ThemeData(colorScheme: ColorSchemes.lightZinc),
          home: Scaffold(
            child: Form(
              child: FormField<String>(
                key: const InputKey(#username),
                label: const Text('Username'),
                validator: ConditionalValidator(
                  (value) async => !['taken'].contains(value),
                  message: 'Username already taken',
                ),
                child: TextField(
                  controller: controller,
                  features: const [InputFeature.revalidate()],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Username already taken'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'free');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(LucideIcons.refreshCw));
      await tester.pumpAndSettle();
      expect(find.text('Username already taken'), findsNothing);
    });
  });
}
