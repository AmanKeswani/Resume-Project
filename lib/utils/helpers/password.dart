import 'dart:math';

String generatePassword() {
  const String capitals = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String smalls = capitals.toLowerCase();
  const String numbers = '0123456789';
  const String specials = '@!#';

  String chars = '$capitals$smalls$numbers$specials';

  return List.generate(12, (index) {
    int indexRandom = Random.secure().nextInt(chars.length);

    return chars[indexRandom];
  }).join('');
}
