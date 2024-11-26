import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iftekhar_admin/src/modules/authentication/model/app.user.dart';

final authProvider = NotifierProvider<AppUserProvider, Stream<AppUser?>>(
  AppUserProvider.new,
);

class AppUserProvider extends Notifier<Stream<AppUser?>> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showLogin = true;
  AppUser newAppUser = AppUser();
  AppUser? currentUser;
  final registrationFormKey = GlobalKey<FormState>();

  @override
  Stream<AppUser?> build() {
    Stream<AppUser?> userStream = _auth.userChanges().map(toAppUserModel);
    return userStream;
  }

  AppUser? toAppUserModel(User? user) {
    return user == null
        ? null
        : AppUser(
            userId: user.uid,
            email: user.email,
            name: _auth.currentUser!.displayName,
          );
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<bool> signInWithEmailAndPass() async {
    if (loginFormKey.currentState != null) {
      if (!loginFormKey.currentState!.validate()) return false;
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: newAppUser.email!, password: newAppUser.password!);
      toAppUserModel(userCredential.user);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }


  // only super admin will be able to register a new user
  Future<void> register() async {
    if (registrationFormKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: newAppUser.email!, password: newAppUser.password!);
        User? firebaseUser = userCredential.user;
        await _firestore.collection('admins').doc(firebaseUser!.uid).set({
          'userName': newAppUser.name,
          'email': newAppUser.email!,
          'password': newAppUser.password!,
          'uid': firebaseUser.uid
        }).then((value) {
          firebaseUser.updateDisplayName(newAppUser.name);
        });
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void onNameChange(String s) => newAppUser.name = s;

  void onEmailChange(String s) => newAppUser.email = s;

  void onPassChange(String s) => newAppUser.password = s;
}
