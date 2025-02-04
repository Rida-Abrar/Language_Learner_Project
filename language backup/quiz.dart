import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MainMenuButton.dart';

class QuizPage extends StatefulWidget {
  final String? userEmail;

  QuizPage({this.userEmail});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of Google Sheet URLs for 12 quizzes
  final List<String> _sheetUrls = [
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vSMFj1cCU5B-pBowNeh9_0EHQoQpk-K5ISW-XbOl3KsUhFD4RUXsOpY3eFE8NSVY6J8yCCgy9bMLaEm/pub?output=csv",
    "https://docs.google.com/spreadsheets/d/1w_7jwxS1xWVEiB9uP70WQCXKeJ2QoJ91N9UwBs9iv5o/edit?resourcekey=&gid=195684434#gid=195684434",
    "https://docs.google.com/spreadsheets/d/e/QUIZ3_URL/pub?output=csv",
    // Add URLs for quizzes 4–12
  ];

  Map<int, int> quizScores = {};
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.userEmail != null) {
      _fetchAllQuizScores();
    } else {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Error: User email is null");
    }
  }

  Future<void> _fetchAllQuizScores() async {
    try {
      for (int i = 0; i < _sheetUrls.length; i++) {
        int? score = await _fetchQuizScoreFromSheet(_sheetUrls[i]);
        if (score != null) {
          quizScores[i + 1] = score; // Store the score for each quiz
          await _saveScoreToFirestore(i + 1, score); // Save to Firestore
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Error fetching quiz scores: $e");
    }
  }

  Future<int?> _fetchQuizScoreFromSheet(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch data from Google Sheets');
      }

      List<String> rows = LineSplitter.split(response.body).toList();
      String userEmail = widget.userEmail?.trim() ?? '';

      if (userEmail.isEmpty) {
        throw Exception('User email is empty');
      }

      int maxScore = 0;

      for (var row in rows.skip(1)) {
        List<String> columns = row.split(',');

        if (columns.length >= 12) {
          String emailInSheet = columns.last.trim();
          String scoreStr = columns[1].trim();

          if (emailInSheet == userEmail) {
            int? currentScore = _parseScore(scoreStr);
            if (currentScore != null) {
              maxScore = currentScore > maxScore ? currentScore : maxScore;
            }
          }
        }
      }

      return maxScore > 0 ? maxScore : null;
    } catch (e) {
      print("Error fetching score from sheet: $e");
      return null;
    }
  }

  int? _parseScore(String scoreStr) {
    try {
      String scorePart = scoreStr.split('/')[0].trim();
      return int.tryParse(scorePart);
    } catch (e) {
      print("Error parsing score: $e");
      return null;
    }
  }

  Future<void> _saveScoreToFirestore(int quizNumber, int score) async {
    try {
      String collectionName = 'quizScore$quizNumber';

      QuerySnapshot existingScores = await _firestore
          .collection(collectionName)
          .where('userEmail', isEqualTo: widget.userEmail)
          .get();

      if (existingScores.docs.isNotEmpty) {
        // Update the existing document
        String docId = existingScores.docs.first.id;
        await _firestore.collection(collectionName).doc(docId).update({
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Add a new document
        await _firestore.collection(collectionName).add({
          'userEmail': widget.userEmail,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
      print("Score saved for Quiz $quizNumber: $score");
    } catch (e) {
      print("Error saving score to Firestore for Quiz $quizNumber: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: const Color(0xFF3A6D8C),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainMenuButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : hasError
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to fetch scores',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchAllQuizScores,
                child: Text('Retry'),
              ),
            ],
          )
              : ListView.builder(
            itemCount: quizScores.length,
            itemBuilder: (context, index) {
              int quizNumber = quizScores.keys.elementAt(index);
              int score = quizScores[quizNumber]!;
              return ListTile(
                title: Text('Quiz $quizNumber'),
                subtitle: Text('Score: $score'),
              );
            },
          ),
        ),
      ),
    );
  }
}
