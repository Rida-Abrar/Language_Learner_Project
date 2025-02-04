import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core
import 'package:provider/provider.dart';  // Import provider package
import 'login.dart';  // Your login screen
import 'signup.dart';  // Your signup screen
import 'user_provider.dart';  // Import the UserProvider

// Add your Firebase configuration for web
const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyC9K5aw3E9K47nCTASgkQs9mPeo50p92Dk",
  authDomain: "languagelearner-f1b34.firebaseapp.com",
  projectId: "languagelearner-f1b34",
  storageBucket: "languagelearner-f1b34.firebasestorage.app",
  messagingSenderId: "371398891053",
  appId: "1:371398891053:web:ca507c91afbf15ceb2caa4",
  measurementId: "G-GGE9XXHGF5",
);

void main() async {
  // Ensure Flutter binding is initialized before calling Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the correct options for web
  await Firebase.initializeApp(options: firebaseConfig);

  // Run the app after Firebase initialization is complete
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), // Provide the UserProvider
      child: MaterialApp(
        title: 'Flutter Login App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),  // The initial screen is the LoginScreen
        routes: {
          '/signup': (context) => SignupScreen(),
        },
      ),
    );
  }
}
