import 'package:attendanceqrscan/splashscreen.dart';
import 'package:attendanceqrscan/splashscreen2.dart';
import 'package:flutter/material.dart';
 // Import your SortedumsAppPage file here
import 'firebase_options.dart'; // Import the generated fi
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize with firebase_options.dart
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance QR',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomePage(), // Set your custom page as the home
      debugShowCheckedModeBanner: false,
    );
  }
}
