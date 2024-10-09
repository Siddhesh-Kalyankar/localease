import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './profile.dart'; // Ensure this path is correct
import './cart.dart'; // Ensure this path is correct
import './search.dart'; // Ensure this path is correct
import './categories/accessories.dart'; // Import the new food.dart file
import './categories/clothes.dart'; // Import the new electrical.dart file
import './categories/electrical.dart'; // Import the new clothes.dart file
import './categories/food.dart'; // Import the new accessories.dart file

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Default to Home page (index 0 for Home)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective page
    switch (index) {
      case 0:
        // Home page, do nothing
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.black, // App bar background color
        title: Text(
          'Localease', // App title as a logo
          style: GoogleFonts.poppins(
            fontSize: 28, // Large font size for logo
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                height: 60, // Constrain height to avoid overflow
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.store, color: Colors.white), // Seller icon
                      onPressed: () {
                        // Navigate to seller page (not implemented yet)
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10), // Space between icons
              SizedBox(
                height: 60, // Constrain height to avoid overflow
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.person,
                          color: Colors.white), // Profile icon
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 20), // Space at the end of icons
        ],
      ),
      body: Container(
        color: Colors.white, // Background color set to white
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Banner Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue, // Background color for the banner
                borderRadius: BorderRadius.circular(20), // Curved edges
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connect Locally, Shop Happily",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your Neighborhood's Best Deals Await!",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Space between text and image
                  Image.asset(
                    'assets/images/home.png', // Adjust the path to your image
                    height: 80, // Adjust height as needed
                    width: 80, // Adjust width as needed
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Categories Section
            Text(
              'Categories',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryItem(
                  imagePath:
                      'assets/images/food.jpeg', // Replace with your image path
                  label: 'Food',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoodPage()),
                    );
                  },
                ),
                CategoryItem(
                  imagePath:
                      'assets/images/accessories.jpeg', // Replace with your image path
                  label: 'Accessories',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccessoriesPage()),
                    );
                  },
                ),
                CategoryItem(
                  imagePath:
                      'assets/images/clothes.jpeg', // Replace with your image path
                  label: 'Clothes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClothesPage()),
                    );
                  },
                ),
                CategoryItem(
                  imagePath:
                      'assets/images/electrical.jpeg', // Replace with your image path
                  label: 'Electrical',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ElectricalPage()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40), // Space to balance the layout
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Background behind the navigation bar
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Padding from all sides
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black, // Navigation bar background color
              borderRadius: BorderRadius.circular(20), // Border radius
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType
                  .fixed, // Ensures all items are visible
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white, // Active item color
              unselectedItemColor: Colors.grey, // Inactive item color
              backgroundColor: Colors.transparent, // Transparent background
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Rounded corners for the image
            child: Image.asset(
              imagePath,
              height: 80, // Set the height of the category image
              width: 80, // Set the width of the category image
              fit: BoxFit.cover, // Adjust the image to cover the box
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
