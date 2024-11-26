import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iftekhar_admin/src/modules/authentication/view/compontents/login.page/login.page.dart';
import 'package:iftekhar_admin/src/modules/authentication/view/compontents/sign.up.page/sign.up.page.dart';

final loginNotifier = ValueNotifier<bool>(true);

class Authenticate extends ConsumerWidget {
  const Authenticate({super.key});
  void toggleAuthType() {
    loginNotifier.value = !loginNotifier.value;
  }

  @override
  Widget build(BuildContext context, ref) {
    return ValueListenableBuilder(
      valueListenable: loginNotifier,
      builder: (BuildContext context, bool isLogin, Widget? child) {
        return isLogin
            ? LoginPage(onSignUpTapped: toggleAuthType)
            : SignUpPage(onLoginTapped: toggleAuthType);
      },
    );
  }
}
