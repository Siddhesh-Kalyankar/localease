import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login/chatbot.dart';
import 'package:image_picker/image_picker.dart';
import 'analytical.dart'; // Import the Analytical page

class SellerPage extends StatefulWidget {
  final Function(String, String, String) onAddShop;

  const SellerPage({Key? key, required this.onAddShop}) : super(key: key);

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final _formKey = GlobalKey<FormState>();
  String _shopName = '';
  String _shopImage = '';
  String _selectedCategory = 'Food';
  File? _imageFile;

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _shopImage = pickedImage.path; // Use the picked image path
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddShop(_selectedCategory, _shopName, _shopImage);
      Navigator.pop(context);
    }
  }

  // Navigate to Chatbot Page
  void _navigateToChatbot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chatbot()),
    );
  }

  // Navigate to Analytical Page
  void _navigateToAnalytical() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnalyticalPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Shop'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: _navigateToChatbot,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a shop name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _shopName = value!;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: ['Food', 'Accessories', 'Clothes', 'Electrical']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Shop'),
                ),
                const SizedBox(height: 16), // Add space before the new button
                ElevatedButton(
                  onPressed: _navigateToAnalytical,
                  child: const Text('Go to Analytical Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
