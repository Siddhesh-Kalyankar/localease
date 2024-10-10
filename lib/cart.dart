import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>>
      cartItems; // Change to List<Map<String, dynamic>>

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final productName = cartItems[index]['name'];
                final quantity = cartItems[index]['quantity'];
                return ListTile(
                  title: Text(productName),
                  subtitle: Text('Quantity: $quantity'),
                );
              },
            ),
    );
  }
}
