import 'dart:async';
import 'dart:math';
import 'package:big_g_mini_games/reaction_game/core/images.dart';
import 'package:big_g_mini_games/reaction_game/extensions/average_on_list.dart';
import 'package:big_g_mini_games/reaction_game/logic/gam_logic.dart';
import 'package:big_g_mini_games/reaction_game/ui/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameUi extends StatefulWidget {
  const GameUi({super.key});

  @override
  State<GameUi> createState() => _GameUiState();
}

class _GameUiState extends State<GameUi> {
  Offset position = Offset(10.w, 20.h);
  bool hide = false;
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  double reactionTime = 0.0;
  List<double> reactionTimes = [];
  bool isPaused = false;

  String ballImagePath = AppImages.wat;

  final GameLogic logic = GameLogic();
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _startNewRound();
  }

  void _startStopwatch() {
    stopwatch.reset();
    stopwatch.start();
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        reactionTime = stopwatch.elapsedMicroseconds / 1000.0;
      });
    });
  }

  void pauseGame() {
    if (!isPaused) {
      stopwatch.stop();
      timer?.cancel();
      setState(() {
        isPaused = true;
      });
    } else {
      stopwatch.start();
      timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          reactionTime = stopwatch.elapsedMicroseconds / 1000.0;
        });
      });
      setState(() {
        isPaused = false;
      });
    }
  }

  Future<void> _startNewRound() async {
    hide = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500 + random.nextInt(2000)));
    if (mounted) {
      position = logic.changeOffset(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width,
      );
    }

    hide = false;
    _startStopwatch();

    setState(() {});
  }

  void _onTap() {
    stopwatch.stop();
    timer?.cancel();

    if (reactionTime != 0) {
      reactionTimes.add(reactionTime);
    }

    reactionTime = 0;
    _startNewRound();
  }

  void changeBall(String imagePath) {
    ballImagePath = imagePath;
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 150.h,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_app_bar.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Column(
          children: [
            Text("Taps: ${reactionTimes.length}"),
            Text("Average: ${reactionTimes.average.toStringAsFixed(0)} ms"),
            Text("Best: ${reactionTimes.lowest.toStringAsFixed(0)} ms"),
            if (reactionTimes.isNotEmpty)
              Text("Last: ${reactionTimes.last.toStringAsFixed(2)} ms"),
            Text("Current: ${reactionTime.toStringAsFixed(0)} ms"),
          ],
        ),
        leadingWidth: 100.w,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 8.w),
            IconButton.filledTonal(
              color: Colors.white,
              onPressed: () {
                reactionTimes.clear();
                reactionTime = 0.0;
                setState(() {});
                _startNewRound();
              },
              icon: Icon(Icons.restart_alt, color: Colors.red, size: 40.r),
            ),
            SizedBox(height: 15.h),
            IconButton.filledTonal(
              color: Colors.white,
              onPressed: pauseGame,
              icon: isPaused
                  ? Icon(Icons.play_arrow, color: Colors.red, size: 40.r)
                  : Icon(Icons.pause, color: Colors.red, size: 40.r),
            ),
          ],
        ),
        actions: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(height: 20),

              PopupMenuButton<String>(
                onSelected: changeBall,
                itemBuilder: (context) {
                  return [
                    AppImages.coke,
                    AppImages.con,
                    AppImages.creator,
                    AppImages.cuc,
                    AppImages.egg,
                    AppImages.leb,
                    AppImages.onion,
                    AppImages.pat,
                    AppImages.pep,
                    AppImages.rdj,
                    AppImages.wat,
                    AppImages.wd,
                    AppImages.yest,
                  ].map((imagePath) {
                    return PopupMenuItem<String>(
                      value: imagePath,
                      child: Image.asset(
                        imagePath,
                        height: 70.h,
                        width: 50.w,
                        fit: BoxFit.contain,
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_game.jpg', fit: BoxFit.cover),
          ),
          if (!hide)
            Positioned(
              left: position.dx,
              top: position.dy,
              child: GestureDetector(
                onTap: _onTap,
                child: CircleButton(imagePath: ballImagePath),
              ),
            ),
        ],
      ),
    );
  }
}
