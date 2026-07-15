import 'dart:convert';

import 'package:http/http.dart' as http;

/// A minimal client for the OpenRouter chat-completions API.
///
/// OpenRouter exposes an OpenAI-compatible `/chat/completions` endpoint, so a
/// request is just a list of `{role, content}` messages. This example uses the
/// non-streaming variant: the whole assistant reply comes back in one response
/// body, which the GenUI parser then splits into text and A2UI messages.
///
/// An in-flight request can be aborted with [cancel]: each request runs on its
/// own [http.Client], and closing that client tears down the pending
/// connection (surfacing as an [OpenRouterCanceled]).
class OpenRouterClient {
  OpenRouterClient({required this.apiKey, required this.model});

  /// OpenRouter API key (`sk-or-...`).
  final String apiKey;

  /// Model slug, e.g. `deepseek/deepseek-chat-v3.1:free`.
  final String model;

  /// The client backing the currently in-flight request, if any.
  http.Client? _active;

  static final Uri _endpoint = Uri.parse(
    'https://openrouter.ai/api/v1/chat/completions',
  );

  /// Sends [messages] (each `{'role': ..., 'content': ...}`) and returns the
  /// assistant's text content.
  ///
  /// Throws [OpenRouterCanceled] if [cancel] is called mid-request, or
  /// [OpenRouterException] on any other failure.
  Future<String> complete(List<Map<String, String>> messages) async {
    final client = http.Client();
    _active = client;

    final http.Response response;
    try {
      response = await client.post(
        _endpoint,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          // Optional attribution headers recommended by OpenRouter.
          'HTTP-Referer': 'https://github.com/sunarya-thito/shadcn_flutter',
          'X-Title': 'shadcn_flutter GenUI Chat',
        },
        body: jsonEncode({'model': model, 'messages': messages}),
      );
    } on http.ClientException catch (e) {
      // Closing the client from cancel() aborts the request and lands here.
      if (identical(_active, client)) {
        throw OpenRouterException('Network error while calling OpenRouter: $e');
      }
      throw const OpenRouterCanceled();
    } catch (e) {
      throw OpenRouterException('Network error while calling OpenRouter: $e');
    } finally {
      if (identical(_active, client)) _active = null;
      client.close();
    }

    if (response.statusCode != 200) {
      throw OpenRouterException(
        'OpenRouter returned ${response.statusCode}: '
        '${_extractError(response.body)}',
      );
    }

    final Map<String, Object?> json =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, Object?>;
    final choices = json['choices'] as List<Object?>?;
    if (choices == null || choices.isEmpty) {
      throw OpenRouterException('OpenRouter response had no choices.');
    }
    final message = (choices.first as Map<String, Object?>)['message']
        as Map<String, Object?>?;
    final content = message?['content'] as String?;
    if (content == null) {
      throw OpenRouterException('OpenRouter response had no message content.');
    }
    return content;
  }

  /// Aborts the in-flight [complete] call, if any.
  void cancel() {
    final client = _active;
    _active = null;
    client?.close();
  }

  String _extractError(String body) {
    try {
      final json = jsonDecode(body) as Map<String, Object?>;
      final error = json['error'];
      if (error is Map<String, Object?>) {
        return error['message']?.toString() ?? body;
      }
    } catch (_) {
      // Fall through and return the raw body.
    }
    return body;
  }

  void dispose() => cancel();
}

/// Thrown when an OpenRouter request fails.
class OpenRouterException implements Exception {
  const OpenRouterException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Thrown when an in-flight request is aborted via [OpenRouterClient.cancel].
class OpenRouterCanceled implements Exception {
  const OpenRouterCanceled();

  @override
  String toString() => 'OpenRouter request canceled';
}
