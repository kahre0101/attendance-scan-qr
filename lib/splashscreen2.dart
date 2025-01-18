import 'package:attendanceqrscan/login.dart';
import 'package:attendanceqrscan/signup.dart';
import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                Container(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      // White background for the main logo
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                      ),
                      // Dark green square positioned behind the yellow square
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 60, // Larger than yellow
                          height: 60,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      // Yellow square positioned in the bottom-left corner
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 40, // Smaller than dark green
                          height: 40,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Title
                Text(
                  "ACTIVITEASE",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                // Subtitle
                Text(
                  "Extracurricular Activities\nRecording\nMobile Application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 50),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Replace with actual Deadlines page widget
                    );
                    },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Register Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()), // Replace with actual Deadlines page widget
                    );                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.amber, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}