---
title: "Class: ShadcnLocalizationsDelegate"
description: "Localization delegate for Shadcn Flutter components."
---

```dart
/// Localization delegate for Shadcn Flutter components.
///
/// Provides localized strings and formatters for UI components.
/// Supports internationalization of form validation messages, date formats,
/// and other user-facing text.
class ShadcnLocalizationsDelegate extends LocalizationsDelegate<ShadcnLocalizations> {
  /// Singleton instance of the delegate.
  static const ShadcnLocalizationsDelegate delegate = ShadcnLocalizationsDelegate();
  /// Creates a [ShadcnLocalizationsDelegate].
  const ShadcnLocalizationsDelegate();
  bool isSupported(Locale locale);
  Future<ShadcnLocalizations> load(Locale locale);
  bool shouldReload(ShadcnLocalizationsDelegate old);
}
```
