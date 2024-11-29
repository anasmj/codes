class Validators {
  static String? emailValidator(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value ?? '') ? null : 'Invalid email';
  }

  static String? passwordValidator(String? value) {
    return value == null || value.isEmpty ? "Plase enter a password" : null;
  }
}

