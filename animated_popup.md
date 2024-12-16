```
import 'package:flutter/material.dart';

class AuthenticationPopup extends ConsumerStatefulWidget {
  const AuthenticationPopup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignInPopupState();
}

class SignInPopupState extends ConsumerState<AuthenticationPopup> with SingleTickerProviderStateMixin {
  AnimationController? _animationSigninController;
  Animation<double>? _animationSignin;
  String address = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationSigninController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationSignin = CurvedAnimation(parent: _animationSigninController!, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    _animationSigninController!.forward();

    final authData = ref.watch(authProvider);
    final authStatus = authData.authStatus ?? true;
    return ScaleTransition(
      scale: _animationSignin!,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: authStatus
              ? context.width < 500
                  ? context.height * 0.7
                  : context.height * 0.58
              : context.width < 500
                  ? context.height
                  : context.height * 0.7,
          width: context.width < 550 ? context.width * 0.6 : context.width * 0.3,
          child: mainContent(context, _formKey),
        ),
      ),
    );
  }
```

Declare variables
```
  AnimationController? _controller;
  Animation<double>? _animation;
```
Initialize in initState()
```
void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
  }
```
In build method 
```
 Widget build(BuildContext context) {
    _controller!.forward();

    return ScaleTransition(
      scale: _animation!,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: _height,      
          width:  _width
          child: _buildMainContent(context)
        ),
      ),
    );
  }
```
