import 'package:flutter/material.dart';

class BurgerPage extends StatefulWidget {
  @override
  _BurgerPageState createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
  // This map will hold the quantities of each burger
  Map<String, int> _quantities = {
    'Classic Burger': 0,
    'Cheeseburger': 0,
    'Veggie Burger': 0,
  };

  void _incrementQuantity(String burgerName) {
    setState(() {
      _quantities[burgerName] = (_quantities[burgerName] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String burgerName) {
    setState(() {
      if (_quantities[burgerName] != null && _quantities[burgerName]! > 0) {
        _quantities[burgerName] = _quantities[burgerName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burger Menu'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBurgerCard(
              'assets/images/burger 1.jpeg', // Replace with your image path
              'Classic Burger',
              150,
            ),
            const SizedBox(height: 16),
            _buildBurgerCard(
              'assets/images/burger 2.jpeg', // Replace with your image path
              'Cheeseburger',
              200,
            ),
            const SizedBox(height: 16),
            _buildBurgerCard(
              'assets/images/burger 3.jpg', // Replace with your image path
              'Veggie Burger',
              180,
            ),
            // Add more burger cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildBurgerCard(String imagePath, String title, double price) {
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
                      // Add burger to cart
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
