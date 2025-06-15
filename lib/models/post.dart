import 'package:cloud_firestore/cloud_firestore.dart';

/*

  Post Model

    This is what every post should have.

*/

class Post {
  final String id; // Post Id
  final String uid; // User Id
  final String studentID; // Student ID
  final String username; // Username
  final String message; // Post Message
  final Timestamp timestamp;  // Timestamp
  final int likes; // Number of likes
  final List<String> likeBy; // List of likes

  Post ({
    required this.id,
    required this.uid,
    required this.studentID,
    required this.username,
    required this.message,
    required this.timestamp,
    required this.likes,
    required this.likeBy,
  });

  // Convert a Firestore document to a Post object ( To Use in SSU_Prime )
  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
        id: doc.id,
        uid: doc ['uid'],
        studentID: doc ['studentID'],
        username: doc ['username'],
        message: doc ['message'],
        timestamp: doc ['timestamp'],
        likes: doc ['likes'],
        likeBy: List<String>.from(doc['likeBy'] ?? []),
    );
  }

  // Convert a Post object to a map ( To store in Firebase )
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'studentID': studentID,
      'username' : username,
      'message': message,
      'timestamp': timestamp,
      'likes': likes,
      'likeBy': likeBy,
    };
  }
}