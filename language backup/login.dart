import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'signup.dart'; // Link to SignupScreen
import 'welcome.dart'; // Link to WelcomeScreen
import 'quiz.dart';
import 'global_user.dart';
import 'user_provider.dart';
import 'MainMenuButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordNotEmpty = false;

  // Google Sign-In Instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '371398891053-56bbl0pk9kahuhpg6vn61rr11eimolg7.apps.googleusercontent.com', // Your OAuth 2.0 Client ID here
  );

  // Save the email of the user after successful login
  String? _userEmail;

  // Customize the login method
  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get the current user after successful login
      final user = FirebaseAuth.instance.currentUser;

      // Ensure user is not null and email is not null
      if (user?.email != null) {
        // Passing a non-nullable email to the setUserEmail method
        Provider.of<UserProvider>(context, listen: false).setUserEmail(user!.email!);
        setState(() {
          _userEmail = user.email; // Save the user's email
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Welcome back, ${userCredential.user!.email}!'),
      ));

      // Navigate to Quiz screen and pass the email to quiz.dart
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage( userEmail: _userEmail),
          // builder: (context) => WelcomeScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid email or password. Please try again.'),
      ));
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Start Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      // Retrieve Google authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential for Firebase using Google Sign-In authentication tokens
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the current user after successful sign-in
      final user = FirebaseAuth.instance.currentUser;

      // Ensure user is not null and email is not null
      if (user?.email != null) {
        // Passing a non-nullable email to the setUserEmail method
        Provider.of<UserProvider>(context, listen: false).setUserEmail(user!.email!);
        setState(() {
          _userEmail = user.email; // Save the user's email
        });
      }

      // Navigate to Welcome screen and pass the email to quiz.dart
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage( userEmail: _userEmail),
         // builder: (context) => WelcomeScreen(),
        ),
      );

    } catch (e) {
      // Display error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Google Sign-In failed: $e'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _isPasswordNotEmpty = _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      backgroundColor: Color(0xFF3A6D8C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC1BAA1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC1BAA1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: _isPasswordNotEmpty
                      ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                      : null,
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
