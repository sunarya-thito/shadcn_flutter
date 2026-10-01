import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

void main() {
  testWidgets(
    'a model-authored A2UI response renders, lays out, and remains interactive',
    (tester) async {
      final submittedAction = Completer<ChatMessage>();
      final catalog = GenCatalog.asCatalog();
      final controller = SurfaceController(catalogs: [catalog]);
      final transport = A2uiTransportAdapter(
        onSend: (message) async {
          final isSaveAction = message.parts.uiInteractionParts.any(
            (part) => part.interaction.contains('save_profile'),
          );
          if (isSaveAction && !submittedAction.isCompleted) {
            submittedAction.complete(message);
          }
        },
      );
      final conversation = Conversation(
        controller: controller,
        transport: transport,
      );
      addTearDown(() {
        conversation.dispose();
        transport.dispose();
        controller.dispose();
      });

      final surfaceAdded = conversation.events
          .where((event) => event is ConversationSurfaceAdded)
          .cast<ConversationSurfaceAdded>()
          .firstWhere((event) => event.surfaceId == 'profile-editor');
      final componentsUpdated = conversation.events
          .where((event) => event is ConversationComponentsUpdated)
          .cast<ConversationComponentsUpdated>()
          .firstWhere((event) => event.surfaceId == 'profile-editor');

      // This is intentionally a raw model response, including prose and JSON
      // fences. No Component or DataModel objects are constructed by the test.
      transport.addChunk(_modelResponse);
      await Future.wait([surfaceAdded, componentsUpdated])
          .timeout(const Duration(seconds: 2));

      await tester.pumpWidget(
        shad.ShadcnApp(
          home: Surface(
            surfaceContext: controller.contextFor('profile-editor'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Rendered and shown.
      expect(tester.takeException(), isNull);
      expect(find.text('Edit profile'), findsOneWidget);
      expect(find.byType(shad.TextField), findsOneWidget);
      expect(find.byType(shad.Checkbox), findsOneWidget);
      expect(find.text('Save profile'), findsOneWidget);

      // Placed in the order authored by the model and inside the viewport.
      final titleRect = tester.getRect(find.text('Edit profile'));
      final fieldRect = tester.getRect(find.byType(shad.TextField));
      final checkboxRect = tester.getRect(find.byType(shad.Checkbox));
      final buttonRect = tester.getRect(find.text('Save profile'));
      final viewportHeight =
          tester.view.physicalSize.height / tester.view.devicePixelRatio;
      final viewportWidth =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;

      expect(titleRect.bottom, lessThanOrEqualTo(fieldRect.top));
      expect(fieldRect.bottom, lessThanOrEqualTo(checkboxRect.top));
      expect(checkboxRect.bottom, lessThanOrEqualTo(buttonRect.top));
      for (final rect in [titleRect, fieldRect, checkboxRect, buttonRect]) {
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(viewportWidth));
        expect(rect.top, greaterThanOrEqualTo(0));
        expect(rect.bottom, lessThanOrEqualTo(viewportHeight));
      }

      // Interactable and two-way bound.
      await tester.enterText(find.byType(shad.TextField), 'Grace Hopper');
      await tester.tap(find.text('Accept terms'));
      await tester.pumpAndSettle();

      final model = controller.contextFor('profile-editor').dataModel;
      expect(model.getValue<String>(DataPath('/profile/name')), 'Grace Hopper');
      expect(model.getValue<bool>(DataPath('/profile/accepted')), isTrue);

      // The submitted event resolves its context from the latest input state.
      await tester.tap(find.text('Save profile'));
      await tester.pump();
      final submitted = await submittedAction.future.timeout(
        const Duration(seconds: 1),
      );
      final interaction = jsonDecode(
        submitted.parts.uiInteractionParts.single.interaction,
      ) as Map<String, Object?>;
      final action = interaction['action'] as Map<String, Object?>;
      final actionContext = action['context'] as Map<String, Object?>;

      expect(action['name'], 'save_profile');
      expect(action['sourceComponentId'], 'save');
      expect(actionContext['name'], 'Grace Hopper');
      expect(actionContext['accepted'], isTrue);
    },
  );
}

const _modelResponse = r'''
I'll show an editable profile form.

```json
{"version":"v0.9","createSurface":{"surfaceId":"profile-editor","catalogId":"https://a2ui.org/specification/v0_9/catalogs/basic/catalog.json","sendDataModel":true}}
```

```json
{"version":"v0.9","updateDataModel":{"surfaceId":"profile-editor","path":"/","value":{"profile":{"name":"Ada Lovelace","accepted":false}}}}
```

```json
{"version":"v0.9","updateComponents":{"surfaceId":"profile-editor","components":[{"id":"root","component":"Column","children":["title","name","accepted","save"]},{"id":"title","component":"Text","text":"Edit profile","variant":"h2"},{"id":"name","component":"TextField","label":"Full name","value":{"path":"/profile/name"}},{"id":"accepted","component":"CheckBox","label":"Accept terms","value":{"path":"/profile/accepted"}},{"id":"save","component":"Button","variant":"primary","child":"save-label","action":{"event":{"name":"save_profile","context":{"name":{"path":"/profile/name"},"accepted":{"path":"/profile/accepted"}}}}},{"id":"save-label","component":"Text","text":"Save profile"}]}}
```
''';
