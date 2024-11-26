import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iftekhar_admin/src/extensions/extensions.dart';
import 'package:iftekhar_admin/src/modules/authentication/provider/auth.provider.dart';
import 'package:iftekhar_admin/src/modules/authentication/view/compontents/transparent.loader.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key, this.onSignUpTapped});
  final VoidCallback? onSignUpTapped;
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: ref.watch(authProvider.notifier).loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              TextField(
                decoration: const InputDecoration(label: Text('Email')),
                keyboardType: TextInputType.emailAddress,
                // validator: Validator.email,
                onChanged: ref.read(authProvider.notifier).onEmailChange,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(label: Text('Password')),
                keyboardType: TextInputType.visiblePassword,
                // validator: Validator.password,
                validator: (s) {
                  if (s!.isEmpty) return 'please choose a password';
                  if (s.length < 6) return 'Must be at least 6 characters';
                  return null;
                },
                onChanged: ref.read(authProvider.notifier).onPassChange,
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                  ),
                  child: const Text('Log In'),
                  onPressed: () async {
                    transparentLoader(context);
                    final success = await ref
                        .read(authProvider.notifier)
                        .signInWithEmailAndPass();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    if (!success) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed ')));
                    }
                  },
                ),
              ),
              20.toHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New Here? '),
                  TextButton(
                      onPressed: onSignUpTapped, child: const Text('Sign Up')),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
