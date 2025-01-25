import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/models/game_data.dart';
import 'package:guessgenius/screens/scoreboard_screen.dart';
import 'package:guessgenius/theme.dart';
import 'package:guessgenius/widgets/my_button.dart';
import 'package:guessgenius/widgets/my_textfield.dart';
import 'package:guessgenius/widgets/start_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameScreen extends StatefulWidget {
  
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isMuted = false;
  bool isLoading = true; // Loading state
  int currentroundindex = 1;
  int currentScore = 0;
  int? randomCorrectAnswer; // Store the random correct answer
  TextEditingController userinput = TextEditingController();
  final List<GameData> gameData = [];

  @override
  void initState() {
    super.initState();
    populateGameData(); // Populate game data on init
  }

  // Method to populate game data and store in Hive
  void populateGameData() async {
    setState(() {
      isLoading = true; // Start loading
    });

    gameData.clear();

    final box = await Hive.openBox('gameDataBox'); // Open Hive box

    for (int i = 0; i <= 20; i++) {
      // Ensure lower limit is less than upper limit
      final lowerLimit = Random().nextInt(100);
      final upperLimit = lowerLimit + Random().nextInt(50) + 1;

      // Ensure the correct answer is strictly between lowerLimit and upperLimit (inclusive)
      final correctAnswer =
          lowerLimit + Random().nextInt(upperLimit - lowerLimit + 1);

      await box.put('round_$i', correctAnswer); // Store correct answer in Hive

      final hint = "The number is between $lowerLimit and $upperLimit."; // Hint
print(lowerLimit);
print(upperLimit);
print('Correct answer is: $correctAnswer');
      gameData.add(GameData(
        lowerlimit: lowerLimit,
        upperlimit: upperLimit,
        answer: correctAnswer,
        hint: hint,
      ));
    }

    // Refresh UI
    setState(() {
      isLoading = false; // End loading
    });
  }

void getScores(){
  
}
  // Method to retrieve all correct answers from Hive
  Future<List<int>> getAllCorrectAnswers() async {
    final box = await Hive.openBox('gameDataBox');

    List<int> correctAnswers = [];
    for (int i = 0; i < 20; i++) {
      final answer = box.get('round_$i');
      if (answer != null) {
        correctAnswers.add(answer);
      }
    }

    return correctAnswers;
  }

  // Method to randomly select a correct answer from the series
  Future<int> getRandomCorrectAnswer() async {
    final correctAnswers = await getAllCorrectAnswers();

    if (correctAnswers.isEmpty) {
      throw Exception("No correct answers available.");
    }

    // Filter correct answers to only include the answers for the current round
    final currentRoundAnswer = gameData[currentroundindex].answer;

    return currentRoundAnswer;
  }

  // Submit guess and compare with the random correct answer
  submitGuess() async {
    final userAnswer = int.tryParse(userinput.text);

    try {
      final correctAnswer = gameData[currentroundindex].answer;
      setState(() {
        randomCorrectAnswer = correctAnswer; // Store the correct answer
      });

      if (userAnswer == randomCorrectAnswer) {
        currentScore++;
        guessnumbersuccess();
      } else {
        guessnumberfailed();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Clear the text field and update the UI
      setState(() {
        userinput.clear();
      });
    }

    if (currentroundindex == 20) {
      return ScoreboardScreen();
    }
  }

  void guessnumbersuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/success.png',
            scale: 1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Avoid unnecessary space
          children: [
            Text(
              'You got it right!',
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              moveToNextRound();
            },
            child: const Text('Next Round'),
          ),
        ],
      ),
    );
  }

  void guessnumberfailed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/failed.png',
            scale: 1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Avoid unnecessary space
          children: [
            Text(
              'You got it wrong!',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'The correct answer is: ',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.red),
                  ),
                  TextSpan(
                    text: randomCorrectAnswer?.toString() ?? 'N/A',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              moveToNextRound();
            },
            child: const Text('Next Round'),
          ),
        ],
      ),
    );
  }

  void moveToNextRound() {
    if (currentroundindex < 20) {
      setState(() {
        currentroundindex++;
      });
    } else {
      endGame();
    }
  }

  void endGame() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: const Text("Check the scoreboard for your results!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScoreboardScreen()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close(); // Close Hive box
  }

  @override
  Widget build(BuildContext context) {
    if (gameData.isEmpty) {
      // Display a loading indicator if gameData is empty
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : buildGameUI(),
    );
  }

  Widget buildGameUI() {
    var currentround = gameData[currentroundindex]; // Safe access
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gamebg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _buildContainer('Score: $currentScore'),
                          const SizedBox(height: 20),
                          _buildContainer('Round $currentroundindex')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMuted = !isMuted;
                              });
                            },
                            child: StartIcons(
                              icon:
                                  isMuted ? Icons.volume_off : Icons.volume_up,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: StartIcons(icon: Icons.close),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: MyTextfield(
                          controller: userinput,
                          keyboardType: TextInputType.number,
                          textstyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        currentround.hint,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: MyButton(
                onpressed: submitGuess,
                text: 'GUESS!',
                textStyle: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String text) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
