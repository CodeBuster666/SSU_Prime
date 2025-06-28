import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssu_prime/models/user_profile.dart';
import 'package:ssu_prime/services/auth/auth_service.dart';
import 'package:ssu_prime/services/database/database_provider.dart';

/*

  Profile Page

    This is a profile page for a given uid.

 */

class ProfilePage extends StatefulWidget {
  // User Info
  final String uid;

  const ProfilePage({
    super.key,
    required this.uid,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Providers
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  // User Info
  UserProfile? userProfile;
  String currentUserId = AuthService().getCurrentUid();

  // Text Controller for About
  final about = TextEditingController();

  // Loading
  bool _isLoading = true;

  // On Startup
  @override
  void initState() {
    super.initState();

    // Load of User Info
    loadUserInfo();
  }

  Future<void>loadUserInfo() async {
    // Get the User Profile Info
    userProfile = await databaseProvider.getUserProfile(widget.uid);

    // finished loading
    setState(() {
      _isLoading = false;
    });
  }



  // Build UI
  @override
  Widget build(BuildContext context) {
    // Get User Posts

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(title: const Text('Profile')),
        body: Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<UserProfile?>(
              future: provider.getUserProfile(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text('Error loading profile'));
                }
                final userProfile = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Name: ${userProfile.name}', style: const TextStyle(fontSize: 18)),
                  Text('Student ID: ${userProfile.studentID}', style: const TextStyle(fontSize: 16)),
                  Text('Email: ${userProfile.email}', style: const TextStyle(fontSize: 16)),
                  Text('About: ${userProfile.about}', style: const TextStyle(fontSize: 16)),
                  ],
                  ),
                );
              },
            );
          },
        ),
    );
  }
}
