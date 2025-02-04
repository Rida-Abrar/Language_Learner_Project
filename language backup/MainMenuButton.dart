import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Make sure to import the provider package
import 'welcome.dart';
import 'content.dart';
import 'quiz.dart';
import 'user_provider.dart';

class MainMenuButton extends StatelessWidget {
  final String? userEmail;

  // Constructor to accept userEmail
  MainMenuButton({this.userEmail});

  @override
  Widget build(BuildContext context) {
    // Optionally, you can use the UserProvider to update the user email if needed
    if (userEmail != null) {
      // Update the UserProvider with the provided userEmail
      Provider.of<UserProvider>(context, listen: false).setUserEmail(userEmail!);
    }

    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        _showMenu(context);
      },
    );
  }

  // Custom function to show menu below the button
  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final position = button.localToGlobal(Offset.zero); // Get the position of the button

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy + button.size.height, position.dx, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.book),
            title: Text('Learning Modules'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ContentPage()),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.quiz),
            title: Text('Quizzes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(userEmail: userEmail)), // Pass userEmail to QuizPage
              );
            },
          ),
        ),
      ],
    );
  }
}
