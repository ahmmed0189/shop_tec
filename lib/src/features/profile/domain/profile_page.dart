import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_tec/src/components/text_box.dart';
import 'package:shop_tec/src/components/button.dart';

class ProfilePage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfilePage({super.key});

  Future<void> saveUserProfile(
      String username, String birthday, String address) async {
    try {
      await _firestore.collection('users').doc(currentUser.uid).set({
        'email': currentUser.email,
        'username': username,
        'birthday': birthday,
        'address': address,
      });
      print("User profile saved successfully!");
    } catch (e) {
      print("Error saving user profile: $e");
    }
  }

  Future<void> editField(String field, BuildContext context) async {
    String? newValue;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $field"),
          content: TextField(
            onChanged: (value) {
              newValue = value;
            },
            decoration: InputDecoration(hintText: "Enter new $field"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newValue != null && newValue!.isNotEmpty) {
                  editFieldInFirestore(field, newValue!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> editFieldInFirestore(String field, String newValue) async {
    try {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .update({field: newValue});
      print("$field updated to $newValue");
    } catch (e) {
      print("Error updating $field: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Column(
                children: [
                  const Text('No profile data found'),
                  ElevatedButton(
                    onPressed: () {
                      saveUserProfile('John Doe', '14.11.1990',
                          'Musterstraße 123, 12345 Musterstadt');
                    },
                    child: const Text('Save Default Profile'),
                  ),
                ],
              ),
            );
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.person, size: 71),
              const SizedBox(height: 10),
              Text(
                userData['email'] ?? 'No email',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text('My Details'),
              ),
              TextBox(
                text: userData['username'] ?? 'No username',
                sectionName: 'Username',
                onPressed: () => editField('username', context),
              ),
              TextBox(
                text: userData['birthday'] ?? 'No birthday',
                sectionName: 'Birthday',
                onPressed: () => editField('birthday', context),
              ),
              TextBox(
                text: userData['address'] ?? 'No address',
                sectionName: 'Address',
                onPressed: () => editField('address', context),
              ),
              const SizedBox(height: 20),
              Button(
                ontap: () {
                  // Implement confirm function if needed
                },
                text: 'Confirm',
              ),
            ],
          );
        },
      ),
    );
  }
}
