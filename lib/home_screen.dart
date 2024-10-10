import 'package:flutter/material.dart';
import 'package:flutter_login/Accessories/hat.dart';
import 'package:flutter_login/Accessories/watch.dart';
import 'package:flutter_login/food/pizza.dart';
import 'package:flutter_login/food/cake.dart'; // Import for CakePage
import 'package:flutter_login/food/burger.dart'; // Import for BurgerPage
import 'package:flutter_login/categories/accessories.dart'; // Import for AccessoriesPage
import 'package:flutter_login/categories/clothes.dart'; // Import for ClothesPage
import 'package:flutter_login/categories/electrical.dart'; // Import for ElectricalPage
import 'package:flutter_login/search.dart'; // Import for SearchPage
import 'package:flutter_login/cart.dart'; // Import for CartPage
import 'package:flutter_login/profile.dart'; // Import for ProfilePage
import 'package:flutter_login/seller.dart'; // Import for SellerPage
import 'package:google_fonts/google_fonts.dart';
import 'Accessories/sunglasses.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> cartItems =
      []; // Initialize cartItems as a List

  List<Map<String, String>> foodShops = [];
  List<Map<String, String>> accessoriesShops = [];
  List<Map<String, String>> clothesShops = [];
  List<Map<String, String>> electricalShops = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break; // Remain on the home page
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CartPage(
                    cartItems: cartItems, // Pass cartItems here
                  )),
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

  void _addToCart(String productName, int quantity) {
    setState(() {
      // Check if the item already exists in the cart
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == productName,
        orElse: () => {'name': productName, 'quantity': 0},
      );

      if (existingItem['quantity'] > 0) {
        // Update the quantity if the item exists
        existingItem['quantity'] += quantity;
      } else {
        // Add a new item if it doesn't exist
        cartItems.add({'name': productName, 'quantity': quantity});
      }
    });
  }

  void _addShop(String category, String shopName, String shopImage) {
    setState(() {
      Map<String, String> newShop = {
        'image': shopImage,
        'label': shopName,
      };

      switch (category) {
        case 'Food':
          foodShops.add(newShop);
          break;
        case 'Accessories':
          accessoriesShops.add(newShop);
          break;
        case 'Clothes':
          clothesShops.add(newShop);
          break;
        case 'Electrical':
          electricalShops.add(newShop);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'Localease',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.store, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerPage(onAddShop: _addShop),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
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
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
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
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/images/home.png',
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section for Food
              _buildCategorySection(
                "Food",
                [
                  {
                    'image': 'assets/images/food1.jpg',
                    'label': 'Pizza Express'
                  },
                  {
                    'image': 'assets/images/food2.jpg',
                    'label': 'Occasion Cakes'
                  },
                  {'image': 'assets/images/food3.jpg', 'label': 'Burger House'},
                ],
                foodShops,
                (label) {
                  if (label == 'Pizza Express') {
                    _addToCart('Pizza', 1); // Example: Add Pizza to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PizzaPage()),
                    );
                  } else if (label == 'Occasion Cakes') {
                    _addToCart('Cake', 1); // Example: Add Cake to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CakePage()),
                    );
                  } else if (label == 'Burger House') {
                    _addToCart('Burger', 1); // Example: Add Burger to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BurgerPage()),
                    );
                  }
                },
              ),

              // Categories Section for Accessories
              _buildCategorySection(
                "Accessories",
                [
                  {
                    'image': 'assets/images/accessories1.jpg',
                    'label': 'Sunglasses'
                  },
                  {'image': 'assets/images/accessories2.jpg', 'label': 'Watch'},
                  {
                    'image': 'assets/images/accessories3.jpg',
                    'label': 'Hat and Cap'
                  },
                ],
                accessoriesShops,
                (label) {
                  if (label == 'Sunglasses') {
                    _addToCart(
                        'Sunglasses', 1); // Example: Add Sunglasses to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SunglassesPage()),
                    );
                  } else if (label == 'Watch') {
                    _addToCart('Watch', 1); // Example: Add Watch to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WatchPage()),
                    );
                  } else if (label == 'Hat and Cap') {
                    _addToCart('Hat and Cap', 1); // Example: Add Hat to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HatPage()),
                    );
                  }
                },
              ),

              // Categories Section for Clothes
              _buildCategorySection(
                "Clothes",
                [
                  {
                    'image': 'assets/images/clothes1.jpg',
                    'label': 'The Pant Project'
                  },
                  {
                    'image': 'assets/images/clothes2.jpg',
                    'label': 'The Shirt Shop'
                  },
                  {
                    'image': 'assets/images/clothes3.jpg',
                    'label': 'Bombay Shirt Company'
                  },
                ],
                clothesShops,
                (label) {
                  if (label == 'The Pant Project') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SunglassesPage()),
                    );
                  } else if (label == 'The Shirt Shop') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WatchPage()),
                    );
                  } else if (label == 'Bombay Shirt Company') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HatPage()),
                    );
                  }
                },
              ),

              // Categories Section for Electrical
              _buildCategorySection(
                "Electrical",
                [
                  {'image': 'assets/images/electrical1.jpg', 'label': 'Phones'},
                  {'image': 'assets/images/electrical2.jpg', 'label': 'Laptop'},
                  {
                    'image': 'assets/images/electrical3.jpg',
                    'label': 'TV and Speakers'
                  },
                ],
                electricalShops,
                (label) {
                  if (label == 'Phones') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SunglassesPage()),
                    );
                  } else if (label == 'Laptop') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WatchPage()),
                    );
                  } else if (label == 'TV and Speakers') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HatPage()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.blue,
        unselectedItemColor:
            Colors.white, // Optional: to make unselected items white
        backgroundColor: Colors.black, // Set background color to black
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Map<String, String>> items,
      List<Map<String, dynamic>> shops, Function(String) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onTap(item['label']!),
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          item['image']!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Add the text below the images
        SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: 120,
                alignment: Alignment.center,
                child: Text(
                  item['label']!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
