import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../shadcn_flutter.dart';

class ShadcnLocalizationsDelegate extends LocalizationsDelegate<ShadcnLocalizations> {
  static const ShadcnLocalizationsDelegate delegate = ShadcnLocalizationsDelegate();
  const ShadcnLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ko', 'ja'].contains(locale.languageCode);

  @override
  Future<ShadcnLocalizations> load(Locale locale) {
    return SynchronousFuture<ShadcnLocalizations>(
      locale.languageCode == 'ko' //
          ? KoreanShadcnLocalizations.instance
          : locale.languageCode == 'ja'
              ? JapaneseShadcnLocalizations.instance
              : DefaultShadcnLocalizations.instance,
    );
  }

  @override
  bool shouldReload(ShadcnLocalizationsDelegate old) => false;
}

const _fileByteUnits = SizeUnitLocale(1024, ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']);
const _fileBitUnits = SizeUnitLocale(1024, ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']);

class SizeUnitLocale {
  final int base;
  final List<String> units;
  // separator for digit grouping, e.g. 1,000,000
  final String separator;
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});

  String getUnit(int value) {
    if (value <= 0) return '0 ${units[0]}';
    var log10 = _log10(value);
    final digitGroups = (log10 / _log10(base)).floor();
    final unitIndex = min(digitGroups, units.length - 1);
    return units[unitIndex];
  }
}

double _log10(num x) {
  return log(x) / ln10;
}

String formatFileSize(int bytes, SizeUnitLocale unit) {
  if (bytes <= 0) return '0 ${unit.units[0]}';
  final base = unit.base;
  final units = unit.units;
  int digitGroups = (_log10(bytes) / _log10(base)).floor();
  // return '${NumberFormat('#,##0.#').format(bytes / pow(base, digitGroups))} ${units[digitGroups]}';
  // do it without NumberFormat, but format to #,##0.# format
  final value = bytes / pow(base, digitGroups);
  final formattedValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  return '$formattedValue ${units[digitGroups]}';
}

