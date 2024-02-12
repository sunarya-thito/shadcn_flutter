import 'package:flutter/painting.dart';

class Typography {
  final TextStyle headline1;
  final TextStyle headline2;
  final TextStyle headline3;
  final TextStyle headline4;
  final TextStyle paragraph;
  final TextStyle blockquote;
  final TextStyle large;
  final TextStyle small;
  final TextStyle muted;

  //
  final TextStyle tableHeader;
  final TextStyle tableCell;
  //

  final TextStyle list;
  final TextStyle inlineCode;
  final TextStyle lead;

  const Typography({
    required this.headline1,
    required this.headline2,
    required this.headline3,
    required this.headline4,
    required this.paragraph,
    required this.blockquote,
    required this.large,
    required this.small,
    required this.muted,
    required this.tableHeader,
    required this.tableCell,
    required this.list,
    required this.inlineCode,
    required this.lead,
  });

  factory Typography.geist() {
    return const Typography(
      headline1: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        fontFamily: 'GeistSans',
      ),
      headline2: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontFamily: 'GeistSans',
      ),
      headline3: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'GeistSans',
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'GeistSans',
      ),
      paragraph: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
      blockquote: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
        fontStyle: FontStyle.italic,
      ),
      large: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'GeistSans',
      ),
      small: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
      muted: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
      tableHeader: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'GeistSans',
      ),
      tableCell: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
      list: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
      inlineCode: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'GeistMono',
      ),
      lead: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'GeistSans',
      ),
    );
  }
}
