import 'package:example/src/view/sign.in.dart';
import 'package:example/src/view/sign.up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';
import 'providers/auth.provider.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(authProvider).when(
          data: (user) {
            return user != null
                ? Home(onLogout: () => ref.read(authProvider.notifier).logout())
                : const AuthPage();
          },
          error: (e, s) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}

final loginNotifier = ValueNotifier<bool>(true);

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});
  void toggleAuthType() => loginNotifier.value = !loginNotifier.value;

  @override
  Widget build(BuildContext context, ref) {
    return ValueListenableBuilder(
      valueListenable: loginNotifier,
      builder: (BuildContext context, bool isLogin, Widget? child) {
        return isLogin
            ? SignInPage(onToggleAuthType: toggleAuthType)
            : SignUpPage(onToggleAuthType: toggleAuthType);
      },
    );
  }
}


final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    ///Authenticate
  };
  login() {
    ///Your auth logic here
  }

  logout()  {
    /// logout logic 
    state = const AsyncData(null);
  }
}
class User {
  String? name;
  String? email;
  String? pass;
  User({this.name, this.email, this.pass});
}

