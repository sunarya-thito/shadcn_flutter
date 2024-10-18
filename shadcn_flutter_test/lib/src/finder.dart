import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Some frequently used [Finder]s.
const CommonFinders shadcnFind = CommonFinders._();

class CommonFinders {
  const CommonFinders._();

  /// Finds [Text], [EditableText], and optionally [RichText] widgets
  /// containing string equal to the `text` argument.
  ///
  /// If `findRichText` is false, all standalone [RichText] widgets are
  /// ignored and `text` is matched with [Text.data] or [Text.textSpan].
  /// If `findRichText` is true, [RichText] widgets (and therefore also
  /// [Text] and [Text.rich] widgets) are matched by comparing the
  /// [InlineSpan.toPlainText] with the given `text`.
  ///
  /// For [EditableText] widgets, the `text` is always compared to the current
  /// value of the [EditableText.controller].
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are [Offstage] or that are from inactive [Route]s.
  ///
  /// ## Sample code
  ///
  /// ```dart
  /// expect(find.text('Back'), findsOneWidget);
  /// ```
  ///
  /// This will match [Text], [Text.rich], and [EditableText] widgets that
  /// contain the "Back" string.
  ///
  /// ```dart
  /// expect(find.text('Close', findRichText: true), findsOneWidget);
  /// ```
  ///
  /// This will match [Text], [Text.rich], [EditableText], as well as standalone
  /// [RichText] widgets that contain the "Close" string.
  Finder text(
    String text, {
    bool findRichText = false,
    bool skipOffstage = true,
  }) {
    return _TextWidgetFinder(
      text,
      findRichText: findRichText,
      skipOffstage: skipOffstage,
    );
  }

  /// Finds [Text] and [EditableText], and optionally [RichText] widgets
  /// which contain the given `pattern` argument.
  ///
  /// If `findRichText` is false, all standalone [RichText] widgets are
  /// ignored and `pattern` is matched with [Text.data] or [Text.textSpan].
  /// If `findRichText` is true, [RichText] widgets (and therefore also
  /// [Text] and [Text.rich] widgets) are matched by comparing the
  /// [InlineSpan.toPlainText] with the given `pattern`.
  ///
  /// For [EditableText] widgets, the `pattern` is always compared to the current
  /// value of the [EditableText.controller].
  ///
  /// If the `skipOffstage` argument is true (the default), then this skips
  /// nodes that are [Offstage] or that are from inactive [Route]s.
  ///
  /// ## Sample code
  ///
  /// ```dart
  /// expect(find.textContaining('Back'), findsOneWidget);
  /// expect(find.textContaining(RegExp(r'(\w+)')), findsOneWidget);
  /// ```
  ///
  /// This will match [Text], [Text.rich], and [EditableText] widgets that
  /// contain the given pattern : 'Back' or RegExp(r'(\w+)').
  ///
  /// ```dart
  /// expect(find.textContaining('Close', findRichText: true), findsOneWidget);
  /// expect(find.textContaining(RegExp(r'(\w+)'), findRichText: true), findsOneWidget);
  /// ```
  ///
  /// This will match [Text], [Text.rich], [EditableText], as well as standalone
  /// [RichText] widgets that contain the given pattern : 'Close' or RegExp(r'(\w+)').
  Finder textContaining(
    Pattern pattern, {
    bool findRichText = false,
    bool skipOffstage = true,
  }) {
    return _TextContainingWidgetFinder(pattern,
        findRichText: findRichText, skipOffstage: skipOffstage);
  }
}

abstract class _MatchTextFinder extends MatchFinder {
  _MatchTextFinder({
    this.findRichText = false,
    super.skipOffstage,
  });

  /// Whether standalone [RichText] widgets should be found or not.
  ///
  /// Defaults to `false`.
  ///
  /// If disabled, only [Text] widgets will be matched. [RichText] widgets
  /// *without* a [Text] ancestor will be ignored.
  /// If enabled, only [RichText] widgets will be matched. This *implicitly*
  /// matches [Text] widgets as well since they always insert a [RichText]
  /// child.
  ///
  /// In either case, [EditableText] widgets will also be matched.
  final bool findRichText;

  bool matchesText(String textToMatch);

  @override
  bool matches(Element candidate) {
    final Widget widget = candidate.widget;
    if (widget is EditableText) {
      return _matchesEditableText(widget);
    }

    if (!findRichText) {
      return _matchesNonRichText(widget);
    }
    // It would be sufficient to always use _matchesRichText if we wanted to
    // match both standalone RichText widgets as well as Text widgets. However,
    // the find.text() finder used to always ignore standalone RichText widgets,
    // which is why we need the _matchesNonRichText method in order to not be
    // backwards-compatible and not break existing tests.
    return _matchesRichText(widget);
  }

  bool _matchesRichText(Widget widget) {
    if (widget is RichText) {
      return matchesText(widget.text.toPlainText());
    }
    return false;
  }

  bool _matchesNonRichText(Widget widget) {
    if (widget is Text) {
      if (widget.data != null) {
        return matchesText(widget.data!);
      }
      assert(widget.textSpan != null);
      return matchesText(widget.textSpan!.toPlainText());
    }
    return false;
  }

  bool _matchesEditableText(EditableText widget) {
    return matchesText(widget.controller.text);
  }
}

class _TextWidgetFinder extends _MatchTextFinder {
  _TextWidgetFinder(
    this.text, {
    super.findRichText,
    super.skipOffstage,
  });

  final String text;

  @override
  String get description => 'text "$text"';

  @override
  bool matchesText(String textToMatch) {
    return textToMatch == text;
  }
}

class _TextContainingWidgetFinder extends _MatchTextFinder {
  _TextContainingWidgetFinder(
    this.pattern, {
    super.findRichText,
    super.skipOffstage,
  });

  final Pattern pattern;

  @override
  String get description => 'text containing $pattern';

  @override
  bool matchesText(String textToMatch) {
    return textToMatch.contains(pattern);
  }
}
