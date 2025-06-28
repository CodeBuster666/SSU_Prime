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
  Future<UserCredential> loginEmailPassword(String email, password) async {
    // Attempt to login
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }

    // Catch any error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Register (email & password) To be updated into Student ID, Email, and Password)
  Future<UserCredential> registerEmailPassword(String studentId, String email, password) async {
    // Attempt to register
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
