// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'dart:async';

class ProfileScreen extends StatelessWidget {
  // Method for logging out
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove user data from SharedPreferences
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('loginTime');

    // Show the Snackbar before navigating
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout berhasil.')),
    );

    // Navigate to LoginScreen after the Snackbar is shown
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Fetch user information from SharedPreferences
  Future<Map<String, dynamic>> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? profileImage = prefs
        .getString('profileImage'); // Assume there is a path for profile image
    String? loginTimeString = prefs.getString('loginTime');
    DateTime? loginTime =
        loginTimeString != null ? DateTime.tryParse(loginTimeString) : null;

    return {
      'username': username,
      'profileImage': profileImage,
      'loginTime': loginTime,
    };
  }

  // Get login duration
  String _getLoginDuration(DateTime? loginTime) {
    if (loginTime == null) return 'Waktu login tidak tersedia';
    final duration = DateTime.now().difference(loginTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours jam $minutes menit';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil Pengguna')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserInfo(), // Fetch user info from SharedPreferences
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data?['username'] == null) {
            return Center(child: Text('Data pengguna tidak ditemukan.'));
          }

          // User information
          final userInfo = snapshot.data!;
          final username = userInfo['username'];
          final profileImage = userInfo['profileImage'];
          final loginTime = userInfo['loginTime'];

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display user profile image or default image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage)
                      : AssetImage('assets/images/borobudur.jpg')
                          as ImageProvider,
                ),
                SizedBox(height: 20),

                // Display username
                Text(
                  'Nama Akun: $username',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Display login duration
                Text(
                  'Durasi Login: ${_getLoginDuration(loginTime)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 30),

                // Logout button
                ElevatedButton(
                  onPressed: () => _logout(context),
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
