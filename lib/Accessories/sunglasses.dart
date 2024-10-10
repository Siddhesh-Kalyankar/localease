import 'package:flutter/material.dart';

class SunglassesPage extends StatefulWidget {
  @override
  _SunglassesPageState createState() => _SunglassesPageState();
}

class _SunglassesPageState extends State<SunglassesPage> {
  // This map will hold the quantities of each sunglasses
  Map<String, int> _quantities = {
    'Aviator Sunglasses': 0,
    'Wayfarer Sunglasses': 0,
    'Round Sunglasses': 0,
  };

  void _incrementQuantity(String sunglassesName) {
    setState(() {
      _quantities[sunglassesName] = (_quantities[sunglassesName] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String sunglassesName) {
    setState(() {
      if (_quantities[sunglassesName] != null &&
          _quantities[sunglassesName]! > 0) {
        _quantities[sunglassesName] = _quantities[sunglassesName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunglasses Menu'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSunglassesCard(
              'assets/images/sunglass1.jpeg', // Replace with your image path
              'Aviator Sunglasses',
              1200,
            ),
            const SizedBox(height: 16),
            _buildSunglassesCard(
              'assets/images/sunglass2.jpeg', // Replace with your image path
              'Wayfarer Sunglasses',
              1500,
            ),
            const SizedBox(height: 16),
            _buildSunglassesCard(
              'assets/images/sunglass3.jpg', // Replace with your image path
              'Round Sunglasses',
              1000,
            ),
            // Add more sunglasses cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildSunglassesCard(String imagePath, String title, double price) {
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
                      // Add sunglasses to cart
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
