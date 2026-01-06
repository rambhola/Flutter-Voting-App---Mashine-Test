import 'package:flutter/material.dart';

class RatingBadge extends StatefulWidget {
  const RatingBadge({super.key});

  @override
  State<RatingBadge> createState() => _RatingBadgeState();
}

class _RatingBadgeState extends State<RatingBadge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(" Color- Coded rating badge ",),)
        ],
      ),
    );
  }
}
