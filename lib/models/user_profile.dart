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
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String about;

  UserProfile({
    required this. uid,
    required this.studentID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
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
        username: doc ['userName'],
        firstName: doc['firstName'],
        lastName: doc['lastName'],
        email: doc ['email'],
        about: doc ['about']
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
      'username' : username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'about': about,
    };
  }
}