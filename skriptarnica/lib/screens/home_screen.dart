import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Helo world',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Hello World'),
          ),
        ],
      ),
    ));
  }
}
