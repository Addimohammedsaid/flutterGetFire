import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthentificationService extends GetxService {
  // initialize variables
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current firebase user
  User get user => _auth.currentUser;

  // initialize service
  Future<AuthentificationService> init() async {
    return this;
  }

  // get user state
  Stream<User> getUserChanges() {
    return _auth.userChanges();
  }

  // sing in with email and password
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      // if no error return user
      return userCredential.user;

      // catch any erro and throw the same error
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  // sing in with email and password
  Future<User> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);

      // if no error return user
      return userCredential.user;

      // catch any erro and throw the same error
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  // verify email
  Future reloadUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // If successful, reload the user:
      auth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  // is email verified
  bool isVerifiedEmail() {
    return this.user.emailVerified;
  }

  // send email verification
  Future<bool> sendEmailVerification() async {
    try {
      // send email verfication with firebase
      return await user.sendEmailVerification().then((value) => true);
    } catch (e) {
      throw e;
    }
  }

  //google_sign_in: ^4.5.1
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw e;
    }
  }

  //sign_in_with_apple: ^2.5.2
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  // get acces token
  Future<String> getAccessToken() async {
    return await user.getIdToken();
  }

  // send password reset email
  Future<void> sendPasswordResetMail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return null;
  }

  // update password
  Future<void> changePassword(String password) async {
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  // delete user
  Future<void> deleteUser() async {
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
