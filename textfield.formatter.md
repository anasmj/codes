## Custom formatter for textfield 
```
import 'package:flutter/services.dart';

class DoubleInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Allow empty input
    if (newText.isEmpty) {
      return newValue;
    }

    // Allow valid double numbers
    final doubleValue = double.tryParse(newText);
    if (doubleValue != null) {
      return newValue;
    }

    // If not valid, keep the old value
    return oldValue;
  }
}
```
use the foramtter in textfield of decimal type 
```
TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Enable decimal keyboard
      inputFormatters: [
        DoubleInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Enter a double value',
      ),
    );
```
