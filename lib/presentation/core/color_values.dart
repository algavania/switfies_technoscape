import 'dart:ui';

class ColorValues {
  static const background = Color(0xFFFAFAFA);
  static const slidingPanelBackground = Color(0xFFFAFAFE);
  static const primary50 = Color(0xFF02BBDD);
  static const primary40 = Color(0xFF35C9E4);
  static const primary20 = Color(0xFF9AE4F1);
  static const primary30 = Color(0xFF67D6EB);
  static const primary10 = Color(0xFFCCF1F8);
  static const accent50 = Color(0xFFFF8000);
  static const accent20 = Color(0xFFFFCC99);
  static const accent10 = Color(0xFFFFE6CC);
  static const grey90 = Color(0xFF131414);
  static const grey50 = Color(0xFF5887A4);
  static const grey30 = Color(0xFF9BB7C8);
  static const grey20 = Color(0xFFBCCFDB);
  static const grey10 = Color(0xFFDEE7ED);
  static const text50 = Color(0xFF131414);
  static const text20 = Color(0xFF9BB7C9);
  static const danger50 = Color(0xFFDC3545);
  static const danger20 = Color(0xFFF1AEB5);
  static const danger10 = Color(0xFFF8D7DA);
  static const success50 = Color(0xFF41C063);
  static const success40 = Color(0xFF67CD82);
  static const success20 = Color(0xFFB3E6C1);
  static const success10 = Color(0xFFD9F2E0);
  static const secondary50 = Color(0xFFFFB703);
  static const secondary20 = Color(0xFFFFB703);
  static const secondary10 = Color(0xFFFFF1CD);
  static const pink50 = Color(0xFFF8627F);
  static const surface = Color(0xFFFFFFFF);

  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round()
    );
  }

  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
  }
}
