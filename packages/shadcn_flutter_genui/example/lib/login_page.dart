import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A simple "login" screen that collects the OpenRouter API key (and,
/// optionally, the model) before entering the chat.
///
/// The key is handed to [onSubmit], which persists it (see the session gate in
/// `main.dart`) so it survives restarts.
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.onSubmit,
    required this.initialModel,
  });

  final Future<void> Function(String apiKey, String model) onSubmit;
  final String initialModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyController = TextEditingController();
  late final _modelController = TextEditingController(text: widget.initialModel);
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _keyController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final key = _keyController.text.trim();
    if (key.isEmpty) {
      setState(() => _error = 'Please enter your OpenRouter API key.');
      return;
    }
    final model = _modelController.text.trim();
    setState(() {
      _submitting = true;
      _error = null;
    });
    await widget.onSubmit(key, model.isEmpty ? widget.initialModel : model);
    // The session gate swaps this page out on success; guard just in case.
    if (mounted) setState(() => _submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.sparkles),
                      const SizedBox(width: 8),
                      const Text('GenUI Chat').h3,
                    ],
                  ),
                  const Text(
                    'Sign in with your OpenRouter API key to start chatting. '
                    'The key is stored on this device only.',
                  ).muted,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 6,
                    children: [
                      const Text('OpenRouter API key').semiBold.small,
                      TextField(
                        controller: _keyController,
                        obscureText: true,
                        placeholder: const Text('sk-or-...'),
                        onSubmitted: (_) => _submit(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 6,
                    children: [
                      const Text('Model').semiBold.small,
                      TextField(
                        controller: _modelController,
                        placeholder: const Text('provider/model:free'),
                        onSubmitted: (_) => _submit(),
                      ),
                    ],
                  ),
                  if (_error != null)
                    Row(
                      spacing: 6,
                      children: [
                        Icon(
                          LucideIcons.circleAlert,
                          color: Theme.of(context).colorScheme.destructive,
                          size: 16,
                        ),
                        Expanded(
                          child: Text(
                            _error!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.destructive,
                            ),
                          ).small,
                        ),
                      ],
                    ),
                  PrimaryButton(
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Continue'),
                  ),
                  const Text(
                    'Get a free key at openrouter.ai/keys',
                    textAlign: TextAlign.center,
                  ).muted.xSmall,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
