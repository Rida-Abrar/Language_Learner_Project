import 'package:flutter/material.dart';
import 'learn.dart'; // Import LearnPage to handle video functionality
import 'quiz.dart'; // Import QuizPage
import 'login.dart';
import 'global_user.dart';
import 'MainMenuButton.dart';
import 'user_provider.dart';

class ContentPage extends StatelessWidget {
  final List<String> modules = [
    "Modulo 1: Introduction to French",
    "Modulo 2: Basic Vocabulary & Phrases",
    "Modulo 3: Basic Grammar",
    "Modulo 4: Building Simple Sentences",
    "Modulo 5: Intermediate Grammar & Vocabulary",
    "Modulo 6: Conversational Practice",
    "Modulo 7: Advanced Grammar",
    "Modulo 8: Advanced Vocabulary",
    "Modulo 9: Cultural & Practical Learning",
    "Modulo 10: Writing Practice",
    "Modulo 11: Speaking & Listening Fluency",
    "Modulo 12: Preparation for Proficiency Exam (DELF/DALF Exam)"
  ];

  final Map<String, List<String>> moduleVideos = {
    "Modulo 1: Introduction to French": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 2: Basic Vocabulary & Phrases": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 3: Basic Grammar": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 4: Building Simple Sentences": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 5: Intermediate Grammar & Vocabulary": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 6: Conversational Practice": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 7: Advanced Grammar": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 8: Advanced Vocabulary": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 9: Cultural & Practical Learning": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 10: Writing Practice": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 11: Speaking & Listening Fluency": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    "Modulo 12: Preparation for Proficiency Exam (DELF/DALF Exam)": [
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'https://www.youtube.com/watch?v=H2-REbL2OU0',
      'https://www.youtube.com/watch?v=PaOVHdpRAK8',
      'https://www.youtube.com/watch?v=rim94Xp2XQ4',
      'https://www.youtube.com/watch?v=JyROOY4RPJg',
      'https://www.youtube.com/watch?v=Kq4Luegns8c',
      'https://www.youtube.com/watch?v=054MD3i3RDE',
      'https://www.youtube.com/watch?v=xw1sORGoEOY',
      'https://www.youtube.com/watch?v=8LBvMfR7fWc',
      'https://www.youtube.com/watch?v=84olv0BM4oY',
    ],
    // Add video URLs for other modules here...
  };

  final Map<String, String> moduleQuizzes = {
    "Modulo 1: Introduction to French": "https://docs.google.com/forms/d/1SK05m8Aa1HNNQASVbOGNZQ3BxbEp0n67rraJDPBze8E/edit#responses",
    "Modulo 2: Basic Vocabulary & Phrases": "https://docs.google.com/forms/d/1OUEhI0OtpqWPZ9Ykw8ZeyD1To4lKbiUOk_UMS6Y-tRE/edit#responses",
    "Modulo 3: Basic Grammar": "https://docs.google.com/forms/d/quiz3",
    "Modulo 4: Building Simple Sentences": "https://docs.google.com/forms/d/quiz3",
    "Modulo 5: Intermediate Grammar & Vocabulary": "https://docs.google.com/forms/d/quiz3",
    "Modulo 6: Conversational Practice": "https://docs.google.com/forms/d/quiz3",
    "Modulo 7: Advanced Grammar": "https://docs.google.com/forms/d/quiz3",
    "Modulo 8: Advanced Vocabulary": "https://docs.google.com/forms/d/quiz3",
    "Modulo 9: Cultural & Practical Learning": "https://docs.google.com/forms/d/quiz3",
    "Modulo 10: Writing Practice": "https://docs.google.com/forms/d/quiz3",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainMenuButton(), // Add the MainMenuButton to the AppBar
            Text(
              'Learn French Modules',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.assignment_turned_in),
              onPressed: () {
                String userEmail = "usman@gmail.com";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(userEmail: userEmail),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFF3A6D8C),
      ),
      backgroundColor: Color(0xFF3A6D8C),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(modules.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LearnPage(
                        module: modules[index],
                        videos: moduleVideos[modules[index]] ?? [],
                        quizUrl: moduleQuizzes[modules[index]] ?? "",
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(0xFFC1BAA1),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      modules[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
