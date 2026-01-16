import 'dart:math';
class Phrase{
  static const List<String> frases = [
    'Stay Hard',
    'Fuck them and Stay Hard',
    'Time to Stay Hard',
    'You can Stay Hard',
    'Always Stay Hard',
    'Never Give Up, Stay Hard',
  ];
  static String get fraseAleatoria{
    return frases[Random().nextInt(frases.length)];
  }
}