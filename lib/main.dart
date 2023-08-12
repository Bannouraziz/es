import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:estichara/onboardscreen/onboard.dart';
import 'package:estichara/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App Name',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: OnBoardingScreen(),
          );
        });
  }
}
