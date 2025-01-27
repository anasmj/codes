```
extension StringUtils on String {
  bool get isEmail => _emailRegularExpression.hasMatch(toLowerCase());

  int get wordCount => words.length;

  List<String> get words => split(' ');

  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  bool hasMatch(String v) => toLowerCase().contains(v.toLowerCase());
  /// exampleInput1
  /// ExampleInput2
  /// Example input 1
  /// Example input 2
  String get standardize {
    final regex = RegExp(r'([a-z])([A-Z])');
    String formatted = replaceAllMapped(regex, (match) {
      return '${match.group(1)} ${match.group(2)}';
    });
    return formatted[0].toUpperCase() + formatted.substring(1).toLowerCase();
    }
  }

```
