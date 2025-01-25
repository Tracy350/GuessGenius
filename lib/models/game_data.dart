

import 'package:flutter/material.dart';

class GameData {
  final int? round;
  final String hint;
  final int lowerlimit;  // Value for x
  final int upperlimit;  // Value for y
  final int answer;

  GameData({
      this.round,
    required this.hint,
    required this.lowerlimit,
    required this.upperlimit,
    required this.answer,
  });
}
