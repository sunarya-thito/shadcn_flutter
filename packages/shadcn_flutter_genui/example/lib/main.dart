import 'package:genui/genui.dart' show configureLogging;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_page.dart';
import 'login_page.dart';

/// Preference keys used to persist the session on-device.
const String _kApiKeyPref = 'openrouter_api_key';
const String _kModelPref = 'openrouter_model';

/// Default model, overridable at build time with
/// `--dart-define=OPENROUTER_MODEL=...`. The login screen pre-fills this and
/// the user can change it per-session.
const String kDefaultModel = String.fromEnvironment(
  'OPENROUTER_MODEL',
  defaultValue: 'tencent/hy3:free',
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Forward GenUI's internal logging to the debug console. Handy when the model
  // emits malformed A2UI JSON.
  configureLogging(
    logCallback: (level, msg) => debugPrint('GenUI $level: $msg'),
  );
  runApp(const GenUiChatApp());
}

class GenUiChatApp extends StatelessWidget {
  const GenUiChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'GenUI Chat',
      theme: ThemeData(colorScheme: ColorSchemes.darkZinc, radius: 0.6),
      home: const _SessionGate(),
    );
  }
}

/// Loads the saved API key from [SharedPreferences] and shows either the login
/// screen or the chat, keeping the two in sync as the user logs in/out.
class _SessionGate extends StatefulWidget {
  const _SessionGate();

  @override
  State<_SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<_SessionGate> {
  SharedPreferences? _prefs;
  String? _apiKey;
  String _model = kDefaultModel;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (!mounted) return;
      final key = prefs.getString(_kApiKeyPref);
      setState(() {
        _prefs = prefs;
        _apiKey = (key != null && key.isNotEmpty) ? key : null;
        _model = prefs.getString(_kModelPref) ?? kDefaultModel;
      });
    });
  }

  Future<void> _login(String apiKey, String model) async {
    await _prefs?.setString(_kApiKeyPref, apiKey);
    await _prefs?.setString(_kModelPref, model);
    if (!mounted) return;
    setState(() {
      _apiKey = apiKey;
      _model = model;
    });
  }

  Future<void> _logout() async {
    await _prefs?.remove(_kApiKeyPref);
    if (!mounted) return;
    setState(() => _apiKey = null);
  }

  @override
  Widget build(BuildContext context) {
    // Still loading prefs.
    if (_prefs == null) {
      return const Scaffold(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final key = _apiKey;
    if (key == null) {
      return LoginPage(initialModel: _model, onSubmit: _login);
    }

    return ChatPage(
      // Rebuild a fresh chat session (new controllers, empty history) whenever
      // the key or model changes.
      key: ValueKey('$key::$_model'),
      apiKey: key,
      model: _model,
      onLogout: _logout,
    );
  }
}
