import 'package:shadcn_flutter/shadcn_flutter.dart';

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
