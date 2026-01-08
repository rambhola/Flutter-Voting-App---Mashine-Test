import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeaModel {
  final String title;
  final String tagline;
  final String description;
  final int score;
  int rank;
  int votes;
  final Gradient gradient;
  Color? medalColor;
  String badge;
  bool isFavorite;

  IdeaModel({
    required this.title,
    required this.tagline,
    required this.description,
     this.score = 0,
    this.rank = 0,
    required this.badge,
    this.votes = 0,
    required this.gradient,

    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tagline': tagline,
      'description': description,
      'score': score,
      'totalVotes': votes,
      'rank': rank,
      'badge': badge,
      'isFavorite': isFavorite,
    };
  }

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      title: json['title'],
      tagline: json['tagline'],
      description: json['description'],
      score: json['score'],
      rank: json['rank'],
      badge: json['badge'],

      votes: json['votes'],
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.blue],
      ), // default gradient
      isFavorite: json['isFavorite'],
    );
  }
}

class IdeaController extends GetxController {
  final RxSet<String> votesIdeas = <String>{}.obs;
  static const String _voteKey = 'votes_idea';
  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxString searchText = ''.obs;
  final RxBool sortByRating = true.obs;
  final RxBool sortByVotes = false.obs;


  static const String _storageKey = 'ideas_list';

  @override
  void onInit() {
    super.onInit();
    loadVotes();
    loadIdeas();
  }

  void addIdea(IdeaModel idea) {
    ideas.add(idea);
    saveIdeas();
  }

  //update idea
  void updateIdea(IdeaModel updateIdea) {
    final index = ideas.indexWhere(
          (idea) => idea.title == updateIdea.title,
    );

    if (index != -1) {
      ideas[index] = updateIdea;
      ideas.refresh();
      saveIdeas();
    }
  }


  void toggleFavorite(IdeaModel idea) {
    idea.isFavorite = !idea.isFavorite;
    ideas.refresh();
    saveIdeas();
  }


  void voteIdea(IdeaModel idea){
    if(votesIdeas.contains(idea.title)){
      Get.snackbar("Already Voted", 'You can vote only once');
      return;
    }
    idea.votes++;
    votesIdeas.add(idea.title);
    saveVotes();
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
  Future<void> loadVotes() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_voteKey) ?? [];
    votesIdeas.addAll(list);
  }

  Future<void> saveVotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_voteKey, votesIdeas.toList());
  }


  Future<void> clearIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    ideas.clear();
  }
}
