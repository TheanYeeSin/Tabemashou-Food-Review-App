import "dart:math";

/// KaomojiConstants: Constants for kaomoji
class KaomojiConstants {
  static const List<String> kaomojis = [
    "૮₍  ˶•⤙•˶ ₎ა",
    "( ˶ˆᗜˆ˵ )",
    "ଘ(੭ˊᵕˋ)੭* ੈ",
    "ʕ·ᴥ·ʔ",
    "(・_・;)",
    "(￣ー￣)",
    "(╯°□°）╯︵ ┻━┻",
    "(T_T)",
    "(｡♥‿♥｡)",
    "(ಥ﹏ಥ)",
    "(-_-)",
    "(✿◠‿◠)",
    "(¬_¬)",
    "(⁀ᗢ⁀)",
    "(੭ꐦ •̀Д•́ )੭",
    "(◕‿◕)♡",
    "٩(◕‿◕｡)۶",
    "(„ಡωಡ„)",
    "(っ´ω`)ﾉ(╥ω╥)",
    "(つ . •́ _ʖ •̀ .)つ",
  ];

  static String get random => kaomojis[Random().nextInt(kaomojis.length)];
}
