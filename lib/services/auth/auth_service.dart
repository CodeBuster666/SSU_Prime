import 'package:firebase_auth/firebase_auth.dart';

/*
  Authentication Service

    This handles everything to do with authentication in firebase

    ______________________________________________________________________________

    - Login
    - Register
    - Logout
    - Delete Account
 */

class AuthService {

  // get instance of the auth
  final _auth = FirebaseAuth.instance;

  // get current user & uid
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  // Login (student ID & password)
  Future<UserCredential> LoginEmailPassword(String Email, Password) async {
    // Attempt to login
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      return userCredential;
    }

    // Catch any error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Register (email & password) To be updated into Student ID, Email, and Password)
  Future<UserCredential> RegisterEmailPassword(String Email, Password) async {
    // Attempt to register
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      return userCredential;
    }

    // Catch any error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // delete account
}