// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:guessgenius/screens/onboarding.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
//   @override 
//   void initState(){
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     Future.delayed(const Duration(milliseconds: 5000),(){
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Onboarding()));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(color: Colors.white),child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/logoimg.png')
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';
import 'package:guessgenius/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration:  BoxDecoration(color: Colors.white),child: Center(child: AnimatedSplash(
          type: Transition.topToBottom,
          curve:Curves.bounceIn,
          durationInSeconds: 1,
          navigator: const Onboarding(),
          child: Image.asset('assets/logoimg.png'))),
      ),
    );
  }
}