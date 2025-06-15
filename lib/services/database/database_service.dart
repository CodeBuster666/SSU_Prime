import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/post.dart';
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
  final _db  = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /*
    User Profile

      When a new user registers, we create an account for them, but let's also
      store their details in the database to display on their profile page.

   */

  // Save User Info
  Future<void> SaveUserInfoInFirebase({
    required String studentID,
    required String firstName,
    required String lastName,
    required String email,
  })
  async {
    // Get the current ID
    String uid = _auth.currentUser!.uid;

    // Extract the username from email
    String username = email.split('@')[0];

    // Create a User Profile
    UserProfile user = UserProfile(
      uid: uid,
      studentID: studentID,
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      about: '',
    );

    // Convert User into a map so that we can store in Firebase
    final userMap = user.toMap();

    // Save User Info in Firebase
    await _db.collection('Users').doc(uid).set(userMap);
  }

  // Get User Info
  Future<UserProfile?> getUserInfoFromFirebase(String uid) async {
    try {
      // Retrieve User doc from the Firebase
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();

      // Convert doc to User Profile
      return UserProfile.formDocument(userDoc);
    }
    catch (e){
      print(e);
      return null;
    }
  }

  /*

    Post Message

  */

  // Post a Message
  Future<void> postMessageInFirebase(String message) async {
    try {
      // Get the current uid
      String uid = _auth.currentUser!.uid;

      // Get the current User Info
      UserProfile? user = await getUserInfoFromFirebase(uid);

      // Create New Post
      Post newPost = Post (
        id: '', // Fire base will auto generate this

        uid: uid,
        studentID: user!.studentID,
        username: user.username,
        message: message,
        timestamp: Timestamp.now(),
        likes: 0,
        likeBy: [],
      );

      // Convert post to map -> map
      Map<String, dynamic> postMap = newPost.toMap();

      // Add to Firebase
      await _db.collection('Posts').add(postMap);
    }
    // Catch any errors
    catch (e) {
      print(e);
    }
  }

  // Delete a Message
  Future <void> deletePostFromFirebase(String postId) async {
    try {
      await _db.collection('Posts').doc(postId).delete();
    }
    catch (e) {
      print(e);
    }
  }

  // Get all Post from My Firebase
  Future<List<Post>> getAllPostsFromFirebase(String message) async {
    try {
      QuerySnapshot snapshot = await _db
      // Go to the Post Collection -> Posts
        .collection("Posts")
      // Chronological Order
        .orderBy('timestamp', descending: true)
      // Get this Data
        .get();

      // Reture as a list of Posts
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    }
    catch (e) {
      return [];
    }
  }


}
