import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          
        },
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splashbg.png"), // Your image path
                fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
              ),
            ),
            child: Column(
              children: [
                Image.asset('assets/loginimg.png'),
                Text(
                  'Welcome to GuessGenius',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Text(
                    'Get ready to challenege your luck and luckl! GuessGenius is a fun and addictive number guessing game. Can you guess the secret number in as few attempt as possible',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700)),
              ],
            )),
      ),
    );
  }
}
