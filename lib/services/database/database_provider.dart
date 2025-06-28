import 'package:flutter/cupertino.dart';
import 'package:ssu_prime/models/user_profile.dart';
import 'package:ssu_prime/services/auth/auth_service.dart';
import 'package:ssu_prime/services/database/database_service.dart';

/*

  Database Provider

    This provider is to separate the Firestore data handling and the UI of our app.

    - The database service class handles data to and from the Firebase.
    - The database provider class processes the data to display in our app.

    This is use to make the code more modular, cleaner, and easier to read and test.

    ( It can also be use if we decided to change our backend (Firebase -> to mySQL, etc. )
    It is much easier to manage and switch out different databases.

*/


class DatabaseProvider extends ChangeNotifier {

  /*
    Services
   */

  // Get Database & Authentication Services
  final _db = DatabaseService();
  final _auth = AuthService();

  /*
    User Profile
   */

  // Get User Profile given uid
  Future<UserProfile?> getUserProfile(String uid) => _db.getUserInfoFromFirebase(uid);

  // Update User About
  Future<void> updateAbout(String about) => _db.updateAbout(about);
}