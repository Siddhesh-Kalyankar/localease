import 'package:flutter/material.dart';

class HatPage extends StatefulWidget {
  @override
  _HatPageState createState() => _HatPageState();
}

class _HatPageState extends State<HatPage> {
  // This map will hold the quantities of each hat
  Map<String, int> _quantities = {
    'Baseball Cap': 0,
    'Beanie': 0,
    'Sun Hat': 0,
  };

  void _incrementQuantity(String hatName) {
    setState(() {
      _quantities[hatName] = (_quantities[hatName] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String hatName) {
    setState(() {
      if (_quantities[hatName] != null && _quantities[hatName]! > 0) {
        _quantities[hatName] = _quantities[hatName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hat Menu'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHatCard(
              'assets/images/cap 1.jpeg', // Replace with your image path
              'Red Cap',
              500,
            ),
            const SizedBox(height: 16),
            _buildHatCard(
              'assets/images/cap2.jpg', // Replace with your image path
              'Silver Cap',
              300,
            ),
            const SizedBox(height: 16),
            _buildHatCard(
              'assets/images/cap3.jpg', // Replace with your image path
              'Purple cap',
              700,
            ),
            // Add more hat cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildHatCard(String imagePath, String title, double price) {
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
                      // Add hat to cart
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
