import 'dart:ui';

mixin MyColors {
  static const orange = Color(0xffE88A34);
  static const black = Color(0xff040413);
  static const white = Color(0xffffffff);
  static const softText = Color(0xff767676);
  static const profilBg = Color(0xffEAE6DF);
  static const paymentGrey = Color(0xfff6f6f6);
  static const veryLightPink = Color(0xffc4c4c4);
  static const brownishPink = Color(0xffcb7373);
  static const softOrange = Color(0x40e3853b);
  static const pale = Color(0xffeae6df);
  //news
  static const watermelon = Color(0xfff54748);
  static const watermelonSoft = Color(0xFFFA7070);
  static const softWhite = Color(0xfff7f7f7);
  static const softGrey = Color(0xffdddddd);
  static const warmGrey = Color(0xff939393);
  static const blacktwo = const Color(0xff2e2e2e);
  static const charcoal = Color(0xff232a2c);
  static const pastelRed = const Color(0xffec534a);
  static const darkText = const Color(0xff1f272e);
  static const slateGrey = const Color(0xff585269);
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
