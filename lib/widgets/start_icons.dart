import 'package:flutter/material.dart';
import 'package:guessgenius/theme.dart';

class StartIcons extends StatelessWidget {
  final IconData icon;
  const StartIcons({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            colors: [AppColors.secondaryColor, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
