import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/theme.dart';

class PlayerTile extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;

  final TextStyle? textStyle;

  const PlayerTile({
    super.key,
   
    this.textStyle,
    required this.text,
    required this.onpressed,
  });

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onpressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _isSelected ?  AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.montserrat(
              color: _isSelected ? Colors.white : AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16, // Adjusted font size
            ),
          ),
        ),
      ),
    );
  }
}