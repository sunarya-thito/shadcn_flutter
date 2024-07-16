import '../../../shadcn_flutter.dart';

class Emojis {
  const Emojis._();

  static const IconData smile = EmojiIconData(0xe800);
  static const IconData sad = EmojiIconData(0xe801);
}

class EmojiIconData extends IconData {
  const EmojiIconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'GeistSans',
        );
}
