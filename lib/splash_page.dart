import 'package:flutter/material.dart';
import 'package:netflix_ui/utils/color.dart';
import 'dash_board.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: AppColors.black,

      body: Center(
        child: Text(
          'Netflix UI',
          style: TextStyle(
            color: AppColors.darkRed,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

