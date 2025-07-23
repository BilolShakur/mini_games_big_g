import 'dart:math';

import 'package:big_g_mini_games/niners_game/logic/niners_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NineScreen extends StatefulWidget {
  const NineScreen({super.key});

  @override
  State<NineScreen> createState() => _NineScreenState();
}

class _NineScreenState extends State<NineScreen> {
  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/w_bg.jpg", fit: BoxFit.cover),
          ),
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2),
              ),
              child: Consumer<NinersLogic>(
                builder: (BuildContext context, logic, Widget? child) {
                  return GridView.count(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: List.generate(
                      9,
                      (index) => GestureDetector(
                        onTap: () {
                          logic.change(index);
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                          child: Image.asset(
                            logic.fields[index]
                                ? "assets/images/we_sad.png"
                                : "assets/images/we_happy.png",
                            key: ValueKey<bool>(logic.fields[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
