```
import 'dart:async';

import 'package:flutter/material.dart';

Future<void> transparentLoadIndicator(
  BuildContext context, [
  Widget? centerWidget,
]) async {
  unawaited(
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: centerWidget ?? const CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
        transitionDuration: Duration.zero,
        barrierDismissible: false,
        barrierColor: Colors.black45,
        opaque: false,
      ),
    ),
  );
}
```
