import 'package:shadcn_flutter/shadcn_flutter.dart';

class JapaneseShadcnLocalizations extends ShadcnLocalizations {
  static const ShadcnLocalizations instance = JapaneseShadcnLocalizations();

  const JapaneseShadcnLocalizations();

  @override
  final Map<String, String> localizedMimeTypes = const {
    'audio/aac': 'AAC オーディオ',
    'application/x-abiword': 'AbiWord ドキュメント',
    'image/apng': 'アニメーションされたポータブルネットワークグラフィック',
    'application/x-freearc': 'アーカイブドキュメント',
    'image/avif': 'AVIF 画像',
    'video/x-msvideo': 'AVI: オーディオビデオインターリーブ',
    'application/vnd.amazon.ebook': 'Amazon Kindle 電子書籍形式',
    'application/octet-stream': 'バイナリデータ',
    'image/bmp': 'Windows OS/2 ビットマップグラフィック',
    'application/x-bzip': 'BZip アーカイブ',
    'application/x-bzip2': 'BZip2 アーカイブ',
    'application/x-cdf': 'CD オーディオ',
    'application/x-csh': 'Cシェルスクリプト',
    'text/css': 'CSS (カスケーディングスタイルシート)',
    'text/csv': 'CSV (カンマ区切りの値)',
    'application/msword': 'マイクロソフトワード',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'マイクロソフトワード (OpenXML)',
    'application/vnd.ms-fontobject': 'MS 埋め込みOpenType フォント',
    'application/epub+zip': 'Electronic Publication (EPUB)',
    'application/gzip': 'GZip 圧縮アーカイブ',
    'image/gif': 'GIF (グラフィックスインターチェンジフォーマット)',
    'text/html': 'HTML (ハイパーテキストマークアップ言語)',
    'image/vnd.microsoft.icon': 'アイコン形式',
    'text/calendar': 'iCalendar 形式',
    'application/java-archive': 'Java アーカイブ (JAR)',
    'image/jpeg': 'JPEG 画像',
    'text/javascript': 'JavaScript',
    'application/json': 'JSON 形式',
    'application/ld+json': 'JSON-LD Format',
    'audio/midi': 'MIDI (デジタル楽器インターフェイス)',
    'audio/x-midi': 'MIDI (デジタル楽器インターフェイス)',
    'audio/mpeg': 'MP3 オーディオ',
    'video/mp4': 'MP4 ビデオ',
    'video/mpeg': 'MPEG ビデオ',
    'application/vnd.apple.installer+xml': 'Apple Installer Package',
    'application/vnd.oasis.opendocument.presentation': 'OpenDocument プレゼンテーションドキュメント',
    'application/vnd.oasis.opendocument.spreadsheet': 'OpenDocument スプレッドシートドキュメント',
    'application/vnd.oasis.opendocument.text': 'OpenDocument テキストドキュメント',
    'audio/ogg': 'Ogg オーディオ',
    'video/ogg': 'Ogg ビデオ',
    'application/ogg': 'Ogg',
    'font/otf': 'OpenType フォント',
    'image/png': 'ポータブルネットワークグラフィック',
    'application/pdf': 'PDF (アドビポータブルドキュメントフォーマット)',
    'application/x-httpd-php': 'PHP (ハイパーテキストプリプロセッサ)',
    'application/vnd.ms-powerpoint': 'マイクロソフトパワーポイント',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'マイクロソフトパワーポイント (OpenXML)',
    'application/vnd.rar': 'RAR アーカイブ',
    'application/rtf': 'RTF (リッチテキストフォーマット)',
    'application/x-sh': 'Bourne シェルスクリプト',
    'image/svg+xml': 'Scalable Vector Graphics (SVG)',
    'application/x-tar': 'テープアーカイブ (TAR)',
    'image/tiff': 'TIFF (タグ付き画像ファイル形式)',
    'video/mp2t': 'MPEG トランスポートストリーム',
    'font/ttf': 'TrueType フォント',
    'text/plain': 'テキスト',
    'application/vnd.visio': 'マイクロソフトVisio',
    'audio/wav': 'Waveform オーディオ形式',
    'audio/webm': 'WEBM オーディオ',
    'video/webm': 'WEBM ビデオ',
    'image/webp': 'WEBP 画像',
    'font/woff': 'Web オープンフォントフォーマット (WOFF)',
    'font/woff2': 'Web オープンフォントフォーマット (WOFF)',
    'application/xhtml+xml': 'XHTML',
    'application/vnd.ms-excel': 'マイクロソフトExcel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'マイクロソフトExcel (OpenXML)',
    'application/xml': 'XML',
    'application/vnd.mozilla.xul+xml': 'XUL',
    'application/zip': 'ZIP アーカイブ',
    'video/3gpp': '3GPP オーディオ/ビデオコンテナ',
    'audio/3gpp': '3GPP オーディオ/ビデオコンテナ',
    'video/3gpp2': '3GPP2 オーディオ/ビデオコンテナ',
    'audio/3gpp2': '3GPP2 オーディオ/ビデオコンテナ',
    'application/x-7z-compressed': '7-Zip アーカイブ',
  };

