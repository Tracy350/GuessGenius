import 'package:hive_flutter/hive_flutter.dart';


class GameDatabase {
  late Box _testBox;
  List<List<dynamic>> playerList = []; // [name, score]

  GameDatabase() {
    _testBox = Hive.box('testBox');
  }

  // Create initial data if the box is empty
  void createInitialData() {
    playerList = [
      ['Player 1', 0],
      ['Player 2', 0],
    ];
    updateDatabase();
  }

  // Load data from Hive
void loadData() {
  var savedPlayerList = _testBox.get('playerList');
  if (savedPlayerList != null) {
    playerList = List<List<dynamic>>.from(savedPlayerList);
  } else {
    // Fallback to initial data if no saved list exists
    createInitialData();
  }
}

  // Save the player list to Hive
  void updateDatabase() {
    _testBox.put('playerList', playerList);
  }

  // Add a new player
  void addNewPlayer(String name) {
    playerList.add([name, 0]);
    updateDatabase();
  }

  // Update a player's score
  void updatePlayerScore(int index, int newScore) {
    playerList[index][1] = newScore;
    updateDatabase();
  }
}
