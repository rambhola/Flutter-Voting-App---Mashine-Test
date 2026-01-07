import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdeaModel {
  final String title;
  final String tagline;
  final int score;
  final int totalVotes;
  final Gradient gradient;
  bool isFavorite;

  IdeaModel({
    required this.tagline,
    required this.title,
    required this.score,
    required this.totalVotes,
    required this.gradient,
    this.isFavorite = false,
  });
}

class IdeaController extends GetxController {
  RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  RxString searchText = ''.obs;
  RxBool sortByRating = true.obs;

  void toggleFavorite(IdeaModel idea) {
    idea.isFavorite = !idea.isFavorite;


  /// Text field controller
  final TextEditingController ideaTextController =
  TextEditingController();

  /// Submitted ideas list
  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;

  /// Submit idea
  void submitIdea() {
    if (ideaTextController.text.trim().isEmpty) return;

    final idea = IdeaModel(
      title: ideaTextController.text.trim(),
      tagline: ideaTextController.text.trim(),
      score: 0,
      totalVotes: 0,
      gradient: const LinearGradient(
        colors: [Color(0xff7F00FF), Color(0xff3F8EFC)],
      ),
    );

    ideas.add(idea);

    ideaTextController.clear();
  }

  /// Toggle favorite
  void toggleFavorite(int index) {
    ideas[index].isFavorite = !ideas[index].isFavorite;
    ideas.refresh();
  }

  @override
  void onClose() {
    ideaTextController.dispose();
    super.onClose();
  }
}}
