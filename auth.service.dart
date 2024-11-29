import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Stream to listen to authentication changes
  static Stream<User?> get currentUserStream => _auth.userChanges();

  static Future<String?> signUp(String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentials.user?.uid;
  }

  static Future<String?> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user?.uid;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> deleteAccount(String email, String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reauthenticate the user
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
      await user.delete();
    }
  }
}
