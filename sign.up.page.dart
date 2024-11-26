import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iftekhar_admin/src/modules/authentication/provider/auth.provider.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key, this.onLoginTapped});
  final VoidCallback? onLoginTapped;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: ref.read(authProvider.notifier).registrationFormKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('Name')),
                onChanged: ref.read(authProvider.notifier).onNameChange,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(label: Text('Email')),
                onChanged: ref.read(authProvider.notifier).onEmailChange,
                validator: (s) {
                  if (s!.isEmpty) return 'please choose a password';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: ref.read(authProvider.notifier).onPassChange,
                validator: (s) {
                  if (s!.isEmpty) return 'please choose a password';
                  if (s.length < 6) return 'Must be at least 6 characters';
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              // AppTextField(
              //   onChanged: ref.read(authProvider.notifier).onPassChange,
              //   label: 'Password',
              //   validator: (s) {
              //     if (s!.isEmpty) return 'please choose a password';
              //     if (s.length < 6) return 'Must be at least 6 characters';
              //     return null;
              //   },
              //   inputType: TextInputType.visiblePassword,
              // ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    ref.read(authProvider.notifier).register();
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already registered?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) => TextButton(
                      onPressed: onLoginTapped,
                      // onPressed: () {
                      //   ref.read(loginNotifier.notifier).state = true;
                      // },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
