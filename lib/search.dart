import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with your actual data
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Product ${index + 1}',
                        style: GoogleFonts.poppins()),
                    subtitle: Text('Description of product ${index + 1}',
                        style: GoogleFonts.poppins(color: Colors.grey)),
                    onTap: () {
                      // Navigate to product detail page (not implemented)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
