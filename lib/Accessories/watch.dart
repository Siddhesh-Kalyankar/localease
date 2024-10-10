import 'package:flutter/material.dart';

class WatchPage extends StatefulWidget {
  @override
  _WatchPageState createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  // This map will hold the quantities of each watch
  Map<String, int> _quantities = {
    'Analog Watch': 0,
    'Digital Watch': 0,
    'Smart Watch': 0,
  };

  void _incrementQuantity(String watchName) {
    setState(() {
      _quantities[watchName] = (_quantities[watchName] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String watchName) {
    setState(() {
      if (_quantities[watchName] != null && _quantities[watchName]! > 0) {
        _quantities[watchName] = _quantities[watchName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch Menu'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWatchCard(
              'assets/images/watch 1.jpeg', // Replace with your image path
              'Analog Watch',
              2500,
            ),
            const SizedBox(height: 16),
            _buildWatchCard(
              'assets/images/watch 2.jpeg', // Replace with your image path
              'Gshock Watch',
              3000,
            ),
            const SizedBox(height: 16),
            _buildWatchCard(
              'assets/images/watch3.jpg', // Replace with your image path
              'Rolex Watch',
              5000,
            ),
            // Add more watch cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildWatchCard(String imagePath, String title, double price) {
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
                      // Add watch to cart
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
