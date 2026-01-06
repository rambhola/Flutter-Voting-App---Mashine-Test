import 'package:flutter/material.dart';

class IdeaCard extends StatefulWidget {
  const IdeaCard({super.key});

  @override
  State<IdeaCard> createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(" Reusable idea cart components ",),)
        ],
      ),
    );
  }
}
