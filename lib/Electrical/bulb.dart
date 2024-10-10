import 'package:flutter/material.dart';

class BulbPage extends StatelessWidget {
  const BulbPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bulb Page"),
      ),
      body: Center(
        child: const Text(
          "This is a bulb page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
