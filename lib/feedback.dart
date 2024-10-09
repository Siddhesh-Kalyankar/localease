import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center the content vertically
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            // Allow scrolling if the keyboard is open
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We value your feedback!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center align the title
                ),
                const SizedBox(height: 16),
                Text(
                  "Please let us know your thoughts:",
                  style:
                      GoogleFonts.poppins(fontSize: 18, color: Colors.black54),
                  textAlign: TextAlign.center, // Center align the subtitle
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    hintText: "Enter your feedback here",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor:
                        Colors.white, // Background color of the text field
                    contentPadding:
                        EdgeInsets.all(16), // Padding inside the text field
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  // Center the button
                  child: ElevatedButton(
                    onPressed: () {
                      // Show feedback submission message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Feedback submitted!",
                            style: GoogleFonts.poppins(),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: Text("Submit",
                        style: GoogleFonts.poppins(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
