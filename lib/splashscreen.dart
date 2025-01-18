import 'package:attendanceqrscan/splashscreen2.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen2()),
      );
    });
  }

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
