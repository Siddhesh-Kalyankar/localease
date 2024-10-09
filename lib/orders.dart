import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Orders",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Order #1",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              subtitle: Text(
                "Details about order #1",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                "Order #2",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              subtitle: Text(
                "Details about order #2",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            // Add more orders as needed
          ],
        ),
      ),
    );
  }
}
