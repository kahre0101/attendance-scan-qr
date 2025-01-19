import 'package:attendanceqrscan/splashscreen.dart';
import 'package:attendanceqrscan/splashscreen2.dart';
import 'package:flutter/material.dart';
 // Import your SortedumsAppPage file here
import 'package:attendanceqrscan/firebase_options.dart'; // Import the generated fi
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize with firebase_options.dart
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
