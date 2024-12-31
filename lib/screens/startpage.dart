import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/screens/game_screen.dart';
import 'package:guessgenius/theme.dart';
import 'package:guessgenius/widgets/my_button.dart';
import 'package:guessgenius/widgets/my_textfield.dart';

class Startpage extends StatelessWidget {
  const Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/splashbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logoimg.png'),
                  SizedBox(height: 20),
                  Text(
                    'Select your Player',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 70),
                  MyButton(
                    text: 'Player One',
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    width: 200,
                    height: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    text: 'Player Two',
                    textStyle: GoogleFonts.montserrat(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    width: 200,
                    height: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return GameScreen();
                        }));
                      },
                      child: MyButton(
                        text: 'START',
                        textStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Create Account Button at Top-Right
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title for the create account form
                            Text(
                              'New Player',
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            MyTextfield(
                              hint: 'Name',
                              icon: Icons.person,
                            ),

                            SizedBox(height: 20),
                            MyButton(
                              text: 'Add Player',
                              textStyle: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              width: double.infinity, // Full-width button
                              height: 50,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'New Player',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
