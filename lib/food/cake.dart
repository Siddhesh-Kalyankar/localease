import 'package:flutter/material.dart';

class CakePage extends StatefulWidget {
  @override
  _CakePageState createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  // This map will hold the quantities of each cake
  Map<String, int> _quantities = {
    'Chocolate Cake': 0,
    'Vanilla Cake': 0,
    'Red Velvet Cake': 0,
  };

  void _incrementQuantity(String cakeName) {
    setState(() {
      _quantities[cakeName] = (_quantities[cakeName] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String cakeName) {
    setState(() {
      if (_quantities[cakeName] != null && _quantities[cakeName]! > 0) {
        _quantities[cakeName] = _quantities[cakeName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cake Menu'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCakeCard(
              'assets/images/cake1.jpeg', // Replace with your image path
              'Chocolate Cake',
              500,
            ),
            const SizedBox(height: 16),
            _buildCakeCard(
              'assets/images/cake2.jpeg', // Replace with your image path
              'Vanilla Cake',
              450,
            ),
            const SizedBox(height: 16),
            _buildCakeCard(
              'assets/images/cake3.jpg', // Replace with your image path
              'Red Velvet Cake',
              550,
            ),
            // Add more cake cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCakeCard(String imagePath, String title, double price) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imagePath,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Rs $price',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _decrementQuantity(title),
                    ),
                    Text(
                      '${_quantities[title]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _incrementQuantity(title),
                    ),
                    const SizedBox(width: 8),
                    const Text('Quantity:'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement add to cart functionality
                    final quantity = _quantities[title] ?? 0;
                    if (quantity > 0) {
                      // Add cake to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('$title added to cart! Quantity: $quantity'),
                        ),
                      );
                    }
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
