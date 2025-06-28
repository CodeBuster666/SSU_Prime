import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ssu_prime/services/auth/auth_service.dart';
import '../../models/user_profile.dart';

/*

  Database Services

    This class handles all the data from and to firebase.

    ________________________________________________________________________

    - User profile
    - Post message
    - Like
    - Comment
    - Share
    - Account Stuff ( e.g. "Report")

*/

class DatabaseService {

  // Get instance of Firestore Database & Authentication
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /*

    User Profile

      When a new user registers, we create an account for them, but let's also
      store their details in the database to display on their profile page.

   */

  // Save User Info
  Future<void> saveUserInfoInFirebase({
    required String studentID,
    required String name,
    required String email,
  }) async {
    // Get the current uid
    String uid = _auth.currentUser!.uid;

    // Extract the username from email
    String username = email.split('@')[0];

    // Create a User Profile
    UserProfile user = UserProfile(
      uid: uid,
      studentID: studentID,
      name: name,
      email: email,
      username: username,
      about: '',
    );

    // Convert User into a map so that we can store in Firebase
    final userMap = user.toMap();

    // Save User Info in Firebase
    await _db.collection("Users").doc(uid).set(userMap);
  }

  // Get User Info
  Future<UserProfile?> getUserInfoFromFirebase(String uid) async {
    try {
      // Retrieve User doc from the Firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      if (userDoc.exists) {
        // Convert doc to User Profile
        return UserProfile.formDocument(userDoc);
      }
      return null; // Return null if the document doesn't exist

    }
    catch (e) {
      print('Error fetching user profile: $e'); // Log the error for debugging
      return null; // Return null on error
    }
  }

  // Update User About
  Future<void> updateAbout (String about) async{
    // Get the current uid
    String uid = AuthService().getCurrentUid();

    // Attempt to update in the firebase
    try {
      await _db.collection('Users').doc(uid).update({'about': about});
    }
    catch (e) {
      print(e);
    }
  }
}