Toggle obscure textfield 
```
class ToggleObscureTextField extends StatefulWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? style;

  const ToggleObscureTextField({
    super.key,
    this.controller,
    this.decoration,
    this.style,
  });

  @override
  ToggleObscureTextFieldState createState() => ToggleObscureTextFieldState();
}

class ToggleObscureTextFieldState extends State<ToggleObscureTextField> {
  late ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, isObscured, child) {
        return TextField(
          controller: widget.controller,
          obscureText: isObscured,
          style: widget.style,
          decoration: widget.decoration?.copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () =>
                      _obscureTextNotifier.value = !_obscureTextNotifier.value,
                ),
              ) ??
              InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () =>
                      _obscureTextNotifier.value = !_obscureTextNotifier.value,
                ),
              ),
        );
      },
    );
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }
}
```
