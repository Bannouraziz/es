import 'package:estichara/onboardscreen/page1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:estichara/onboardscreen/onboard.dart';
import 'package:estichara/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Name',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: 
      OnBoardingScreen(), 
        );
  }
}
