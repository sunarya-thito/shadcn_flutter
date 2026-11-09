import 'dart:async';
import 'dart:convert';

import 'package:a2ui_agent/a2ui_agent.dart'
    show
        A2uiErrorPartialResults,
        A2uiGenerator,
        A2uiPart,
        A2uiRequestProcessor,
        CatalogConfig,
        DirectJsonFormatFactory,
        ErrorPart,
        RendererState,
        StreamPart,
        TextPart;
import 'package:a2ui_core/a2ui_core.dart'
    show
        A2uiError,
        A2uiProtocolVersion,
        A2uiRendererAction,
        A2uiRendererCapabilities,
        A2uiRendererError,
        ActionMessage,
        AgentToRendererMessagePayload,
        ErrorMessage,
        MessageErrorMapper,
        MessageProcessor,
        Subscription,
        UpdateComponentsMessage,
        ValidationConfig;
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

import 'openrouter_client.dart';

/// A full chat screen: the user talks to an OpenRouter model, and the model's
/// replies are rendered both as plain text bubbles and as live shadcn_flutter
/// UI (via A2UI surfaces) inline in the conversation.
class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.apiKey,
    required this.model,
    this.onLogout,
  });

  final String apiKey;
  final String model;

  /// Called when the user taps "Log out" — clears the saved key and returns to
  /// the login screen.
  final VoidCallback? onLogout;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // --- A2UI wiring ------------------------------------------------------
  late final CatalogImplementation _catalog;
  late final MessageProcessor<ComponentImplementation> _processor;
  late final A2uiRequestProcessor _agent;
  late final RendererState _state;
  late final String _systemPrompt;
  late final List<Subscription> _subscriptions;
  static final String _version = A2uiProtocolVersion.v0_9.jsonValue;

  /// How many requests to the model are in flight. The typing indicator and
  /// the Stop button show while it is above zero.
  final _pending = ValueNotifier<int>(0);

  // --- OpenRouter -------------------------------------------------------
  late final OpenRouterClient _client;

  /// Conversation history for OpenRouter, in OpenAI wire format. The system
  /// prompt is prepended on every call rather than stored here.
  final _history = <Map<String, String>>[];

  // --- UI state ---------------------------------------------------------
  final _items = <_ChatItem>[];
  final _input = TextEditingController();
  final _scroll = ScrollController();

  /// Guards against the model looping on validation errors it can't fix.
  int _errorRetries = 0;
  static const int _maxErrorRetries = 2;

  @override
  void initState() {
    super.initState();

    _client = OpenRouterClient(apiKey: widget.apiKey, model: widget.model);

    // The shadcn_flutter catalog: the model may generate any of these widgets.
    //
    // The model is told to use the catalog's own stable ID. For agents that
    // address the standard basic catalog instead, GenCatalog.asCatalogs()
    // registers the catalog under the basic-catalog IDs too.
    _catalog = GenCatalog.asCatalog();

    _processor = MessageProcessor(
      catalogs: [_catalog],
      validationConfig: ValidationConfig.relaxed,
      // Report a rejected message on onError instead of throwing.
      reportErrorsOnly: true,
    );

    // Teaches the model the A2UI protocol and reads its replies.
    //
    // We allow create+update messages (rather than create-only) so that when
    // a surface fails validation the model can repair it in place via
    // `updateComponents` on the SAME surfaceId, instead of spawning a fresh
    // duplicate surface for every retry.
    _agent =
        A2uiGenerator(
          catalogs: [CatalogConfig(_catalog)],
          inferenceFormatFactory: const DirectJsonFormatFactory(
            allowedMessages: [
              'createSurface',
              'updateComponents',
              'updateDataModel',
            ],
          ),
        ).createProcessor(
          A2uiRendererCapabilities.forCatalogIds([
            _catalog.id,
          ], version: A2uiProtocolVersion.v0_9),
        );
    // The surfaces of earlier turns, which each reply is checked against.
    _state = _agent.createState();

    // Instructions that teach the model the A2UI protocol plus our persona.
    _systemPrompt = [
      'You are a friendly assistant demonstrating the shadcn_flutter GenUI '
          'catalog inside a chat app.',
      'Whenever it helps answer the user, render rich, interactive UI '
          '(cards, text fields, buttons, choice pickers, sliders and tabs) '
          'instead of describing it in prose.',
      'For a brand new answer, create a new surface. But if you receive an '
          'error message (e.g. code VALIDATION_FAILED) for a surface, do NOT '
          'create a new surface: fix the problem and re-send an '
          '`updateComponents` message reusing that same `surfaceId`.',
      'Your responses should contain acknowledgment of the user message.',
      'Current Date: ${DateTime.now().toIso8601String().split('T').first}',
      _agent.promptSnippet,
    ].join('\n\n');

    _subscriptions = [
      _processor.model.onSurfaceCreated.subscribe(
        (surface) => _append(_AssistantSurface(surface.id)),
      ),
      _processor.model.onSurfaceDeleted.subscribe(_removeSurface),
      _processor.model.onAction.subscribe(_sendAction),
      _processor.model.onError.subscribe(_sendError),
    ];
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.unsubscribe();
    }
    _state.dispose();
    _processor.dispose();
    _pending.dispose();
    _client.dispose();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------------------
  // Model replies and surface events -> display list
  // ----------------------------------------------------------------------

  /// Shows the text of [reply] and applies its A2UI messages to the surfaces.
  /// A block of A2UI the model got wrong goes back to it as an error.
  void _showReply(String reply) {
    final stream = _agent.openContinuingStream(state: _state);
    final parts = <StreamPart>[];
    try {
      parts
        ..addAll(stream.feed(reply))
        ..addAll(stream.close());
    } on A2uiError catch (error) {
      parts
        ..addAll(error.partialResults)
        ..add(ErrorPart(error));
    }

    final text = StringBuffer();
    void showText() {
      final content = text.toString().trim();
      text.clear();
      if (content.isNotEmpty) _append(_AssistantText(content));
    }

    for (final part in parts) {
      switch (part) {
        case TextPart():
          text.write(part.text);
        case A2uiPart(:final a2ui):
          showText();
          _processor.processMessages(AgentToRendererMessagePayload(a2ui));
          for (final message in a2ui.whereType<UpdateComponentsMessage>()) {
            // The model revised an existing surface (e.g. fixing a validation
            // error). Promote it to the latest position so the updated UI
            // becomes the "current" one instead of updating silently up in
            // the history.
            _promoteSurface(message.surfaceId);
          }
        case ErrorPart(:final error):
          showText();
          _sendError(MessageErrorMapper.map(error).error);
      }
    }
    showText();
  }

  void _removeSurface(String surfaceId) {
    if (!mounted) return;
    setState(() {
      _items.removeWhere(
        (i) => i is _AssistantSurface && i.surfaceId == surfaceId,
      );
    });
  }

  /// Moves the surface with [surfaceId] to the end of the list (and scrolls to
  /// it), so an updated surface that had scrolled off-screen becomes the newest
  /// item. No-op if it's already last.
  void _promoteSurface(String surfaceId) {
    if (!mounted) return;
    final index = _items.indexWhere(
      (i) => i is _AssistantSurface && i.surfaceId == surfaceId,
    );
    if (index == -1) return;
    if (index != _items.length - 1) {
      setState(() => _items.add(_items.removeAt(index)));
    }
    _scrollToBottom();
  }

  void _append(_ChatItem item) {
    if (!mounted) return;
    setState(() => _items.add(item));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  // ----------------------------------------------------------------------
  // Sending
  // ----------------------------------------------------------------------

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    _input.clear();
    _append(_UserText(text));
    unawaited(_request(text));
  }

  /// Sends a user interaction with a generated widget (button press, form
  /// submit, ...) to the model.
  void _sendAction(A2uiRendererAction action) {
    final message = ActionMessage(version: _version, action: action);
    unawaited(_request(jsonEncode(message.toJson())));
  }

  /// Sends an error the renderer met to the model, so it can fix the surface.
  void _sendError(A2uiRendererError error) {
    final message = ErrorMessage(version: _version, error: error);
    unawaited(_request(jsonEncode(message.toJson()), isErrorReport: true));
  }

  /// Runs [_sendAndReceive] while the typing indicator shows, and shows what
  /// it throws as an error.
  Future<void> _request(String content, {bool isErrorReport = false}) async {
    _pending.value++;
    try {
      await _sendAndReceive(content, isErrorReport: isErrorReport);
    } catch (error) {
      _append(_AssistantText('⚠️ $error', isError: true));
    } finally {
      if (mounted) _pending.value--;
    }
  }

  /// Aborts the in-flight model request. The pending HTTP call is torn down and
  /// [_sendAndReceive] swallows the resulting cancellation.
  void _stop() {
    _client.cancel();
  }

  /// Called whenever a message must go to the model: either a typed message
  /// or, as A2UI JSON, a user interaction with a generated widget or an error
  /// report. Feeds the reply back through [_showReply].
  Future<void> _sendAndReceive(
    String content, {
    required bool isErrorReport,
  }) async {
    // Break runaway self-talk. Every validation failure goes back to the
    // model as a new request; with models that emit imperfect A2UI this can
    // loop forever ("keeps sending after the response is done"). Cap consecutive
    // automatic error-recovery attempts, and reset on any real turn.
    if (isErrorReport) {
      if (_errorRetries >= _maxErrorRetries) {
        _errorRetries = 0;
        _append(
          _AssistantText(
            'Stopped auto-retrying — the generated UI kept failing validation.',
            isError: true,
          ),
        );
        return;
      }
      _errorRetries++;
    } else {
      _errorRetries = 0;
    }

    _history.add({'role': 'user', 'content': content});

    final String reply;
    try {
      reply = await _client.complete([
        {'role': 'system', 'content': _systemPrompt},
        ..._history,
      ]);
    } on OpenRouterCanceled {
      // User pressed Stop: drop the unanswered turn and end quietly (no error
      // bubble). Returning normally lets _request clear its waiting state.
      if (_history.isNotEmpty) _history.removeLast();
      return;
    }

    _history.add({'role': 'assistant', 'content': reply});
    if (!mounted) return;
    _showReply(reply);
  }

  // ----------------------------------------------------------------------
  // Build
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: const Text('GenUI Chat'),
          subtitle: Text(widget.model).muted,
          trailing: [
            if (widget.onLogout != null)
              GhostButton(
                onPressed: widget.onLogout,
                leading: const Icon(LucideIcons.logOut),
                child: const Text('Log out'),
              ),
          ],
        ),
        const Divider(),
      ],
      child: Column(
        children: [
          Expanded(
            child: _items.isEmpty
                ? const _EmptyState()
                : Builder(
                    builder: (context) {
                      final groups = _groupedItems();
                      return ListView.builder(
                        controller: _scroll,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: groups.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildGroup(groups[index]),
                        ),
                      );
                    },
                  ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _pending,
            builder: (context, pending, _) => pending > 0
                ? const _TypingIndicator()
                : const SizedBox.shrink(),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  /// Collapses [_items] into runs of consecutive same-sender items, so each run
  /// renders as one [ChatGroup] (one avatar, one tail on the last bubble).
  List<List<_ChatItem>> _groupedItems() {
    final groups = <List<_ChatItem>>[];
    for (final item in _items) {
      if (groups.isNotEmpty && groups.last.first.isUser == item.isUser) {
        groups.last.add(item);
      } else {
        groups.add([item]);
      }
    }
    return groups;
  }

  Widget _buildGroup(List<_ChatItem> group) {
    final colors = Theme.of(context).colorScheme;
    final bubbles = [for (final item in group) _bubbleFor(item, colors)];

    // Own messages: right-aligned group, tail on the trailing (end) side.
    if (group.first.isUser) {
      return ChatGroup(
        color: colors.primary,
        alignment: AxisAlignmentDirectional.end,
        type: ChatBubbleType.tail.copyWith(position: () => AxisDirectional.end),
        children: bubbles,
      );
    }

    // Assistant run: left-aligned group sharing one avatar, tail on the leading
    // (start) side. Per-bubble overrides handle errors and surfaces.
    return ChatGroup(
      color: colors.muted,
      avatarPrefix: const Avatar(initials: 'AI'),
      alignment: AxisAlignmentDirectional.start,
      type: ChatBubbleType.tail.copyWith(
        position: () => AxisDirectional.start,
        tailAlignment: () => AxisAlignmentDirectional.end,
      ),
      children: bubbles,
    );
  }

  /// Builds a single bubble, overriding the enclosing group's color/type only
  /// where a particular item needs it (errors, generated surfaces).
  Widget _bubbleFor(_ChatItem item, ColorScheme colors) {
    switch (item) {
      case _UserText(:final text):
        return ChatBubble(
          child: Text(text, style: TextStyle(color: colors.primaryForeground)),
        );
      case _AssistantText(:final text, :final isError):
        return ChatBubble(
          color: isError ? colors.destructive : null,
          child: Text(
            text,
            style: TextStyle(color: isError ? Colors.white : colors.foreground),
          ),
        );
      case _AssistantSurface(:final surfaceId):
        final surface = _processor.model.getSurface(surfaceId);
        return ChatBubble(
          color: colors.card,
          type: PlainChatBubbleType(border: BorderSide(color: colors.border)),
          widthFactor: 0.85,
          child: surface == null
              ? const SizedBox.shrink()
              : A2uiSurface(key: ObjectKey(surface), surface: surface),
        );
    }
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: TextField(
                controller: _input,
                placeholder: const Text('Ask for a form, a card, anything…'),
                onSubmitted: (_) => _send(),
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _pending,
              builder: (context, pending, _) => pending > 0
                  ? DestructiveButton(
                      onPressed: _stop,
                      child: const Icon(LucideIcons.square),
                    )
                  : PrimaryButton(
                      onPressed: _send,
                      child: const Icon(LucideIcons.send),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        spacing: 8,
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(),
          ),
          const Text('Thinking…').muted.small,
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            const Icon(LucideIcons.sparkles).iconXLarge,
            const Text('Generative UI chat').h3,
            const Text(
              'Ask the model to build something. It replies with real '
              'shadcn_flutter widgets rendered right in the conversation.\n\n'
              'Try: “Make a sign-up form” or “Show me a pricing card”.',
              textAlign: TextAlign.center,
            ).muted,
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Display model
// ----------------------------------------------------------------------

sealed class _ChatItem {
  const _ChatItem();

  /// Whether this item belongs to the local user (vs. the assistant).
  bool get isUser => this is _UserText;
}

class _UserText extends _ChatItem {
  const _UserText(this.text);
  final String text;
}

class _AssistantText extends _ChatItem {
  const _AssistantText(this.text, {this.isError = false});
  final String text;
  final bool isError;
}

class _AssistantSurface extends _ChatItem {
  const _AssistantSurface(this.surfaceId);
  final String surfaceId;
}
