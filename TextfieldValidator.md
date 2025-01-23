Copy the code in a dart file

```
class Validators {
  static final RegExp _phoneRegex = RegExp(r'^01\d{9}$');
  static final _emailRegex =
      RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

  static String? phone(String? value) {
    //11 digits and has to start with 01
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!_phoneRegex.hasMatch(value)) return 'Invalid phone number ';
    return null;
  }

  static String? email(String? value) {
    //11 digits and has to start with 01
    if (value == null || value.isEmpty) {
      return 'No Email Found';
    }
    if (!_emailRegex.hasMatch(value)) return 'Invalid email';
    return null;
  }

  static String? validateEmptyField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}
```

Textfield Validation
Declare validator or multi validator for combination of validation 

```
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);
```
Usage in textfield 
```
TextFormField(
  onSaved: (pass) {},
  validator: passwordValidator.call,
}
```