  @override
  String get commandSearch => 'コマンドを入力するか検索してください...';

  @override
  String get commandEmpty => '結果が見つかりません。';

  @override
  String get formNotEmpty => 'このフィールドは空にできません。';

  @override
  String get invalidValue => '無効な値です。';

  @override
  String get invalidEmail => '無効なメールアドレスです。';

  @override
  String get invalidURL => '無効なURLです。';

  @override
  String formatNumber(double value) {
    // if the value is an integer, return it as an integer
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  String formLessThan(double value) => '${formatNumber(value)}未満である必要があります';

  @override
  String formGreaterThan(double value) => '${formatNumber(value)}より大きい必要があります';

  @override
  String formLessThanOrEqualTo(double value) => '${formatNumber(value)}以下である必要があります';

  @override
  String formGreaterThanOrEqualTo(double value) => '${formatNumber(value)}以上である必要があります';

  @override
  String formBetweenInclusively(double min, double max) =>
      '${formatNumber(min)}から${formatNumber(max)}の間である必要があります（両端を含む）';

  @override
  String formBetweenExclusively(double min, double max) =>
      '${formatNumber(min)}から${formatNumber(max)}の間である必要があります（両端を含まない）';

  @override
  String formLengthLessThan(int value) => '少なくとも$value文字である必要があります';

  @override
  String formLengthGreaterThan(int value) => '最大$value文字までである必要があります';

  @override
  String get formPasswordDigits => '少なくとも1つの数字を含める必要があります。';

  @override
  String get formPasswordLowercase => '少なくとも1つの小文字を含める必要があります。';

  @override
  String get formPasswordUppercase => '少なくとも1つの大文字を含める必要があります。';

  @override
  String get formPasswordSpecial => '少なくとも1つの特殊文字を含める必要があります。';

  @override
  String get abbreviatedMonday => '月';

  @override
  String get abbreviatedTuesday => '火';

  @override
  String get abbreviatedWednesday => '水';

  @override
  String get abbreviatedThursday => '木';

  @override
  String get abbreviatedFriday => '金';

  @override
  String get abbreviatedSaturday => '土';

  @override
  String get abbreviatedSunday => '日';

  @override
  String get monthJanuary => '1月';

  @override
  String get monthFebruary => '2月';

  @override
  String get monthMarch => '3月';

  @override
  String get monthApril => '4月';

  @override
  String get monthMay => '5月';

  @override
  String get monthJune => '6月';

  @override
  String get monthJuly => '7月';

  @override
  String get monthAugust => '8月';

  @override
  String get monthSeptember => '9月';

  @override
  String get monthOctober => '10月';

  @override
  String get monthNovember => '11月';

  @override
  String get monthDecember => '12月';

  @override
  String get buttonCancel => 'キャンセル';

  @override
  String get buttonOk => 'OK';

  @override
  String get buttonClose => '閉じる';

  @override
  String get buttonSave => '保存';

  @override
  String get buttonReset => 'リセット';

  @override
  String formatDateTime(DateTime dateTime,
      {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true}) {
    String result = '';
    if (showDate) {
      result += '${getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    }
    if (showTime) {
      if (use24HourFormat) {
        if (result.isNotEmpty) {
          result += ' ';
        }
        result += '${dateTime.hour}:${dateTime.minute}';
        if (showSeconds) {
          result += ':${dateTime.second}';
        }
      } else {
        if (result.isNotEmpty) {
          result += ' ';
        }
        int hour = dateTime.hour;
        if (hour > 12) {
          hour -= 12;
          result += '$hour:${dateTime.minute} PM';
        } else {
          result += '$hour:${dateTime.minute} AM';
        }
      }
    }
    return result;
  }

  @override
  String get placeholderDatePicker => '日付を選択してください';

  @override
  String get placeholderColorPicker => '色を選択してください';

  @override
  String get buttonNext => '次へ';

  @override
  String get buttonPrevious => '前へ';

  @override
  String get searchPlaceholderCountry => '国を検索...';

  @override
  String get emptyCountryList => '国が見つかりません。';

  @override
  String get placeholderTimePicker => '時間を選択してください';

  @override
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false}) {
    String result = '';
    if (use24HourFormat) {
      result += '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      if (showSeconds) {
        result += ':${time.second.toString().padLeft(2, '0')}';
      }
    } else {
      int hour = time.hour;
      if (hour > 12) {
        hour -= 12;
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} PM';
        } else {
          result += '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} PM';
        }
      } else {
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} AM';
        } else {
          result += '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} AM';
        }
      }
    }
    return result;
  }

  @override
  String get timeHour => '時';

  @override
  String get timeMinute => '分';

  @override
  String get timeSecond => '秒';

  @override
  String get timeAM => '午前';

  @override
  String get timePM => '午後';

  @override
  String get toastSnippetCopied => 'クリップボードにコピーされました。';

  @override
  String get datePickerSelectYear => '年を選択してください';

  @override
  String get abbreviatedJanuary => '1月';

  @override
  String get abbreviatedFebruary => '2月';

  @override
  String get abbreviatedMarch => '3月';

  @override
  String get abbreviatedApril => '4月';

  @override
  String get abbreviatedMay => '5月';

  @override
  String get abbreviatedJune => '6月';

  @override
  String get abbreviatedJuly => '7月';

  @override
  String get abbreviatedAugust => '8月';

  @override
  String get abbreviatedSeptember => '9月';

  @override
  String get abbreviatedOctober => '10月';

  @override
  String get abbreviatedNovember => '11月';

  @override
  String get abbreviatedDecember => '12月';

  @override
  String get colorRed => '赤';

  @override
  String get colorGreen => '緑';

  @override
  String get colorBlue => '青';

  @override
  String get colorAlpha => 'アルファ';

  @override
  String get menuCut => '切り取り';

  @override
  String get menuCopy => 'コピー';

  @override
  String get menuPaste => '貼り付け';

  @override
  String get menuSelectAll => 'すべて選択';

  @override
  String get menuUndo => '元に戻す';

  @override
  String get menuRedo => 'やり直し';

  @override
  String get menuDelete => '削除';

  @override
  String get menuShare => '共有';

  @override
  String get menuSearchWeb => 'ウェブ検索';

  @override
  String get menuLiveTextInput => 'ライブテキスト入力';

  @override
  String get refreshTriggerPull => '引っ張って更新';

  @override
  String get refreshTriggerRelease => '離して更新';

  @override
  String get refreshTriggerRefreshing => '更新中...';

  @override
  String get refreshTriggerComplete => '更新完了';

  @override
  String get colorPickerTabRecent => '最近';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorHue => '色相';

  @override
  String get colorSaturation => '彩度';

  @override
  String get colorValue => '値';

  @override
  String get colorLightness => '明度';
}
