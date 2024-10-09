import 'package:flutter/material.dart';
import 'start.dart'; // Import the start.dart file
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final PageController _pageController = PageController();
  int _currentIndex = 0; // Keep track of the current page index

  // List of image paths for the slides
  final List<String> slides = [
    'assets/images/slide3.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide1.jpg',
  ];

  // List of texts corresponding to each slide
  final List<String> slideTexts = [
    'Welcome to Localease',
    'unique products',
    'Lets get started',
  ];

  // List of texts above the button for each slide
  final List<String> buttonTexts = [
    'Let’s explore together!',
    'Find what you love!',
    'Ready to dive in?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Images occupy about 70% of the screen
          Flexible(
            flex: 7,
            child: PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex =
                      index; // Update the current index when page changes
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  slides[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
          // Positioned card with adjusted height and full width
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 8,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft:
                          Radius.circular(25), // Added bottom left radius
                      bottomRight:
                          Radius.circular(25), // Added bottom right radius
                    ),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          slideTexts[
                              _currentIndex], // Display text based on current index
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          buttonTexts[
                              _currentIndex], // Display text above the button
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_currentIndex < slides.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // Navigate to start.dart (login page)
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StartPage(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 30), // Reduced padding
                            backgroundColor:
                                Colors.black, // Set button color to black
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            _currentIndex == slides.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .white, // Set button text color to white
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10), // Add some spacing
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
