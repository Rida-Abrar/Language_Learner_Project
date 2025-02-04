import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'content.dart'; // Ensure ContentPage is imported
import 'MainMenuButton.dart'; // Ensure correct import
import 'user_provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // PageController to control automatic page transitions
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Timer to automatically move to the next page every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first slide
      }

      // Make sure the PageView also moves with the same page number
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF3A6D8C), // Match background color
        title: Text("Welcome"),
        leading: MainMenuButton(), // Add MainMenuButton on the left
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Centered PageView with small cards
          Container(
            height: 450,
            width: 300,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildCardSlide(
                  title: 'About the App',
                  content: 'This app helps you learn French!',
                ),
                _buildCardSlide(
                  title: 'Purpose of the App',
                  content: 'Our goal is to teach you basic French skills.',
                ),
                _buildCardSlide(
                  title: 'Are you ready to learn French?',
                  content: 'Click below to start.',
                  showStartButton: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Dots for indicating the current page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Slide with a card (small size and centered content)
  Widget _buildCardSlide({
    required String title,
    required String content,
    bool showStartButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(0xFFC1BAA1), // Set the fill color here
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                content,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              if (showStartButton)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the content.dart when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContentPage()),
                      );
                    },
                    child: Text('Start Learning'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
