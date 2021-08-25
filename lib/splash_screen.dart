import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:what_to_cook/main_menu.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget build(BuildContext context){
    return Column(
      children: [
        AnimatedSplashScreen(
          splash: Image.asset('images/fennec.png'),
          nextScreen: MainMenu(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: Colors.lightBlueAccent,
          duration: 2000,
        ),
        AnimatedSplashScreen(
            splash: Image.asset('undergloups.png'),
            nextScreen: MainMenu()
        )
      ],
    );
  }
}