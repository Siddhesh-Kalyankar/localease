import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './cart.dart'; // Import the CartPage

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> products = [
    {
      'name': 'Chicken Burger',
      'price': 150.0,
      'image': 'assets/images/burger 1.jpeg',
    },
    {
      'name': 'Choclate Cake',
      'price': 500.0,
      'image': 'assets/images/cake1.jpeg',
    },
    {
      'name': 'Black Sunglasses',
      'price': 250.0,
      'image': 'assets/images/sunglass1.jpeg',
    },
    {
      'name': 'Gshock Watch',
      'price': 1500.0,
      'image': 'assets/images/watch 2.jpeg',
    },
    {
      'name': 'Pepperoni Burger',
      'price': 250.0,
      'image': 'assets/images/burger 2.jpeg',
    },
    {
      'name': 'Purple Cap',
      'price': 300.0,
      'image': 'assets/images/cap3.jpg',
    },
    {
      'name': 'Darck Choclate Cake',
      'price': 800.0,
      'image': 'assets/images/cake3.jpg',
    },
    {
      'name': 'Green T-shirt',
      'price': 600.0,
      'image': 'assets/images/t-shirt3.jpg',
    },
    {
      'name': 'Led Bulb',
      'price': 200.0,
      'image': 'assets/images/bulb3.jpg',
    },
    {
      'name': 'Cheese Burger',
      'price': 180.0,
      'image': 'assets/images/burger 3.jpg',
    },
    {
      'name': 'Red and white Cap',
      'price': 350.0,
      'image': 'assets/images/cap 1.jpeg',
    },
    {
      'name': 'Pants',
      'price': 1000.0,
      'image': 'assets/images/pant3.jpg',
    },
    {
      'name': 'Grey Cap',
      'price': 250.0,
      'image': 'assets/images/cap2.jpg',
    },
    {
      'name': 'Black Forest Cake',
      'price': 700.0,
      'image': 'assets/images/cake2.jpeg',
    },
  ];

  // This will store the filtered list based on search query
  List<Map<String, dynamic>> filteredProducts = [];

  // This list will hold the cart items
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    setState(() {
      String query = searchController.text.toLowerCase();
      if (query.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products.where((product) {
          return product['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _navigateToCart, // Navigate to cart when pressed
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            product['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Rs${product['price'].toStringAsFixed(1)}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            _addToCart(product); // Add product to cart
                          },
                        ),
                      ),
                    ),
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
