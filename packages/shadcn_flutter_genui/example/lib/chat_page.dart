import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' as m;
import 'package:genui/genui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/shadcn_flutter_genui.dart';

import 'openrouter_client.dart';

/// A full chat screen: the user talks to an OpenRouter model, and the model's
/// replies are rendered both as plain text bubbles and as live shadcn_flutter
/// UI (via GenUI surfaces) inline in the conversation.
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
  // --- GenUI wiring -----------------------------------------------------
  late final Catalog _catalog;
  late final SurfaceController _controller;
  late final A2uiTransportAdapter _transport;
  late final Conversation _conversation;
  late final String _systemPrompt;
  StreamSubscription<ConversationEvent>? _events;

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
    // We register it under [basicCatalogId] (the well-known A2UI basic-catalog
    // URI). Models emit that URI as the `catalogId` on createSurface by
    // default, and the SurfaceController resolves surfaces by matching that id,
    // so aligning the id here avoids "catalog not found" errors.
    _catalog = GenCatalog.asCatalog().copyWith(catalogId: basicCatalogId);

    _controller = SurfaceController(catalogs: [_catalog]);
    _transport = A2uiTransportAdapter(onSend: _sendAndReceive);
    _conversation = Conversation(
      controller: _controller,
      transport: _transport,
    );

    // Instructions that teach the model the A2UI protocol plus our persona.
    //
    // We use `custom` with create+update operations (rather than `chat`, which
    // is create-only) so that when a surface fails validation the model can
    // repair it in place via `updateComponents` on the SAME surfaceId, instead
    // of spawning a fresh duplicate surface for every retry.
    _systemPrompt = PromptBuilder.custom(
      catalog: _catalog,
      allowedOperations: SurfaceOperations.createAndUpdate(dataModel: false),
      systemPromptFragments: [
        'You are a friendly assistant demonstrating the shadcn_flutter GenUI '
            'catalog inside a chat app.',
        'Whenever it helps answer the user, render rich, interactive UI '
            '(cards, forms, text fields, buttons, alerts, badges, sliders, '
            'tabs, accordions) instead of describing it in prose.',
        'For a brand new answer, create a new surface. But if you receive an '
            'error message (e.g. code VALIDATION_FAILED) for a surface, do NOT '
            'create a new surface: fix the problem and re-send an '
            '`updateComponents` message reusing that same `surfaceId`.',
        PromptFragments.acknowledgeUser(),
        PromptFragments.currentDate(),
      ],
    ).systemPromptJoined();

    _events = _conversation.events.listen(_onConversationEvent);
  }

  @override
  void dispose() {
    _events?.cancel();
    _conversation.dispose();
    _transport.dispose();
    _controller.dispose();
    _client.dispose();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------------------
  // Conversation events -> display list
  // ----------------------------------------------------------------------

  void _onConversationEvent(ConversationEvent event) {
    switch (event) {
      case ConversationContentReceived(:final text):
        _append(_AssistantText(text));
      case ConversationSurfaceAdded(:final surfaceId):
        _append(_AssistantSurface(surfaceId));
      case ConversationComponentsUpdated(:final surfaceId):
        // The model revised an existing surface (e.g. fixing a validation
        // error). Promote it to the latest position so the updated UI becomes
        // the "current" one instead of updating silently up in the history.
        _promoteSurface(surfaceId);
      case ConversationSurfaceRemoved(:final surfaceId):
        if (!mounted) return;
        setState(() {
          _items.removeWhere(
            (i) => i is _AssistantSurface && i.surfaceId == surfaceId,
          );
        });
      case ConversationError(:final error):
        _append(_AssistantText('⚠️ $error', isError: true));
      default:
        // ConversationWaiting needs no list change: the typing indicator
        // watches conversation.state.
        break;
    }
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
    // Kicks off _sendAndReceive via the transport's onSend.
    _conversation.sendRequest(ChatMessage.user(text));
  }

  /// Aborts the in-flight model request. The pending HTTP call is torn down and
  /// [_sendAndReceive] swallows the resulting cancellation.
  void _stop() {
    _client.cancel();
  }

  /// Called by the transport whenever a message must go to the model: either a
  /// typed message or a user interaction with a generated widget (button press,
  /// form submit, ...). Feeds the reply back through [A2uiTransportAdapter].
  Future<void> _sendAndReceive(ChatMessage message) async {
    final buffer = StringBuffer();
    var isErrorReport = false;
    for (final part in message.parts) {
      if (part.isUiInteractionPart) {
        final interaction = part.asUiInteractionPart!.interaction;
        if (_isErrorInteraction(interaction)) isErrorReport = true;
        buffer.write(interaction);
      } else if (part is TextPart) {
        buffer.write(part.text);
      }
    }
    final content = buffer.toString();
    if (content.isEmpty) return;

    // Break runaway self-talk. genui forwards every validation failure back to
    // the model as a new request; with models that emit imperfect A2UI this can
    // loop forever ("keeps sending after the response is done"). Cap consecutive
    // automatic error-recovery attempts, and reset on any real turn.
    if (isErrorReport) {
      if (_errorRetries >= _maxErrorRetries) {
        _errorRetries = 0;
        _append(_AssistantText(
          'Stopped auto-retrying — the generated UI kept failing validation.',
          isError: true,
        ));
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
      // bubble). Returning normally lets Conversation clear its waiting state.
      if (_history.isNotEmpty) _history.removeLast();
      return;
    }

    _history.add({'role': 'assistant', 'content': reply});
    _transport.addChunk(reply);
  }

  /// Whether a UI interaction payload is a genui error report (as opposed to a
  /// genuine user action like a button press).
  bool _isErrorInteraction(String interaction) {
    try {
      final decoded = jsonDecode(interaction);
      return decoded is Map && decoded['error'] != null;
    } catch (_) {
      return false;
    }
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
          ValueListenableBuilder<ConversationState>(
            valueListenable: _conversation.state,
            builder: (context, state, _) => state.isWaiting
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
        type: ChatBubbleType.tail.copyWith(
          position: () => AxisDirectional.end,
        ),
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
          child: Text(
            text,
            style: TextStyle(color: colors.primaryForeground),
          ),
        );
      case _AssistantText(:final text, :final isError):
        return ChatBubble(
          color: isError ? colors.destructive : null,
          child: Text(
            text,
            style: TextStyle(
              color: isError ? Colors.white : colors.foreground,
            ),
          ),
        );
      case _AssistantSurface(:final surfaceId):
        return ChatBubble(
          color: colors.card,
          type: PlainChatBubbleType(border: BorderSide(color: colors.border)),
          widthFactor: 0.85,
          child: _MaterialHost(
            child: Surface(
              surfaceContext: _controller.contextFor(surfaceId),
            ),
          ),
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
            ValueListenableBuilder<ConversationState>(
              valueListenable: _conversation.state,
              builder: (context, state, _) => state.isWaiting
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

/// Provides a Material `Theme` + `Material` ancestor so the GenUI basic widgets
/// (e.g. `Text`, and the error fallback) that call `Theme.of(context)` work,
/// even though the host app is built on shadcn_flutter rather than Material.
class _MaterialHost extends StatelessWidget {
  const _MaterialHost({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return m.Theme(
      data: m.ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorScheme: m.ColorScheme.fromSeed(
          seedColor: const m.Color(0xFF6366F1),
          brightness: brightness,
        ),
      ),
      child: m.Material(
        type: m.MaterialType.transparency,
        child: child,
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
