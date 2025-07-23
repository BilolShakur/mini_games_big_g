import 'dart:async';
import 'dart:math';

import 'package:big_g_mini_games/reaction_game/core/images.dart';
import 'package:big_g_mini_games/reaction_game/ui/reaction_game_ui.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final Random random = Random();
  List<Offset> positions = [];

  @override
  void initState() {
    super.initState();

    positions = List.generate(1, (_) => randomOffset());
    // Start movement loop
    Timer.periodic(Duration(seconds: 3), (_) => moveIcons());
  }

  Offset randomOffset() {
    return Offset(random.nextDouble(), random.nextDouble());
  }

  void moveIcons() {
    setState(() {
      positions = List.generate(5, (_) => randomOffset());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    List games = [
      "assets/images/reaction_game.png",
      AppImages.bgGame,
      AppImages.bgAppBar,
      AppImages.yest,
      AppImages.cuc,
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          ),
          Stack(
            children: List.generate(1, (index) {
              final pos = positions[index];
              return AnimatedPositioned(
                duration: Duration(seconds: 3),
                curve: Curves.easeInOut,
                left: pos.dx * (screenSize.width - 60),
                top: pos.dy * (screenSize.height - 60),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameUi()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.asset(games[index], height: 100),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
