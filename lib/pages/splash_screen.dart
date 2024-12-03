import 'package:flutter/material.dart';
import 'package:student_app_getx/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    duration(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:Image(image: NetworkImage("https://cdn.pixabay.com/animation/2024/07/04/04/08/04-08-19-558_512.gif")),
      ),
    );
  }

  Future<void>duration(context)async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
      return const HomeScreen();
    }));
  }
}