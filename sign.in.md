```
import 'package:example/src/validatros.dart';
import 'package:example/src/view/sign.up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback? onToggleAuthType;
  const SignInPage({super.key, this.onToggleAuthType});
  @override
  State<SignInPage> createState() => _LoginState();
}

class _LoginState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isBusy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text("Welcome back"),
              const SizedBox(height: 10),
              const Text("Login to your account"),
              const SizedBox(height: 60),
              TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: Validators.emailValidator),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      _obscurePassword = !_obscurePassword;
                    }),
                    icon: _obscurePassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                ),
                validator: Validators.passwordValidator,
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  Consumer(builder: (context, ref, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _isBusy = true);
                        await Future.delayed(const Duration(seconds: 3));
                        setState(() => _isBusy = false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isBusy) ...[
                            const CircularProgressIndicator(),
                            const SizedBox(height: 10)
                          ],
                          const Text("Log in"),
                        ],
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      Consumer(
                        builder: (context, ref, _) {
                          return TextButton(
                            onPressed: () {
                              _formKey.currentState?.reset();
                              widget.onToggleAuthType?.call();
                            },
                            child: const Text("Signup"),
                          );
                        },
                      ),
                      const Text("here"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

Validator matchingPassword(String prevPassword) => (String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter password.";
      } else if (value != prevPassword) {
        return "Password doesn't match.";
      }
      return null;
    };

```
