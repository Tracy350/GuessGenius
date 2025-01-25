import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/theme.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final TextStyle? textStyle;
  final void Function()? onpressed;


  const MyButton(
      {super.key,
       this.onpressed,
      required this.text,
      required this.width,
      required this.height, required this.color, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
      
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: textStyle
          ),
        ),
      ),
    );
  }
}
