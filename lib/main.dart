// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';

// Game rules:
// Two players will be able to play this game.
// Each player will roll the dice turn by turn,
// Winner will be the player who get 1 on both dices first.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int dice1 = 0;
  int dice2 = 0;
  int currentPlayer = 1;
  String result = 'Player One is Winner';
  bool isActiveRestart = false;

  void rollDice() {
    setState(() {
      result = '';
      dice1 = Random().nextInt(6) + 1;
      dice2 = Random().nextInt(6) + 1;
    });
  }

  void playerOne() {
    rollDice();
    if (dice1 == 1 && dice2 == 1) {
      setState(() {
        isActiveRestart = true;
        currentPlayer = 0;
        result = winner('Player One');
      });
      return;
    } else {
      currentPlayer = 2;
    }
  }

  void playerTwo() {
    rollDice();
    if (dice1 == 1 && dice2 == 1) {
      setState(() {
        isActiveRestart = true;
        currentPlayer = 0;
        result = winner('Player Two');
      });
      return;
    } else {
      currentPlayer = 1;
    }
  }

  String winner(String win) {
    return "Snack Eyes! $win is winner";
  }

  void restart() {
    setState(() {
      isActiveRestart = false;
      dice1 = dice2 = 0;
      currentPlayer = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack Eyes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Snack Eyes"),
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.rotate(
                      angle: pi,
                      alignment: Alignment.center,
                      child: Container(
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: ElevatedButton(
                              onPressed: currentPlayer == 1
                                  ? () {
                                      if (currentPlayer == 1) {
                                        playerOne();
                                      }
                                    }
                                  : null,
                              child: const Text("Player 1 Roll"))),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/$dice1.png',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'images/$dice2.png',
                          fit: BoxFit.cover,
                        )
                      ]),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20, left: 10),
                      child: ElevatedButton(
                          onPressed: currentPlayer == 2
                              ? () {
                                  if (currentPlayer == 2) {
                                    playerTwo();
                                  }
                                }
                              : null,
                          child: const Text("Player 2 Roll")),
                    )
                  ],
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                  onPressed: isActiveRestart ? restart : null,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text("Restart"))
            ])),
      ),
    );
  }
}
