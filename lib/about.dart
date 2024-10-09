import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 24.0), // Adjusted vertical padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Added space from the top
            Text(
              "About Localease",
              style: GoogleFonts.poppins(
                fontSize: 24, // Reduced font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8), // Reduced space
            Text(
              "Localease is a unique platform designed to connect you with local sellers. "
              "Order everything from food and clothes to electronics within minutes, making your shopping experience faster and more convenient.",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.black87), // Reduced font size
            ),
            const SizedBox(height: 16), // Reduced space
            Text(
              "Our Mission:",
              style: GoogleFonts.poppins(
                fontSize: 18, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Reduced space
            Text(
              "At Localease, we aim to empower local businesses and provide consumers with the convenience of ordering from their favorite sellers quickly. "
              "By using our app, you not only get access to a wide range of products but also support your local economy.",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.black87), // Reduced font size
            ),
            const SizedBox(height: 16), // Reduced space
            Text(
              "Contact Us:",
              style: GoogleFonts.poppins(
                fontSize: 18, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Reduced space
            Text(
              "For more information or support, feel free to reach out to us via email at support@localease.com.",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.black87), // Reduced font size
            ),
            const SizedBox(height: 20), // Adjusted space at the bottom
            Center(),
          ],
        ),
      ),
    );
  }
}
