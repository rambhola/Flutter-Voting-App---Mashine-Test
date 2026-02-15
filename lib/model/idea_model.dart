import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'idea_model.g.dart';

@HiveType(typeId: 0)
class IdeaModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String tagline;

  @HiveField(2)
  String description;

  @HiveField(3)
  int score;

  @HiveField(4)
  int votes;

  @HiveField(5)
  bool isFavorite;

  @HiveField(6)
  List<int> gradientColors;

  @HiveField(7)
  String badge;




  IdeaModel({
    required this.title,
    required this.tagline,
    required this.description,
    this.score = 0,
    this.votes = 0,
    this.isFavorite = false,
    this.badge = '⭐',
    required this.gradientColors,
  });

  LinearGradient get gradient =>
      LinearGradient(colors: gradientColors.map((c) => Color(c)).toList());
}
