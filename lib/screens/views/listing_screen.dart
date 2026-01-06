import 'package:flutter/material.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Idea Listing Ui",),)
        ],
      ),
    );
  }
}
