import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDatasource {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final List<String> userAuthenticateHint = ['email', 'profile'];

  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final account = await _googleSignIn.authenticate(
        scopeHint: userAuthenticateHint,
      );

      final auth = await account.authorizationClient.authorizationForScopes(
        userAuthenticateHint,
      );

      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: account.authentication.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('error $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      debugPrint('error sign out $e');
    }
  }
}
