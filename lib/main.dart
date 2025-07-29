import 'package:big_g_mini_games/main/ui/main_screen.dart';
import 'package:big_g_mini_games/niners_game/logic/niners_logic.dart';
import 'package:big_g_mini_games/niners_game/ui/nine_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NinersLogic(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) =>  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainScreen(), // or MainScreen() if that's your hub
        ),
      ),
    );
  }
}
