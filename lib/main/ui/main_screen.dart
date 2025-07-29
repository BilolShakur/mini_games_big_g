import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:big_g_mini_games/niners_game/ui/nine_screen.dart';
import 'package:big_g_mini_games/reaction_game/core/images.dart';
import 'package:big_g_mini_games/reaction_game/ui/reaction_game_ui.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final Random random = Random();
  List<Offset> positions = [];

  final List<String> games = [
    "assets/images/reaction_game.png",
    "assets/images/niners_game.png",
  ];

  final List<Widget> screens = [GameUi(), NineScreen()];

  @override
  void initState() {
    super.initState();
    // Initialize positions for each icon
    positions = List.generate(games.length, (_) => randomOffset());
    Timer.periodic(Duration(seconds: 3), (_) => moveIcons());
  }

  Offset randomOffset() {
    return Offset(random.nextDouble(), random.nextDouble());
  }

  void moveIcons() {
    setState(() {
      positions = List.generate(games.length, (_) => randomOffset());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          ),
          ...List.generate(games.length, (index) {
            final pos = positions[index];
            return AnimatedPositioned(
              duration: Duration(seconds: 3),
              curve: Curves.easeInOut,
              left: pos.dx * (screenSize.width - 80),
              top: pos.dy * (screenSize.height - 80),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => screens[index]),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(games[index], height: 100),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
