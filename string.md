extension StringUtils on String {
  bool get isEmail => _emailRegularExpression.hasMatch(toLowerCase());

  int get wordCount => words.length;

  List<String> get words => split(' ');

  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  bool hasMatch(String v) => toLowerCase().contains(v.toLowerCase());
}

String pluralize(
  int number,
  String form1,
  String form2, [
  String? form3,
]) {
  final num = number % 100;

  if (num >= 11 && num <= 19) {
    return form3 ?? form2;
  }

  final i = num % 10;

  switch (i) {
    case 1:
      return form1;
    case 2:
    case 3:
    case 4:
      return form2;
    default:
      return form3 ?? form2;
  }
}
