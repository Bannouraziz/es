import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:estichara/onboardscreen/onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:estichara/surveys/surveyslist.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SurveyList().fetchSurveysAndImageURLs() ; 
  // FirebaseCrashlytics.instance.crash();
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
