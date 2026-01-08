import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tagline': tagline,
      'description': description,
      'score': score,
      'totalVotes': totalVotes,
      'isFavorite': isFavorite,
    };
  }

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      title: json['title'],
      tagline: json['tagline'],
      description: json['description'],
      score: json['score'],
      totalVotes: json['totalVotes'],
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.blue],
      ), // default gradient
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

class IdeaController extends GetxController {
  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxString searchText = ''.obs;
  final RxBool sortByRating = true.obs;

  static const String _storageKey = 'ideas_list';

  @override
  void onInit() {
    super.onInit();
    loadIdeas();
  }

  void addIdea(IdeaModel idea) {
    ideas.add(idea);
    saveIdeas();
  }

  void toggleFavorite(IdeaModel idea) {
    idea.isFavorite = !idea.isFavorite;
    ideas.refresh();
    saveIdeas();
  }

  Future<void> saveIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(ideas.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> loadIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data != null) {
      final List decoded = jsonDecode(data);
      ideas.assignAll(decoded.map((e) => IdeaModel.fromJson(e)).toList());
    }
  }

  Future<void> clearIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    ideas.clear();
  }
}