abstract class ShadcnLocalizations {
  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(context, ShadcnLocalizations) ?? DefaultShadcnLocalizations.instance;
  }

  const ShadcnLocalizations();
  // String formatFileSize(int bytes);
  String get formNotEmpty;
  String get invalidValue;
  String get invalidEmail;
  String get invalidURL;
  String formatNumber(double value);
  String formLessThan(double value);
  String formGreaterThan(double value);
  String formLessThanOrEqualTo(double value);
  String formGreaterThanOrEqualTo(double value);
  String formBetweenInclusively(double min, double max);
  String formBetweenExclusively(double min, double max);
  String formLengthLessThan(int value);
  String formLengthGreaterThan(int value);
  String get formPasswordDigits;
  String get formPasswordLowercase;
  String get formPasswordUppercase;
  String get formPasswordSpecial;

  String get commandSearch;
  String get commandEmpty;
  String get datePickerSelectYear;
  String get abbreviatedMonday;
  String get abbreviatedTuesday;
  String get abbreviatedWednesday;
  String get abbreviatedThursday;
  String get abbreviatedFriday;
  String get abbreviatedSaturday;
  String get abbreviatedSunday;
  String get monthJanuary;
  String get monthFebruary;
  String get monthMarch;
  String get monthApril;
  String get monthMay;
  String get monthJune;
  String get monthJuly;
  String get monthAugust;
  String get monthSeptember;
  String get monthOctober;
  String get monthNovember;
  String get monthDecember;
  String get abbreviatedJanuary;
  String get abbreviatedFebruary;
  String get abbreviatedMarch;
  String get abbreviatedApril;
  String get abbreviatedMay;
  String get abbreviatedJune;
  String get abbreviatedJuly;
  String get abbreviatedAugust;
  String get abbreviatedSeptember;
  String get abbreviatedOctober;
  String get abbreviatedNovember;
  String get abbreviatedDecember;
  String get buttonCancel;
  String get buttonOk;
  String get buttonClose;
  String get buttonSave;
  String get buttonReset;
  String get timeHour;
  String get timeMinute;
  String get timeSecond;
  String get timeAM;
  String get timePM;
  String get colorRed;
  String get colorGreen;
  String get colorBlue;
  String get colorAlpha;
  String get colorHue;
  String get colorSaturation;
  String get colorValue;
  String get colorLightness;
  String get menuCut;
  String get menuCopy;
  String get menuPaste;
  String get menuSelectAll;
  String get menuUndo;
  String get menuRedo;
  String get menuDelete;
  String get menuShare;
  String get menuSearchWeb;
  String get menuLiveTextInput;
  String formatDateTime(DateTime dateTime,
      {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});

  String formatTimeOfDay(
    TimeOfDay time, {
    bool use24HourFormat = true,
    bool showSeconds = false,
  });
  String get placeholderDatePicker;
  String get placeholderTimePicker;
  String get placeholderColorPicker;
  String get buttonPrevious;
  String get buttonNext;

  String get refreshTriggerPull;
  String get refreshTriggerRelease;
  String get refreshTriggerRefreshing;
  String get refreshTriggerComplete;

  String get searchPlaceholderCountry;
  String get emptyCountryList;
  String get toastSnippetCopied;

  String get colorPickerTabRecent;
  String get colorPickerTabRGB;
  String get colorPickerTabHSV;
  String get colorPickerTabHSL;

  String getColorPickerMode(ColorPickerMode mode) {
    switch (mode) {
      case ColorPickerMode.rgb:
        return colorPickerTabRGB;
      case ColorPickerMode.hsv:
        return colorPickerTabHSV;
      case ColorPickerMode.hsl:
        return colorPickerTabHSL;
    }
  }

  String getAbbreviatedWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return abbreviatedMonday;
      case DateTime.tuesday:
        return abbreviatedTuesday;
      case DateTime.wednesday:
        return abbreviatedWednesday;
      case DateTime.thursday:
        return abbreviatedThursday;
      case DateTime.friday:
        return abbreviatedFriday;
      case DateTime.saturday:
        return abbreviatedSaturday;
      case DateTime.sunday:
        return abbreviatedSunday;
      default:
        throw ArgumentError.value(weekday, 'weekday');
    }
  }

  String getMonth(int month) {
    switch (month) {
      case DateTime.january:
        return monthJanuary;
      case DateTime.february:
        return monthFebruary;
      case DateTime.march:
        return monthMarch;
      case DateTime.april:
        return monthApril;
      case DateTime.may:
        return monthMay;
      case DateTime.june:
        return monthJune;
      case DateTime.july:
        return monthJuly;
      case DateTime.august:
        return monthAugust;
      case DateTime.september:
        return monthSeptember;
      case DateTime.october:
        return monthOctober;
      case DateTime.november:
        return monthNovember;
      case DateTime.december:
        return monthDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  String getAbbreviatedMonth(int month) {
    switch (month) {
      case DateTime.january:
        return abbreviatedJanuary;
      case DateTime.february:
        return abbreviatedFebruary;
      case DateTime.march:
        return abbreviatedMarch;
      case DateTime.april:
        return abbreviatedApril;
      case DateTime.may:
        return abbreviatedMay;
      case DateTime.june:
        return abbreviatedJune;
      case DateTime.july:
        return abbreviatedJuly;
      case DateTime.august:
        return abbreviatedAugust;
      case DateTime.september:
        return abbreviatedSeptember;
      case DateTime.october:
        return abbreviatedOctober;
      case DateTime.november:
        return abbreviatedNovember;
      case DateTime.december:
        return abbreviatedDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  Map<String, String> get localizedMimeTypes;
}

class DefaultShadcnLocalizations extends ShadcnLocalizations {
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();

  const DefaultShadcnLocalizations();

  @override
  final Map<String, String> localizedMimeTypes = const {
    'audio/aac': 'AAC Audio',
    'application/x-abiword': 'AbiWord Document',
    'image/apng': 'Animated Portable Network Graphics',
    'application/x-freearc': 'Archive Document',
    'image/avif': 'AVIF Image',
    'video/x-msvideo': 'AVI: Audio Video Interleave',
    'application/vnd.amazon.ebook': 'Amazon Kindle eBook Format',
    'application/octet-stream': 'Binary Data',
    'image/bmp': 'Windows OS/2 Bitmap Graphics',
    'application/x-bzip': 'BZip Archive',
    'application/x-bzip2': 'BZip2 Archive',
    'application/x-cdf': 'CD Audio',
    'application/x-csh': 'C-Shell Script',
    'text/css': 'Cascading Style Sheets (CSS)',
    'text/csv': 'Comma-Separated Values (CSV)',
    'application/msword': 'Microsoft Word',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'Microsoft Word (OpenXML)',
    'application/vnd.ms-fontobject': 'MS Embedded OpenType Fonts',
    'application/epub+zip': 'Electronic Publication (EPUB)',
    'application/gzip': 'GZip Compressed Archive',
    'image/gif': 'Graphics Interchange Format (GIF)',
    'text/html': 'HyperText Markup Language (HTML)',
    'image/vnd.microsoft.icon': 'Icon Format',
    'text/calendar': 'iCalendar Format',
    'application/java-archive': 'Java Archive (JAR)',
    'image/jpeg': 'JPEG Images',
    'text/javascript': 'JavaScript',
    'application/json': 'JSON Format',
    'application/ld+json': 'JSON-LD Format',
    'audio/midi': 'Musical Instrument Digital Interface (MIDI)',
    'audio/x-midi': 'Musical Instrument Digital Interface (MIDI)',
    'audio/mpeg': 'MP3 Audio',
    'video/mp4': 'MP4 Video',
    'video/mpeg': 'MPEG Video',
    'application/vnd.apple.installer+xml': 'Apple Installer Package',
    'application/vnd.oasis.opendocument.presentation': 'OpenDocument Presentation Document',
    'application/vnd.oasis.opendocument.spreadsheet': 'OpenDocument Spreadsheet Document',
    'application/vnd.oasis.opendocument.text': 'OpenDocument Text Document',
    'audio/ogg': 'Ogg Audio',
    'video/ogg': 'Ogg Video',
    'application/ogg': 'Ogg',
    'font/otf': 'OpenType Font',
    'image/png': 'Portable Network Graphics',
    'application/pdf': 'Adobe Portable Document Format (PDF)',
    'application/x-httpd-php': 'Hypertext Preprocessor (Personal Home Page)',
    'application/vnd.ms-powerpoint': 'Microsoft PowerPoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'Microsoft PowerPoint (OpenXML)',
    'application/vnd.rar': 'RAR Archive',
    'application/rtf': 'Rich Text Format (RTF)',
    'application/x-sh': 'Bourne Shell Script',
    'image/svg+xml': 'Scalable Vector Graphics (SVG)',
    'application/x-tar': 'Tape Archive (TAR)',
    'image/tiff': 'Tagged Image File Format (TIFF)',
    'video/mp2t': 'MPEG Transport Stream',
    'font/ttf': 'TrueType Font',
    'text/plain': 'Text',
    'application/vnd.visio': 'Microsoft Visio',
    'audio/wav': 'Waveform Audio Format',
    'audio/webm': 'WEBM Audio',
    'video/webm': 'WEBM Video',
    'image/webp': 'WEBP Image',
    'font/woff': 'Web Open Font Format (WOFF)',
    'font/woff2': 'Web Open Font Format (WOFF)',
    'application/xhtml+xml': 'XHTML',
    'application/vnd.ms-excel': 'Microsoft Excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'Microsoft Excel (OpenXML)',
    'application/xml': 'XML',
    'application/vnd.mozilla.xul+xml': 'XUL',
    'application/zip': 'ZIP Archive',
    'video/3gpp': '3GPP Audio/Video Container',
    'audio/3gpp': '3GPP Audio/Video Container',
    'video/3gpp2': '3GPP2 Audio/Video Container',
    'audio/3gpp2': '3GPP2 Audio/Video Container',
    'application/x-7z-compressed': '7-Zip Archive',
  };

  @override
  String get commandSearch => 'Type a command or search...';

  @override
  String get commandEmpty => 'No results found.';

  @override
  String get formNotEmpty => 'This field cannot be empty';

  @override
  String get invalidValue => 'Invalid value';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get invalidURL => 'Invalid URL';

  @override
  String formatNumber(double value) {
    // if the value is an integer, return it as an integer
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  String formLessThan(double value) => 'Must be less than ${formatNumber(value)}';

  @override
  String formGreaterThan(double value) => 'Must be greater than ${formatNumber(value)}';

  @override
  String formLessThanOrEqualTo(double value) => 'Must be less than or equal to ${formatNumber(value)}';

  @override
  String formGreaterThanOrEqualTo(double value) => 'Must be greater than or equal to ${formatNumber(value)}';

  @override
  String formBetweenInclusively(double min, double max) =>
      'Must be between ${formatNumber(min)} and ${formatNumber(max)} (inclusive)';

  @override
  String formBetweenExclusively(double min, double max) =>
      'Must be between ${formatNumber(min)} and ${formatNumber(max)} (exclusive)';

  @override
  String formLengthLessThan(int value) => 'Must be at least $value characters';

  @override
  String formLengthGreaterThan(int value) => 'Must be at most $value characters';

  @override
  String get formPasswordDigits => 'Must contain at least one digit';

  @override
  String get formPasswordLowercase => 'Must contain at least one lowercase letter';

  @override
  String get formPasswordUppercase => 'Must contain at least one uppercase letter';

  @override
  String get formPasswordSpecial => 'Must contain at least one special character';

  @override
  String get abbreviatedMonday => 'Mo';

  @override
  String get abbreviatedTuesday => 'Tu';

  @override
  String get abbreviatedWednesday => 'We';

  @override
  String get abbreviatedThursday => 'Th';

  @override
  String get abbreviatedFriday => 'Fr';

  @override
  String get abbreviatedSaturday => 'Sa';

  @override
  String get abbreviatedSunday => 'Su';

  @override
  String get monthJanuary => 'January';

  @override
  String get monthFebruary => 'February';

  @override
  String get monthMarch => 'March';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'May';

  @override
  String get monthJune => 'June';

  @override
  String get monthJuly => 'July';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'October';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonOk => 'OK';

  @override
  String get buttonClose => 'Close';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonReset => 'Reset';

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
  String get placeholderDatePicker => 'Select a date';

  @override
  String get placeholderColorPicker => 'Select a color';

  @override
  String get buttonNext => 'Next';

  @override
  String get buttonPrevious => 'Previous';

  @override
  String get searchPlaceholderCountry => 'Search country...';

  @override
  String get emptyCountryList => 'No countries found';

  @override
  String get placeholderTimePicker => 'Select a time';

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
  String get timeHour => 'Hour';

  @override
  String get timeMinute => 'Minute';

  @override
  String get timeSecond => 'Second';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get toastSnippetCopied => 'Copied to clipboard';

  @override
  String get datePickerSelectYear => 'Select a year';

  @override
  String get abbreviatedJanuary => 'Jan';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Apr';

  @override
  String get abbreviatedMay => 'May';

  @override
  String get abbreviatedJune => 'Jun';

  @override
  String get abbreviatedJuly => 'Jul';

  @override
  String get abbreviatedAugust => 'Aug';

  @override
  String get abbreviatedSeptember => 'Sep';

  @override
  String get abbreviatedOctober => 'Oct';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dec';

  @override
  String get colorRed => 'Red';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorAlpha => 'Alpha';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String get menuSelectAll => 'Select All';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get menuDelete => 'Delete';

  @override
  String get menuShare => 'Share';

  @override
  String get menuSearchWeb => 'Search Web';

  @override
  String get menuLiveTextInput => 'Live Text Input';

  @override
  String get refreshTriggerPull => 'Pull to refresh';

  @override
  String get refreshTriggerRelease => 'Release to refresh';

  @override
  String get refreshTriggerRefreshing => 'Refreshing...';

  @override
  String get refreshTriggerComplete => 'Refresh complete';

  @override
  String get colorPickerTabRecent => 'Recent';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorHue => 'Hue';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';
}

class KoreanShadcnLocalizations extends ShadcnLocalizations {
  static const ShadcnLocalizations instance = KoreanShadcnLocalizations();

  const KoreanShadcnLocalizations();

  @override
  final Map<String, String> localizedMimeTypes = const {
    'audio/aac': 'AAC 오디오',
    'application/x-abiword': 'AbiWord 문서',
    'image/apng': '애니메이션 휴대용 네트워크 그래픽',
    'application/x-freearc': '아카이브 문서',
    'image/avif': 'AVIF 이미지',
    'video/x-msvideo': 'AVI: 오디오 비디오 인터리브',
    'application/vnd.amazon.ebook': '아마존 킨들 전자책 형식',
    'application/octet-stream': '바이너리 데이터',
    'image/bmp': '윈도우 OS/2 비트맵 그래픽',
    'application/x-bzip': 'BZip 아카이브',
    'application/x-bzip2': 'BZip2 아카이브',
    'application/x-cdf': 'CD 오디오',
    'application/x-csh': 'C-쉘 스크립트',
    'text/css': 'CSS (종속 스타일 시트)',
    'text/csv': 'CSV (콤마로 구분된 값)',
    'application/msword': '마이크로소프트 워드',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': '마이크로소프트 워드 (OpenXML)',
    'application/vnd.ms-fontobject': 'MS 임베디드 오픈타입 폰트',
    'application/epub+zip': 'Electronic Publication (EPUB)',
    'application/gzip': 'GZip 압축 아카이브',
    'image/gif': 'GIF (그래픽 교환 형식)',
    'text/html': 'HTML (하이퍼텍스트 마크업 언어)',
    'image/vnd.microsoft.icon': '아이콘 형식',
    'text/calendar': 'iCalendar 형식',
    'application/java-archive': '자바 아카이브 (JAR)',
    'image/jpeg': 'JPEG 이미지',
    'text/javascript': '자바스크립트',
    'application/json': 'JSON 형식',
    'application/ld+json': 'JSON-LD Format',
    'audio/midi': 'MIDI (디지털 악기 인터페이스)',
    'audio/x-midi': 'MIDI (디지털 악기 인터페이스)',
    'audio/mpeg': 'MP3 오디오',
    'video/mp4': 'MP4 비디오',
    'video/mpeg': 'MPEG 비디오',
    'application/vnd.apple.installer+xml': 'Apple Installer Package',
    'application/vnd.oasis.opendocument.presentation': '오픈도큐먼트 프레젠테이션 문서',
    'application/vnd.oasis.opendocument.spreadsheet': '오픈도큐먼트 스프레드시트 문서',
    'application/vnd.oasis.opendocument.text': '오픈도큐먼트 텍스트 문서',
    'audio/ogg': 'Ogg 오디오',
    'video/ogg': 'Ogg 비디오',
    'application/ogg': 'Ogg',
    'font/otf': '오픈타입 폰트',
    'image/png': '휴대용 네트워크 그래픽',
    'application/pdf': 'PDF (아도비 휴대용 문서 형식)',
    'application/x-httpd-php': 'PHP (하이퍼텍스트 프로세서)',
    'application/vnd.ms-powerpoint': '마이크로소프트 파워포인트',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': '마이크로소프트 파워포인트 (OpenXML)',
    'application/vnd.rar': 'RAR 아카이브',
    'application/rtf': 'RTF (서식 있는 텍스트 형식)',
    'application/x-sh': '본 쉘 스크립트',
    'image/svg+xml': 'Scalable Vector Graphics (SVG)',
    'application/x-tar': '테이프 아카이브 (TAR)',
    'image/tiff': 'TIFF (태그된 이미지 파일 형식)',
    'video/mp2t': 'MPEG 전송 스트림',
    'font/ttf': '트루타입 폰트',
    'text/plain': '텍스트',
    'application/vnd.visio': '마이크로소프트 비지오',
    'audio/wav': '웨이브폼 오디오 형식',
    'audio/webm': 'WEBM 오디오',
    'video/webm': 'WEBM 비디오',
    'image/webp': 'WEBP 이미지',
    'font/woff': '웹 오픈 폰트 형식 (WOFF)',
    'font/woff2': '웹 오픈 폰트 형식 (WOFF)',
    'application/xhtml+xml': 'XHTML',
    'application/vnd.ms-excel': '마이크로소프트 엑셀',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': '마이크로소프트 엑셀 (OpenXML)',
    'application/xml': 'XML',
    'application/vnd.mozilla.xul+xml': 'XUL',
    'application/zip': 'ZIP 아카이브',
    'video/3gpp': '3GPP 오디오/비디오 컨테이너',
    'audio/3gpp': '3GPP 오디오/비디오 컨테이너',
    'video/3gpp2': '3GPP2 오디오/비디오 컨테이너',
    'audio/3gpp2': '3GPP2 오디오/비디오 컨테이너',
    'application/x-7z-compressed': '7-Zip 아카이브',
  };

  @override
  String get commandSearch => '명령어를 입력하거나 검색하세요...';

  @override
  String get commandEmpty => '결과가 없습니다.';

  @override
  String get formNotEmpty => '이 필드는 비워둘 수 없습니다.';

  @override
  String get invalidValue => '유효하지 않은 값입니다.';

  @override
  String get invalidEmail => '유효하지 않은 이메일입니다.';

  @override
  String get invalidURL => '유효하지 않은 URL입니다.';

  @override
  String formatNumber(double value) {
    // if the value is an integer, return it as an integer
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  String formLessThan(double value) => '${formatNumber(value)}보다 작아야 합니다';

  @override
  String formGreaterThan(double value) => '${formatNumber(value)}보다 커야 합니다';

  @override
  String formLessThanOrEqualTo(double value) => '${formatNumber(value)} 이하여야 합니다';

  @override
  String formGreaterThanOrEqualTo(double value) => '${formatNumber(value)} 이상이어야 합니다';

  @override
  String formBetweenInclusively(double min, double max) => '${formatNumber(min)}에서 ${formatNumber(max)} 사이여야 합니다 (포함)';

  @override
  String formBetweenExclusively(double min, double max) => '${formatNumber(min)}에서 ${formatNumber(max)} 사이여야 합니다 (제외)';

  @override
  String formLengthLessThan(int value) => '최소 $value자 이상이어야 합니다';

  @override
  String formLengthGreaterThan(int value) => '최대 $value자 이하여야 합니다';

  @override
  String get formPasswordDigits => '최소한 하나의 숫자가 포함되어야 합니다.';

  @override
  String get formPasswordLowercase => '최소한 하나의 소문자가 포함되어야 합니다.';

  @override
  String get formPasswordUppercase => '최소한 하나의 대문자가 포함되어야 합니다.';

  @override
  String get formPasswordSpecial => '최소한 하나의 특수 문자가 포함되어야 합니다.';

  @override
  String get abbreviatedMonday => '월';

  @override
  String get abbreviatedTuesday => '화';

  @override
  String get abbreviatedWednesday => '수';

  @override
  String get abbreviatedThursday => '목';

  @override
  String get abbreviatedFriday => '금';

  @override
  String get abbreviatedSaturday => '토';

  @override
  String get abbreviatedSunday => '일';

  @override
  String get monthJanuary => '1월';

  @override
  String get monthFebruary => '2월';

  @override
  String get monthMarch => '3월';

  @override
  String get monthApril => '4월';

  @override
  String get monthMay => '5월';

  @override
  String get monthJune => '6월';

  @override
  String get monthJuly => '7월';

  @override
  String get monthAugust => '8월';

  @override
  String get monthSeptember => '9월';

  @override
  String get monthOctober => '10월';

  @override
  String get monthNovember => '11월';

  @override
  String get monthDecember => '12월';

  @override
  String get buttonCancel => '취소';

  @override
  String get buttonOk => '확인';

  @override
  String get buttonClose => '닫기';

  @override
  String get buttonSave => '저장';

  @override
  String get buttonReset => '초기화';

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
  String get placeholderDatePicker => '날짜를 선택하세요';

  @override
  String get placeholderColorPicker => '색상을 선택하세요';

  @override
  String get buttonNext => '다음';

  @override
  String get buttonPrevious => '이전';

  @override
  String get searchPlaceholderCountry => '국가 검색...';

  @override
  String get emptyCountryList => '검색된 국가가 없습니다.';

  @override
  String get placeholderTimePicker => '시간을 선택하세요';

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
  String get timeHour => '시';

  @override
  String get timeMinute => '분';

  @override
  String get timeSecond => '초';

  @override
  String get timeAM => '오전';

  @override
  String get timePM => '오후';

  @override
  String get toastSnippetCopied => '클립보드에 복사되었습니다.';

  @override
  String get datePickerSelectYear => '연도를 선택하세요';

  @override
  String get abbreviatedJanuary => '1월';

  @override
  String get abbreviatedFebruary => '2월';

  @override
  String get abbreviatedMarch => '3월';

  @override
  String get abbreviatedApril => '4월';

  @override
  String get abbreviatedMay => '5월';

  @override
  String get abbreviatedJune => '6월';

  @override
  String get abbreviatedJuly => '7월';

  @override
  String get abbreviatedAugust => '8월';

  @override
  String get abbreviatedSeptember => '9월';

  @override
  String get abbreviatedOctober => '10월';

  @override
  String get abbreviatedNovember => '11월';

  @override
  String get abbreviatedDecember => '12월';

  @override
  String get colorRed => '빨강';

  @override
  String get colorGreen => '초록';

  @override
  String get colorBlue => '파랑';

  @override
  String get colorAlpha => '알파';

  @override
  String get menuCut => '잘라내기';

  @override
  String get menuCopy => '복사';

  @override
  String get menuPaste => '붙여넣기';

  @override
  String get menuSelectAll => '모두 선택';

  @override
  String get menuUndo => '실행 취소';

  @override
  String get menuRedo => '다시 실행';

  @override
  String get menuDelete => '삭제';

  @override
  String get menuShare => '공유';

  @override
  String get menuSearchWeb => '웹 검색';

  @override
  String get menuLiveTextInput => '실시간 텍스트 입력';

  @override
  String get refreshTriggerPull => '당겨서 새로고침';

  @override
  String get refreshTriggerRelease => '새로고침 하려면 놓으세요';

  @override
  String get refreshTriggerRefreshing => '새로고침 중...';

  @override
  String get refreshTriggerComplete => '새로고침 완료';

  @override
  String get colorPickerTabRecent => '최근';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorHue => '색상';

  @override
  String get colorSaturation => '채도';

  @override
  String get colorValue => '값';

  @override
  String get colorLightness => '명도';
}

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
