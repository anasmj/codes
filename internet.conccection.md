Check internet connection
```
import 'dart:io';

class NetworkUtil {
  static Future<bool> hasConnection() async {
    try {
      final res = await InternetAddress.lookup('google.com');
      return res.isNotEmpty && res.first.rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

```
