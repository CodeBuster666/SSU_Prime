import 'package:cloud_firestore/cloud_firestore.dart';

/*

  User Profile

    This is what every user should have for their profile.

     ____________________________________________________________________________

     - Student ID
     - First Name
     - Last Name
     - Email
     - About
     - Profile Photo

*/

class UserProfile {
  final String uid;
  final String studentID;
  final String name;
  final String email;
  final String username;
  final String about;

  UserProfile({
    required this. uid,
    required this.studentID,
    required this.name,
    required this.email,
    required this.username,
    required this.about,
  });

  /*
    Firebase -> app
    covert Firestore document to a user profile.
  */

  factory UserProfile.formDocument(DocumentSnapshot doc) {
    return UserProfile(
      uid: doc['uid'],
      studentID: doc['studentID'],
      name: doc['name'],
      email: doc ['email'],
      username: doc ['username'],
      about: doc ['about'],
    );
  }

  /*
    App -. Firebase
    Convert a User Profile to a Map
  */

  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'studentID': studentID,
      'name': name,
      'email': email,
      'username' : username,
      'about': about,
    };
  }
}