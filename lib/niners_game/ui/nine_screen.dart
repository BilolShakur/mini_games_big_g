import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_g_mini_games/niners_game/logic/niners_logic.dart';

class NineScreen extends StatefulWidget {
  const NineScreen({super.key});

  @override
  State<NineScreen> createState() => _NineScreenState();
}

class _NineScreenState extends State<NineScreen> {
  final Random _random = Random();
  bool _dialogShown = false;

  void _loadRandomLevel(NinersLogic logic, int difficulty) {
    final randomLevel = logic.levels[difficulty]![_random.nextInt(3)];
    logic.loadLevel(randomLevel);
    _dialogShown = false;
  }

  void _checkWin(BuildContext context, NinersLogic logic) {
    if (logic.isWinner && !_dialogShown) {
      _dialogShown = true;

      Future.delayed(const Duration(milliseconds: 300), () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("🎉 You Win!"),
            content: const Text("Well done! All kanyes are happy."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _loadRandomLevel(logic, 2);
                },
                child: const Text("Play Again"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Exit"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final logic = Provider.of<NinersLogic>(context, listen: false);
    logic.generateAllLevels();
    _loadRandomLevel(logic, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/w_bg.jpg", fit: BoxFit.cover),
          ),

          // Back arrow
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
            ),
          ),

          // Level selection buttons
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Consumer<NinersLogic>(
              builder: (context, logic, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _levelButton("Easy", () => _loadRandomLevel(logic, 1)),
                  _levelButton("Medium", () => _loadRandomLevel(logic, 2)),
                  _levelButton("Hard", () => _loadRandomLevel(logic, 3)),
                ],
              ),
            ),
          ),

          // Game Grid
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2),
              ),
              child: Consumer<NinersLogic>(
                builder: (context, logic, _) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _checkWin(context, logic);
                  });

                  return GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: List.generate(9, (index) {
                      return GestureDetector(
                        onTap: () => logic.change(index),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Image.asset(
                            logic.fields[index]
                                ? "assets/images/we_happy.png"
                                : "assets/images/we_sad.png",
                            key: ValueKey<bool>(logic.fields[index]),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade300,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
