import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/db/functions/db_functions.dart';
import 'package:student_app_getx/pages/home_screen.dart';
import 'package:student_app_getx/pages/splash_screen.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeData();
  getAllStudent();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: const SplashScreen(),
      routes: {
        'HomeScreen':(context)=>const HomeScreen()
      },
    );
  }
}