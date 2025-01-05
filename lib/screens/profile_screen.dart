import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17203A),
        elevation: 10,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://www.example.com/profile_image.jpg', // Replace with actual user profile image URL
              ),
            ),
            const SizedBox(height: 16),
            
            // User Info
            const Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'john.doe@example.com', // Replace with user's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            
            // Edit Button
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile screen
                // For now, we just print a message
                print("Edit Profile");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Customize color if needed
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 16),
            
            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Handle logout action
                print("Logout");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Customize color for logout button
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
