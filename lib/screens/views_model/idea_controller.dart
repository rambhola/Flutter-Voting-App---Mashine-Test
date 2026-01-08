import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdeaModel {
  final String title;
  final String tagline;
  final String description;
  final int score;
  final int totalVotes;
  final Gradient gradient;
  bool isFavorite;

  IdeaModel({
    required this.title,
    required this.tagline,
    required this.description,
    required this.score,
    required this.totalVotes,
    required this.gradient,
    this.isFavorite = false,
  });
}

class IdeaController extends GetxController {
  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxString searchText = ''.obs;
  final RxBool sortByRating = true.obs;

  void addIdea(IdeaModel idea) {
    ideas.add(idea);
  }

  void toggleFavorite(IdeaModel idea) {
    idea.isFavorite = !idea.isFavorite;
    ideas.refresh();
  }
}
