import 'dart:math';

import 'package:hive/hive.dart';

// import 'lib/models/user_model.dart:user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  List<int> scores = [];

  void addScore(int score) {
    scores.add(score);
  }

  int get bestScore => scores.isNotEmpty 
      ? scores.reduce((max)) 
      : 0;

  int get averageScore => scores.isNotEmpty 
      ? (scores.reduce((a, b) => a + b) / scores.length).round() 
      : 0;
}