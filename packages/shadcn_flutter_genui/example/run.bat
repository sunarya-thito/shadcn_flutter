@echo off
rem ---------------------------------------------------------------------------
rem Launches the GenUI chat example.
rem
rem The OpenRouter API key is now entered on the app's login screen and stored
rem on-device (shared_preferences), so nothing secret is passed here.
rem
rem Usage:
rem   run.bat                 (runs on the default device)
rem   run.bat -d chrome       (any extra args are forwarded to `flutter run`)
rem   run.bat -d windows
rem
rem Optional: change the model the login screen pre-fills with.
rem   set OPENROUTER_MODEL=meta-llama/llama-3.3-70b-instruct:free
rem ---------------------------------------------------------------------------
setlocal

if "%OPENROUTER_MODEL%"=="" (
  flutter run %*
) else (
  echo [run.bat] Default model: %OPENROUTER_MODEL%
  flutter run --dart-define=OPENROUTER_MODEL=%OPENROUTER_MODEL% %*
)

endlocal
