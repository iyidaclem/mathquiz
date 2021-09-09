import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questions with ChangeNotifier {
  int highScore = 0;
  int score = 0;
  int num1 = 0;
  int num2 = 0;
  late int sum;
  String isPlaying = "0"; // 0 - not started, 2- game over, 3 - playing
  bool _havePlayed = false;
  late Timer _timer;
  int _start = 10;
  List answers = [0, 0, 0, 0];
  bool haveFetched = false;



  int get getScore {
    return score;
  }

   int get getHighScore {
    return highScore;
  }

  String get getStatus {
    return isPlaying;
  }

  int get getTime {
    return _start;
  }

  bool get havePlayed {
    return _havePlayed;
  }

  void startTimer() {
    // generating to numbers
    num1 = Random().nextInt(100);
    num2 = Random().nextInt(100);
    sum = num1 + num2;
    answers = [
      sum,
      Random().nextInt(200),
      Random().nextInt(200),
      Random().nextInt(200)
    ];
    answers.shuffle();
    isPlaying = "3";

    notifyListeners();

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          isPlaying = "0";
          _havePlayed = true;
          _start = 10;
          score = 0;
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }

  void chooseAnswer(x) {
    if (x == sum) {
      score += 2;
      if(score>highScore){highScore = score; setHighScore(score);}
      _timer.cancel();
      _havePlayed = true;
      isPlaying = "3";
      _start = 10;
      startTimer();
      notifyListeners();
    } else {
      isPlaying = "0";
     _start = 0;
     score = 0;
      notifyListeners();
    }
  }

 Future<void> setHighScore(x) async {
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
   await _prefs.setInt("highScore", x);
 
    
  }
  Future<void> fetchHighScore() async {
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    highScore =  _prefs.getInt("highScore") as int;
    notifyListeners();
    
  }

  

 
}
