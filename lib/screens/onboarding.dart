import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/screens/intro_screens/intro_page_1.dart';
import 'package:guessgenius/screens/intro_screens/intro_page_2.dart';
import 'package:guessgenius/screens/intro_screens/intro_page_3.dart';
import 'package:guessgenius/screens/intro_screens/intro_page_4.dart';
import 'package:guessgenius/screens/startpage.dart';
import 'package:guessgenius/theme.dart';
import 'package:guessgenius/widgets/my_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splashbg.png"), // Your image path
              fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
            ),
          ),
          child: Stack(
            children: [
              PageView(
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 3);
                  });
                },
                controller: _controller,
                children: [
                  IntroPage1(),
                  IntroPage2(),
                  IntroPage3(),
                  IntroPage4(),
                ],
              ),
              Container(
                  alignment: Alignment(0, 0.75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(3);
                          },
                          child: MyButton(
                              text: 'Skip',
                              textStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                              width: 100,
                              height: 50,
                              color: Colors.white)),
                      SmoothPageIndicator( controller: _controller, count: 4, ),
                      onLastPage
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Startpage();
                                }));
                              },
                              child: MyButton(
                                  text: 'Done',
                                  textStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                  width: 100,
                                  height: 50,
                                  color: AppColors.primaryColor))
                          : GestureDetector(
                              onTap: () {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: MyButton(
                                text: 'Next',
                                textStyle: GoogleFonts.montserrat(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600),
                                width: 100,
                                height: 50,
                                color: Colors.white,
                              ))
                    ],
                  ))
            ],
          )),
    );
  }
}
