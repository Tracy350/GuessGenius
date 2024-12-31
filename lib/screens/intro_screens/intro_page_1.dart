import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splashbg.png"), // Background image path
            fit: BoxFit.cover, // Covers the entire background
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/loginimg.png',
              // Adjust the height as needed
            ),
            Spacer(), // Push the text to the center
            // Centered text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Enter your first guess in the input field',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white, // Customize the color if necessary
                ),
              ),
            ),
            Spacer(), // Fills the remaining space to keep text centered
          ],
        ),
      ),
    );
  }
}
