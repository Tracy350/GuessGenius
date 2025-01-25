import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guessgenius/data/database.dart';
import 'package:guessgenius/screens/game_screen.dart';
import 'package:guessgenius/theme.dart';
import 'package:guessgenius/widgets/my_button.dart';
import 'package:guessgenius/widgets/my_textfield.dart';
import 'package:guessgenius/widgets/player_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  final username = TextEditingController();
  final _testBox = Hive.box('testBox');
  GameDatabase db = GameDatabase();
  bool _isPlayerSelected = false;

  @override
  void initState() {
    super.initState();
    if (_testBox.get("playername") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  // Save new player
  void saveNewPlayer(String name) {
    setState(() {
      db.playerList.add([name, 0]); // Add new player with default score
      db.updateDatabase();
    });
    Navigator.pop(context); // Close modal
  }

  // Player selection toggle
  void playerSelect(bool value, int index) {
    setState(() {
      db.playerList[index][1] = value ? 1 : 0; // Update state
      _isPlayerSelected = value; // Update selection state
      db.updateDatabase();
    });
  }

  // Create new player modal
  void createNewPlayer() {
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
            children: [
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
                controller: username,
                hint: 'Name',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              MyButton(
                onpressed: () {
                  if (username.text.isNotEmpty) {
                    saveNewPlayer(username.text);
                    username.clear(); // Clear text field
                  }
                },
                text: 'Add Player',
                textStyle: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                width: double.infinity,
                height: 50,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
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
                SizedBox(height: 20),
                Flexible(
                  child: ListView.builder(
                    itemCount: db.playerList.length,
                    itemBuilder: (context, index) {
                      return PlayerTile(
                          text: db.playerList[index][0],
                          onpressed: () => playerSelect(true, index));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyButton(
                    text: 'START',
                    onpressed: () {
                      if (_isPlayerSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      } else {
                        print('player not selected');
                      }
                    },
                    textStyle: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: createNewPlayer,
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
    );
  }
}