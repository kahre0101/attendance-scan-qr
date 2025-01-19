import 'package:attendanceqrscan/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in the user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Fetch user role from Firebase Realtime Database
      String uid = userCredential.user!.uid;
      DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('users/$uid');

      userRef.once().then((snapshot) {
        if (snapshot.snapshot.exists) {
          Map<String, dynamic> userData =
          Map<String, dynamic>.from(snapshot.snapshot.value as Map);
          String role = userData['role'];

          // Navigate based on role
          if (role == 'teacher') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()), // Replace with actual Deadlines page widget
            );           } else if (role == 'student') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()), // Replace with actual Deadlines page widget
            );           } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Invalid role, contact your administrator.")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("User data not found in the database.")));
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "An error occurred."),
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                      children: [
                        // White background for the main logo
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                        ),
                        // Dark green square positioned behind the yellow square
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 40, // Larger than yellow
                            height: 40,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        // Yellow square positioned in the bottom-left corner
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 25, // Smaller than dark green
                            height: 25,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Welcome Text
                Text(
                  "Hi !\nWelcome Back,",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 30),
                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Student/Staff No, or Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                // Remember Me and Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text("Remember Me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Forgot Password
                      },
                      child: Text("Forgot Password?"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Login Button
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
                SizedBox(height: 20),
                // Register Redirect
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Register Page
                    },
                    child: Text(
                      "Don’t have an account? Register",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
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
